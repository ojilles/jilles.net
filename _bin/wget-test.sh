#! /bin/bash
#
# Script retrieves the entire site (not storing anything on local disk though)
# in order to find out any 404s. It will stay on your own domain, so will only
# find "internal" 404's
#
# It assumes it's being called from your Jekyll's site root directory. If you
# hook this up to a Rakefile, this will always be the case as Rake takes care of
# this.
#
# Warning: implementation is super in-efficient (will spider twice if it finds
#          any broken links. If this is problem for you, send me a pull
#          request :-)
#
# Author: Jilles Oldenbeuving <ojilles@gmail.com>
#wget --spider -nd -r --base=http://localhost/jilles.net -S --save-headers -p -D localhost -np http://localhost/jilles.net/
TMPFILE=/tmp/jekyll-wget-test-NAqSS70N9ys4rhVuien
DOMAIN=`grep baseurl _config.yml | grep -o "http.*"`

echo " * Wget-test, crawling: [$DOMAIN]"
wget --spider -nd -r --base=$DOMAIN -S --save-headers -p -D localhost -np $DOMAIN &>$TMPFILE 

NOBROKENLINKS=`grep  "^http" $TMPFILE`
NOBROKENLINKS=$?
if [ $NOBROKENLINKS == 0 ]
then
    echo " * Found `grep "^http" $TMPFILE | wc -l` broken links"
    echo " * The following target URLs are referenced, but were not found "
    BROKENLINKS=`grep "^http" $TMPFILE`
    for LINK in $BROKENLINKS
    do
        # loop over all the links, grep the _site directory for anything that 
        # matches minus the baseurl (high chance that wasn't included)
        SANITIZED=`echo $LINK | sed -e "s!$DOMAIN!!"`
        echo "   * $SANITIZED 404'd, and is referenced from:"
        REFERRERS=`grep -R -l "$SANITIZED" _site/`
        for REFERRER in $REFERRERS
        do
            printf '     * %s\n' $REFERRER
        done
    done
    rm $TMPFILE
    exit -1
else
    echo " * All okay!"
fi
exit 0
