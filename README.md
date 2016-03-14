# 06 March 2016 installing on el capitan MBA 13” retina
used [http://www.benjack.io/2016/01/02/el-capitan-biocomputing.html](http://www.benjack.io/2016/01/02/el-capitan-biocomputing.html) to install r and jupyter and numpy and other python stuff

    pip install numpy
    pip install --upgrade pip
    pip install scipy
    pip install jupyter
    brew tap homebrew/science
    brew install R
    brew tap caskroom/cask
    brew cask install rstudio```
    
#     10 March 2016 trying out ggmap
## Successful
1. ```data3 = read.csv(file="~rtanglao/Dropbox/GIT/rtgram/first2000-ig-van-2015.csv", stringsAsFactors=F)```
1. ```map <- qmap('Vancouver,BC', zoom = 12, maptype = 'hybrid’)```
1. ```map + geom_point(data = data3, aes(x = long, y=lat, color=I(data3$color)), size=1)```

## Unsuccessful attempts

1. ```map <- qmap('Vancouver,BC', zoom = 12, maptype = ‘hybrid’)```
2. ```data2 = read.csv(file="~rtanglao/Dropbox/GIT/rtgram/first20-ig-van-2015.csv", stringsAsFactors=F)```
3. ```map + geom_point(data = data2, aes(x = long, y=lat, color=color), size=1)``` yields:
    * result is here: [https://www.flickr.com/photos/roland/25598368011/](https://www.flickr.com/photos/roland/25598368011/) bugs: markers are the wrong color! need to get rid of map chrome

1. seems to work: ```qmplot(long, lat, data = data2, maptype = "toner-lite",  color = I(data2$color))```   
 
#  11 March 2016 - make “chrome-less” map:

make chromeless map following this:

* [http://www.milanor.net/blog/maps-in-r-introduction-drawing-the-map-of-europe/](http://www.milanor.net/blog/maps-in-r-introduction-drawing-the-map-of-europe/)
* [http://www.milanor.net/blog/maps-in-r-plotting-data-points-on-a-map/](http://www.milanor.net/blog/maps-in-r-plotting-data-points-on-a-map/)

# 12 March 2016 - chromeless maps!
1. read the data:

 ```R
 data3 = read.csv(file="~rtanglao/Dropbox/GIT/rtgram/first2000-ig-van-2015.csv", stringsAsFactors=F)
 ```

2. plot the data with limits, note the I() function for colours:

 ```R
 (p <- qplot(long, lat, geom = "point", data = data3,
 color=I(data3$color), xlim=c(-123.17, -123.06),
 ylim=c(49.19, 49.324)))
 ```
3. map:

![ig-vancouver-top-colour-first-2000](https://raw.githubusercontent.com/rtanglao/ig-ggmap/master/first2000-instagram-vancouver-2015-top-colour.png)

# 13 March 2016 - small multiples

1. generate facets aka small multiples
 
 ```R
data6 = read.csv(file="~rtanglao/Dropbox/GIT/rtgram/13March2016-abbreviated-instagram-vancouver-top-colour-lat-long-date-2015.csv", 
+     stringsAsFactors=F)
(p <- qplot(long, lat, geom = "point", data = data6, color=I(data6$color), xlim=c(-123.27, -123.005), ylim=c(49.21, 49.324), size=I(1.0), alpha=I(0.4))+ facet_wrap(~date) + theme_minimal())
```
