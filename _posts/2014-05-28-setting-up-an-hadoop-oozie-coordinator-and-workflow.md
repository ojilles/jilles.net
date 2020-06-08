---
title: Setting up a Hadoop Oozie Coordinator and Workflow
# vim: set ts=2 sw=2 tw=80 ft=markdown et si :
layout: post
image:
  feature: elephants.jpg
  credits: https://www.flickr.com/photos/blieusong/7234335792/
  uicolor: light
categories:
  - Technology
---
After many frustrating hours of tweaking I have finally setup a working
[Oozie](https://oozie.apache.org/)
[Coordinator](https://oozie.apache.org/docs/3.1.3-incubating/CoordinatorFunctionalSpec.html)
plus associated
[Workflow](https://oozie.apache.org/docs/3.1.3-incubating/WorkflowFunctionalSpec.html)
on [Hadoop](http://hadoop.apache.org) (in my case
[Cloudera](http://www.cloudera.com/content/cloudera/en/about/hadoop-and-big-data.html)'s
distribution). This was quite frustrating because of many small problems that
are completely non-intuitive and not documented. Error messages that you get
back from a distributed system are mostly non-descriptive from the developers
perspective. So I thought I should write this down so that others can benefit
(and for myself to have a canonical write up). I'm not the first [^1] person to
do this, but I figured we can collectively use more shared experiences on the
 internet. At the very least Yahoo released some documentation in the past that
 is helpfully practical[^2].

### The Starting Conditions
I'm assuming you have a Hadoop cluster with Oozie running already. In my case I
have data coming into `/user/app/dc{1,2}/year/month/day/`. The scenario
described here assumes we are setting up a Coordinator for a specific
application that runs in two data centers across multiple machines. Every night
the JSON-formatted source data are uploaded. Let's imagine that we want to
search through those logs on a particular keyword (or in our example, IP
address), then order any matching records by time and store the results.

What we want to achieve here is that this happens automagically, for past and
future data with some level of fault tolerance. We will build up the solution
from lowest level up:

`Pig Action -> Workflow -> Coordinator ( -> Bundle )`

One can couple a few associated coordinators together as one deployment unit
called a Bundle. This can come in handy to build out a bigger "Data Pipeline"
(see here, for example, a [write up of Tapad and Stripe's data
pipelines](http://www.hakkalabs.co/articles/big-small-hot-or-cold-your-data-needs-a-robust-pipeline-examples-from-stripe-tapad-etsy-square)).
From an Oozie perspective, actually all of these are optional, letting you
start off as small as you would like.

All source material can be found in [the following Github
Gist](https://gist.github.com/ojilles/1dd2e9931e3fc02666e0).

### Pig Action
The imagined use case is that I would like to have all the incoming data
scanned for a particular Regex such as a set of source IP addresses. If found
reconstitute a timeline for that IP address then safe off the timestamps. The
input for this process is a JSON accesslog from a relatively large application,
and paraphrased, looks like this (two randomized entries):

{% highlight json %}
{"requestIp":"22.249.73.204","url":"http://www.example.com/zlkasdfj/url.extension.html",
"date":1366788978906,"userAgent":"Mozilla/5.0","requestTimeMillis":209,
"dispatchTime":209,"ssl":false,"responseCode":200,"responseSize":22443,"method":"GET",
"sessionId":"1f66d92b-66dd-727675d1bab7","loggedInUserId":"",
"uniqueRequestId":"9df01305-ae4b-6dee17b2069b"}

{"requestIp":"22.209.91.3","url":"http://www.example.com/moreurls.galore.html",
"date":1366788979022,"userAgent":"Mozilla/4.0","requestTimeMillis":96,"dispatchTime":96,
"ssl":false,"responseCode":200,"responseSize":17180,"referrer":
"http://www.example.com/previous.page.galore.html","method":"GET",
"sessionId":"b1e11781-3c2b-82b2-c761478e262a","loggedInUserId":"",
"uniqueRequestId":"12c7445a-5e-fa8-81d4-19222a421ba6","gaCookie__utmb":"161234094.18.14.1366"}
{% endhighlight %}

Once the Pig script has gone through it (and provided it found matches), the
output looks like this:

     1366788979022,{"url":"http://www.example.com", "ip":"127.0.0.1", etc }

I am using the following pig script for this:

{% highlight ruby %}
SET job.name '$customJobName';
REGISTER json-simple-1.1.1.jar;
DEFINE JSON2MAP com.twitter.elephantbird.pig.piggybank.JsonStringToMap();

A = LOAD '$inputPath';
B = FOREACH A GENERATE
      REGEX_EXTRACT_ALL($0, '(.*$filter.*)');
C = FILTER B BY (SIZE($0) < 3);
D = FOREACH C GENERATE FLATTEN($0);
E = FOREACH D GENERATE JSON2MAP($0) AS json, $0 AS fullline:chararray;
F = FOREACH E GENERATE FLATTEN(json#'date') AS requestdate, fullline;
G = FOREACH F GENERATE (long) requestdate, fullline;
H = ORDER G BY $0 ASC;

STORE H INTO '$outputPath';
{% endhighlight %}

Note that both the input and output paths are parameterized. This is to make
sure the Coordinator can drive this logic. The script is relatively simple. For
relation `B` it matches each input line with a regex. We filter down onto the
matching records, parse the JSON and pull out the timestamp of the access log:
in my example called `date` (relations `C`...`G`). Lastly, we order the output
by `requestdate` so that we get a chronological ordering.

### Workflow
Now that we have our Pig action in place, it's time to setup a simple workflow.
The workflow can tie together multiple actions. For example, it could execute
some Pig scripts, pull in some relational data with Sqoop, do some more
processing of these two together and dump the results back onto HDFS. In my
example I will keep it extremely minimalistic: we are just going to execute the
above Pig action. Here is the XML for the workflow definition:

{% highlight xml %}
<workflow-app name="Jilles Test Workflow" xmlns="uri:oozie:workflow:0.4">
  <start to="filter-for-particular-ip"/>
  <action name="filter-for-particular-ip">
    <pig>
        <job-tracker>${jobTracker}</job-tracker>
        <name-node>${nameNode}</name-node>
        <script>${applicationPath}/filter-ip.pig</script>
        <param>filter=${regexFilter}</param>
        <param>inputPath=${inputPath}</param>
        <param>outputPath=${outputPath}</param>
        <param>customJobName=${customJobName}</param>
	<!-- for <file>, you can not use f.ex. applicationPath for a reason thats beyond me -->
        <file>/user/joldenbeuving/oozie-test2/lib/json-simple-1.1.1.jar#json-simple-1.1.1.jar</file>
    </pig>
    <ok to="end"/>
    <error to="kill"/>
  </action>
  <kill name="kill">
      <message>Action failed, error message[${wf:errorMessage(wf:lastErrorNode())}]</message>
  </kill>
  <end name="end"/>
</workflow-app>
{% endhighlight %}

The workflow is composed of one or multiple `action`s, in my example only one.
You start your [DAG](http://en.wikipedia.org/wiki/Directed_acyclic_graph) with
the `start` node, identifying the first `action` Oozie should begin. Each
`action` then has two possible outcomes, as defined in the `ok` and `error`
tags. They do what you expect them to do. This way you can string together a
whole list of actions including decision points as [described
here](http://oozie.apache.org/docs/3.2.0-incubating/WorkflowFunctionalSpec.html#a3.1.4_Decision_Control_Node).

In my case there is only one Pig action. We need to provide the location of the
Pig script on HDFS and feed it the parameters the Pig action needs to function.
Here we just pass through the input and output paths as those are not being
determined by the workflow but by the coordinator as we will see later on. I
also provide the necessary jars the Pig script needs to function. Here it would
have been nice to be able to use the `$applicationPath` parameter but for some
reason I could not get that to work (leave comments if you know how to!).

You now actually have something you could execute by hand, but why stop short
of having it all run automatically? For that we need a coordinator.

### Coordinator
Here is my example coordinator:

{% highlight xml %}
<coordinator-app name="jilles-test-coordinator"
  frequency="${coord:days(1)}"
  start="2014-03-20T18:56Z" end="2015-06-05T18:56Z" timezone="Europe/Amsterdam"
  xmlns="uri:oozie:coordinator:0.2">

  <controls>
    <!-- See http://stackoverflow.com/a/21818132 -->
    <concurrency>1</concurrency>
    <execution>FIFO</execution>
    <throttle>5</throttle>
  </controls>

  <datasets>
    <!-- Naming convention used here:
          [e]dinfra
            -> 'din': Data INput or OUTput
            -> 'dc1': Data center 1 or 2, etc
            -> '[e]': Event (as opposed to dataset)
    -->
    <dataset name="dindc1" frequency="${coord:days(1)}"
             initial-instance="2014-03-20T04:00Z" timezone="Europe/Amsterdam">
      <uri-template>hdfs:///user/app/dc1/${YEAR}/${MONTH}/${DAY}/</uri-template>
      <done-flag></done-flag>
    </dataset>
    <dataset name="dindc2" frequency="${coord:days(1)}"
             initial-instance="2014-03-20T04:00Z" timezone="Europe/Amsterdam">
      <uri-template>hdfs:///user/app/dc2/ams01/${YEAR}/${MONTH}/${DAY}/</uri-template>
      <done-flag></done-flag>
    </dataset>
    <dataset name="dout" frequency="${coord:days(1)}"
             initial-instance="2014-03-20T18:56Z" timezone="Europe/Amsterdam">
      <uri-template>hdfs:///user/app/oozie-test-output-data/${YEAR}/${MONTH}/${DAY}/</uri-template>
      <done-flag></done-flag>
    </dataset>
  </datasets>

  <!-- Select the data (in our case the day) that we want to process
     For more info on this, see: http://tinyurl.com/q74oom7 -->
  <input-events>
    <data-in name="eindc1" dataset="dindc1">
      <instance>${coord:current(0)}</instance>
    </data-in>
    <data-in name="eindc2" dataset="dindc2">
      <instance>${coord:current(0)}</instance>
    </data-in>
  </input-events>
  <output-events>
    <data-out name="eout" dataset="dout">
      <instance>${coord:current(0)}</instance>
    </data-out>
  </output-events>

 <!-- Setup the actual workflow, let it know where we found new
      data ('inputDir') and where we require the workflow to store
      the results ('outputDir') -->
  <action>
    <workflow>
      <app-path>${applicationPath}</app-path>
      <configuration>
        <property>
          <name>inputPath</name>
          <!-- List both DC1 and DC2 events, Pig will handle these properly -->
          <value>${coord:dataIn('eindc1')},${coord:dataIn('eindc2')}</value>
        </property>
        <property>
          <name>outputPath</name>
          <value>${coord:dataOut('eout')}</value>
        </property>
        <property>
          <name>customJobName</name>
          <value>'${coord:user()}: Applying filter on incoming application data. Code here: https://linktogitrepo. Storing data in ${coord:dataOut('eout')}'</value>
        </property>
        <property>
          <name>oozie.use.system.libpath</name>
          <value>true</value>
        </property>
        <property>
          <name>regexFilter</name>
          <value>${regexFilter}</value>
        </property>
      </configuration>
   </workflow>
  </action>
</coordinator-app>
{% endhighlight %}

There is quite some complexity here, and at first it might seem overwhelming. But thinking about this for some time, I have the opinion that without it you end up reimplementing this complexity in worse ways later on as your setup starts failing in different ways. For example, Daylight Savings Time is handled properly in Oozie. As is input data sets across multiple timezones. Since we have explicitly defined our input and output datasets Oozie is able to determine what data has or has not been processed yet and will act accordingly.

Going over this one block at a time:

{% highlight xml %}
<coordinator-app name="jilles-test-coordinator"
  frequency="${coord:days(1)}"
  start="2014-03-20T18:56Z" end="2015-06-05T18:56Z" timezone="Europe/Amsterdam"
  xmlns="uri:oozie:coordinator:0.2">

  <controls>
    <!-- See http://stackoverflow.com/a/21818132 -->
    <concurrency>1</concurrency>
    <execution>FIFO</execution>
    <throttle>5</throttle>
  </controls>
{% endhighlight %}

Here we tell Oozie we expect this coordinator to run daily (`${coord.days(1)}`)
and since when we want it to process data. We can tell Oozie to stop at a
certain point in time too: I suggest you set the end time to 2038 ensuring job
security for a future generation of technologists. With `concurrency` you can
control how many jobs Oozie is allowed to kick off at the same time, as well as
where it should start (oldest data first = `FIFO`, newest data first = `LIFO`).
For more detail see the [stackoverflow
link](http://stackoverflow.com/a/21818132).

{% highlight xml %}
    <dataset name="dindc1" frequency="${coord:days(1)}"
             initial-instance="2014-03-20T04:00Z" timezone="Europe/Amsterdam">
      <uri-template>hdfs:///user/app/dc1/${YEAR}/${MONTH}/${DAY}/</uri-template>
      <done-flag></done-flag>
    </dataset>
    <dataset name="dindc2" frequency="${coord:days(1)}"
             initial-instance="2014-03-20T04:00Z" timezone="Europe/Amsterdam">
      <uri-template>hdfs:///user/app/dc2/ams01/${YEAR}/${MONTH}/${DAY}/</uri-template>
      <done-flag></done-flag>
    </dataset>
    <dataset name="dout" frequency="${coord:days(1)}"
             initial-instance="2014-03-20T18:56Z" timezone="Europe/Amsterdam">
      <uri-template>hdfs:///user/app/oozie-test-output-data/${YEAR}/${MONTH}/${DAY}/</uri-template>
      <done-flag></done-flag>
{% endhighlight %}

Here is where we define the data sets the coordinator should handle. To make
the example a bit more interesting I am assuming data appears in two different
paths (imagine from two different data centers, etc). Each data set has a
`frequency` associated. These do not need to be the same. One could be every 4
hours, the other each day, etc. Oozie will respect that and ensure all data is
present before kicking off the workflow.

The dataset has a `uri-template` that parameterizes the time aspects. You can
not use any other variables in here (or even a `*` to resolve all data centers)
as it would then become impossible for Oozie to determine if all input data is
present[^5]. The full list of parameters [can be found
here](https://oozie.apache.org/docs/3.1.3-incubating/CoordinatorFunctionalSpec.html#a5.1._Synchronous_Datasets).

{% highlight xml %}
  <input-events>
    <data-in name="eindc1" dataset="dindc1">
      <instance>${coord:current(0)}</instance>
    </data-in>
    <data-in name="eindc2" dataset="dindc2">
      <instance>${coord:current(0)}</instance>
    </data-in>
  </input-events>
  <output-events>
    <data-out name="eout" dataset="dout">
      <instance>${coord:current(0)}</instance>
    </data-out>
  </output-events>
{% endhighlight %}

Next, we take the static definition of a `uri-template` and define events that
can fire off when data appears under the `uri-template`. With the java
EL-language you can control time. In the example I used `${coord:current(0)}`
for the current day. But you could for example use `-1` to look at yesterday.
Or, for the output data-set, use `1` to have today's data appear as tomorrows
output. Note that by having two `input-events` Oozie is going to treat this as
a logical `AND` and wait till both have materialized.

The definition for this can be [found
here](http://oozie.apache.org/docs/3.2.0-incubating/CoordinatorFunctionalSpec.html#a6.6.1._coord:currentint_n_EL_Function_for_Synchronous_Datasets)
and is definitely worth reading through if you are going to try your hand at
Oozie. It starts off slightly academic, but includes some helpful examples at
the bottom.

{% highlight xml %}
    <workflow>
      <app-path>${applicationPath}</app-path>
      <configuration>
        <property>
          <name>inputPath</name>
          <!-- List both DC1 and DC2 events, Pig will handle these properly -->
          <value>${coord:dataIn('eindc1')},${coord:dataIn('eindc2')}</value>
        </property>
        <property>
          <name>outputPath</name>
          <value>${coord:dataOut('eout')}</value>
        </property>
        <property>
          <name>customJobName</name>
          <value>'${coord:user()}: Applying filter on incoming application data. Code here: https://linktogitrepo. Storing data in ${coord:dataOut('eout')}'</value>
        </property>
        <property>
          <name>oozie.use.system.libpath</name>
          <value>true</value>
        </property>
        <property>
          <name>regexFilter</name>
          <value>${regexFilter}</value>
        </property>
      </configuration>
   </workflow>
{% endhighlight %}

Lastly we define the action that needs to be taken once all required input
events trigger. In our case we kick off the workflow we defined earlier. We
give the workflow the input path. In our case two, separated by a comma. Note
however, that this is not defining both input paths must be present (we did
that earlier with the events). You could for example add another input path
here to some static data set, etc.

I also set a `customJobName`, just to make sure that other users of the Hadoop
cluster know what is going on and can find out more information should my
coordinator misbehave. We are also setting `oozie.use.system.libpath` to `true`
as otherwise I could not get the jars we depend on to be found. (No idea if
what I do there is correct, fire away at the comments please!)

We also give it the `regexFilter`. This, as well as the other parameters that
we do not have values for are defined in the last piece, the Coordinator
properties:


{% highlight ini %}
# Properties for the Coordinator flow
# Should contain settings that:
#  a) personalize your deployment, or
#  b) settings to connect to the correct Hadoop cluster

# Your username (Kerberos!). Needs to be done twice, didn't find a way around that
user.name=joldenbeuving
applicationPath=hdfs:///user/joldenbeuving/oozie-test2/

# Pinpoint the location of the application: it will delete
# and re-create this location, so please be careful!
oozie.coord.application.path=${applicationPath}/jilles-coordinator.xml
jobTracker=hadoop-dn:8021
nameNode=nameservice1

# Regex filter, examples include:
#  - Just an IP address (this will match anywhere in the input JSON)
#  - loggedInUserId\":\"1586651\"  this will match anything for which the user was... logged in, etc
# More info: http://pig.apache.org/docs/r0.8.1/piglatin_ref2.html#REGEX_EXTRACT_ALL
regexFilter=92\\.109\\.217\\.222
{% endhighlight %}

We hand over the runtime configuration parameters such as which `jobTracker` and
`nameNode` to use, as well as the location of the of the coordinator
application. Also, note that the username is important, especially if you use
Kerberos on your Hadoop cluster[^3]. If you have a highly available jobTracker, use
the logical name for it (I think that defaults to `logicaljt` for Cloudera).

The warning about deleting files from HDFS is not there because of Oozie, but because
of the driver script I wrote around this:

{% highlight bash %}
#! /bin/bash
export OOZIE_URL="http://hadoop-dn:11000/oozie/"

# Take application path from the properties file (DRY)
APP_PATH=`grep "^applicationPath" coordinator.properties | grep -o "hdfs.*"`
kinit -R

# do dryrun, and exit if problems are found
#(oozie job -dryrun -config coordinator.properties) || exit

echo Copying files to HDFS
hdfs dfs -rm -f -R $APP_PATH
hdfs dfs -mkdir $APP_PATH
hdfs dfs -mkdir $APP_PATH/data
hdfs dfs -mkdir $APP_PATH/lib
hdfs dfs -put *.{xml,pig} $APP_PATH
hdfs dfs -put ./lib/*.jar $APP_PATH/lib/
hdfs dfs -ls -R $APP_PATH

oozie job -run -config coordinator.properties
echo " ^---- Note this is the job ID (if everything went alright)"
echo
echo "Ways to get more info on the coordinator you just submitted:"
echo "  https://hue-domain/oozie/list_oozie_coordinators/"
echo "  $ oozie job --jobtype coord"
echo "  $ oozie job -info 0000004-091209145813488-oozie-dani-C"
{% endhighlight %}

This then ties it all together, removes any previous state on HDFS, uploads all
needed files such as coordinator, workflow, etc, and finally kicks off `oozie`
to run the job according to the properties.

If you run into trouble, especially around parameter substitution, you can run
`oozie` with the `--dryrun` parameter which will show you how parameters get
replaced with actual values: a indispensable debugging tool.

### Remarks
The above setup will continue to run even while during maintenance of the
Hadoop cluster. Also I have tested with various different failure modes such as
only partial input data availability, etc. and each time Oozie recognized the
situation skipped outputting (incomplete) data and retrying once the input data
appeared. It has proven to be quite resilient over the last month or so for me.

I have not experimented with Oozie Bundles as of yet. From my reading this
could simplify the deployment/release process (imagine having multiple
Coordinators that need to be somewhat compatible with each other as they are
chaining their data flows). Something to look into at a later moment.

### Conclusion

This poses a fantastic tool for teams that are looking to setup a comprehensive
data pipeline. The downsides to me are:

 - Quite verbose XML authoring of the definitions[^4], and
 - Completely disorienting error messages

That last one might be due to the distributed nature of Hadoop itself, more so than Oozie.

If you have questions or suggestions, please fire away at the comments!




### Footnotes
[^1]: [Using Oozie to process daily logs](http://ehukai.com/2011/06/14/using-oozie-to-process-daily-logs/) is roughly an equivalent blog post to this.
[^2]: Clear examples from the Yahoo team on [Oozie Coordinators](https://github.com/yahoo/oozie/wiki/Oozie-Coord-Use-Cases)
[^3]: [Using Oozie in a Kerberized Hadoop cluster](http://prodlife.wordpress.com/2013/11/22/using-oozie-in-kerberized-cluster/)
[^4]: One trick one can do on Cloudera is to author a rough outline of the Workflow you would like to have in their drag-n-drop tooling, then export to XML and perfect there. I always want to have the XML myself so that we can integrate it into Git and release procedures.
[^5]: One could use [other strategies](https://oozie.apache.org/docs/3.1.3-incubating/CoordinatorFunctionalSpec.html#a5.1._Synchronous_Datasets) (see `done-flag`) to indicate completeness of input data. Also, one could redefine the input data path as `year/month/day/datacenter`, then only tell Oozie about the time-related elements. In the Workflow you would add `/*` for the datacenter part. In that case you dismiss Oozie from completeness checks, and you are responsible yourself.
