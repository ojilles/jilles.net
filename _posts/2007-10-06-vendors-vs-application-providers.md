---
layout: post
title: Vendors vs Application providers
permalink: /perma/2007/10/06/vendors-vs-application-providers/
post_id: 60
categories: 
- Software Development
- Website architecture
---

Vogels (the CTO of Amazon) published a paper in which they describe their high available, eventually consistent data storage called Dynamo that will scale incrementally. It was an excellent read, and if you're in the business of providing a high traffic, high available application (web or otherwise) I suggest you take a look!

That post did re-iterate with me a point I came across before: why is it that a company like Amazon is building these types of infrastructure components? There are other examples like it, providing excellent world class technology within eBay. Or more publicly why did LiveJournal.com develop memcached or Mogile? Why did Google write GFS? And the list goes on. This, by the way, is not just pertained to storage solutions. Within eBay I see some really cool technology that could be spinned off into separate products in different area's, but I am not in a position to disclose those.

I do see that having such a technology could be a competitive advantage (for a while) but at this scale I'm not sure that that really holds. For example both Amazon and Google currently have a highly scalable data store (Dynamo vs GFS). <span style="font-size:8pt;">(They are a bit different with Dynamo storing data smaller than 1MB)</span>

Those technologies are really cool, and scratch an itch that is absolutely there for these companies but bottom line eBay, Google, LiveJournal should be adding features and improving the user experience above writing infrastructure components. Now, in order to either a) write those features or b) bring down operational cost (or availability up) you might need these technologies but that does not translate 1:1 into actually writing them. Ideally, an Application provider such as Amazon should be able to come up with a cool feature, buy the technology needed to back that feature up and develop the feature using the technology bought.

Now, why is it then that no 3rd party vendor stepped into this space and provided similar technology? Why is it that noone from these companies started off on their own and started a company providing a technology like Dynamo? Why doesn't a big database or storage vendor step into this space? Clearly there are some big companies out there that need this technology (Amazon, eBay, Google, Yahoo, and there are certainly more). So, really, why has nobody stepped into this space? Or, in reverse, which companies provide these types of products?
