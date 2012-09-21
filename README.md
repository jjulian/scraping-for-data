# "Scraping for Data"
## Betascape 2012, 9/23

What if the data you want isn't ready to be visualized? Well, you transform it. In this session, we'll
take a look at how to free data that is locked up in various ways, such as RSS feeds and HTML pages, and
then transform it into the best format for your visualization. We'll use Ruby and the command-line to scrape
data from a few websites, and put it into a format suitable for a visualization. Bring your own examples
of data on the web that needs to be "freed" and we'll work together to get that data out! Starting out as 
a short presentation, we'll quickly be writing code and then you're on your own to transform your own data.

**Attendees:** Install your laptop with Ruby and Rubygems to run the examples. Follow along in Perl or Python if you wish.

**Level:** Intermediate, comfort with programming required

### Example 1 - read your water bill

Find out how much your neighbors pay on their water bills (scraping Baltimore City site)

    ruby -I. water.rb

### Example 2 - map GPS encoded photos

View your GPS-encoded photos on a map (reading EXIF data from jpg images, such as from an iPhone camera)

    ruby photos.rb > my_photos.html
    (open browser to view map)

### Example 3 - Dave Troy's Tweets in Baltimore script

Capture tweets within a lat/long bounding box in real-time using the Twitter Streaming API. [script](https://gist.github.com/3742889)

    git clone https://gist.github.com/3742889
    ruby stream.rb
