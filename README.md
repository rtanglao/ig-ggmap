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
f="~rtanglao/Dropbox/GIT/rtgram/13March2016-abbreviated-instagram-vancouver-top-colour-lat-long-date-2015.csv"
data6 = read.csv(file=f,stringsAsFactors=F)
(p <- qplot(long, lat, geom = "point", data = data6,
color=I(data6$color), xlim=c(-123.27, -123.005),
ylim=c(49.21, 49.324), size=I(1.0), alpha=I(0.4))+
facet_wrap(~date) + theme_minimal())
```

# 14 March 2016 - small multiples

1. get dataset

    ```bash
    ./writeHexTopColourLatLonByDate.rb > 13March2016-instagram-vancouver-top-colour-lat-long-date-2015.csv
    ```
1. generate facets aka small multiples
 
 ```R
f="~rtanglao/Dropbox/GIT/rtgram/13March2016-instagram-vancouver-top-colour-lat-long-date-2015.csv"
data6 = read.csv(file=f,stringsAsFactors=F)
(p <- qplot(long, lat, geom = "point", data = data6,
color=I(data6$color), xlim=c(-123.27, -123.005),
ylim=c(49.21, 49.324), size=I(1.0), alpha=I(0.4))+
facet_wrap(~date) + theme_minimal())
```
# 16 March 2016 - R script with command line parameters

1. next up write an R script to generate a map from command line parameters for the date and then create a PNG of that file
# 18 March 2016 R script with command line parameters to generate 365 maps

1. create 365 CSV files
 
 ```sh
 mkdir CSV_FILES_FOR_GGMAP_2015
 cd CSV_FILES_FOR_GGMAP_2015
 ../create365-CSV-files-ig-vancouver-2015-top-colour.rb
 ```
2. Create 365 maps 
 
 ```sh
 mkdir 1920PXx1920PX_MAPS_FOR_GGMAP2015 ; cd !$
 ls -1 ../CSV_FILES_FOR_GGMAP_2015/*.csv | xargs -n 1 Rscript
 ../plot1-day-ig-van-2015-pointsize1.0.alph0.4.R
 ```
#  19 March 2016 create montage
```cd /Users/rtanglao/Dropbox/GIT/ig-ggmap/1920PXx1920PX_MAPS_FOR_GGMAP2015```

1. create png file list
 ```sh
 ls -1 *.png > 365pngs.txt
 ```
2. make montage:
```sh
gm montage -verbose -adjoin -tile 7x53 +frame +shadow \
+label -adjoin -geometry '1920x1920+0+0<' null: \
null:null: @365pngs.txt null: null: null: \
19march2016-53x7-365days-ggmap-vancouver-instagram-2015-montage.png
```