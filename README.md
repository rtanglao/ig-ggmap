# 06 March 2016 installing on el capitan MBA 13” retina
used [http://www.benjack.io/2016/01/02/el-capitan-biocomputing.html](http://www.benjack.io/2016/01/02/el-capitan-biocomputing.html) to install r and jupyter and numpy and other python stuff

    pip install numpy
    pip install --upgrade pip
    pip install scipy
    pip install jupyter
    brew tap homebrew/science
    brew install R
    brew tap caskroom/cask
    brew cask install rstudio
    
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
 null: null: @365pngs.txt null: null: null: \
 19march2016-53x7-365days-ggmap-vancouver-instagram-2015-montage.png
 ```

# 20 March 2016 create time lapse

1. timelapse requires jpegs
 ```sh
 mkdir JPEGS
 cd JPEGS
 ls -1 ../*_*.png > 365pngs.txt
 ```
 
1. make the jpegs and the timelapse
  ```sh
  mogrify -path . -format jpeg @365pngs.txt 
  ```
  
Make the timelapse using timelapse assembler on mac OR imagemagick or graphicsmagick convert

# 20 March 2016 make annotated jpegs
"%t" is the filename (without the filetype) escape for imagemagick. note that "convert" wouldn't work easily so I switched to "mogrify" which requires "-path ." to write to the current directory.

```sh
cd /Users/rtanglao/Dropbox/GIT/ig-ggmap/1920x1080-GGMAPS
mkdir ANNOTATED_WITH_DATE_JPEGS ; cd !$
ls -1 ../*_*.png | xargs -n 1 mogrify -path . -format \
jpg  -verbose -font Times-Bold -pointsize 32 \
-fill white  -undercolor '#00000080' \
-gravity southeast -annotate +0+5 %t
``` 
# 09October 2017
* [Add neighbourhood using Flickr API](http://rolandtanglao.com/2017/10/09/p1-one-csv-file-neighbourhood-instagram-vancouver-average-colour-2015/) and [step 1 of cleaning the resulting data](http://rolandtanglao.com/2017/10/09/p2-step1-to-clean-up-ig-van2015-neighbourhoods-count/)
# 10October2017
## 10October2017-step 2 remove Maywood, Burnaby, etc.

```R
filter_step2_ig_van_neighbourhood_2015  <-
  ig_van_neighbourhood_2015 %>% 
  filter(neighbourhood != "Maywood") %>% 
  filter(neighbourhood != "Whistler") %>%
  filter(neighbourhood != "Burnaby") %>%
  filter(neighbourhood != "Vancouver") %>%
  filter(neighbourhood != "North Vancouver") %>%
  filter(neighbourhood != "Surrey" ) %>%
  filter(neighbourhood != "Norgate" ) %>%
  filter(neighbourhood != "Deep Cove" ) %>%
  filter(neighbourhood != "Sea Island" ) %>%
  filter(neighbourhood != "Stride Hill" ) %>%
  filter(neighbourhood != "West Vancouver" ) %>%
  filter(neighbourhood != "Keith-Lynn" ) %>%
  filter(neighbourhood != "Laurentian Belaire" ) %>%
  filter(neighbourhood != "Greater Vancouver" ) %>%
  filter(neighbourhood != "Cleveland Park" ) %>%
  filter(neighbourhood != "Capilano" ) %>%
  filter(neighbourhood != "Park Royal" ) %>%
  filter(neighbourhood != "Ubc" ) %>%
  filter(neighbourhood != "Squamish-Lillooet" ) %>%
  filter(neighbourhood != "Horseshoe Bay" ) %>%
  filter(neighbourhood != "Golden Village" )

(p <- 
    qmplot(
      long, lat, geom = "point", data = filter_step2_ig_van_neighbourhood_2015,
      color=I(filter_step2_ig_van_neighbourhood_2015$colour), xlim=c(-123.27, -123.005),
            ylim=c(49.21, 49.324), size=I(1.0), alpha=I(0.4))+
    facet_wrap(~neighbourhood) + theme_minimal())
p

qmplot(long, lat, geom = "point",
       size=I(1.0), alpha=I(0.4),
       data = filter_step2_ig_van_neighbourhood_2015, 
       source = "google",
       maptype = "hybrid", 
       color = I(filter_step2_ig_van_neighbourhood_2015$colour)) + 
  facet_wrap(~ neighbourhood)
```

## 10October2017-ggmap

* next up try: https://medium.com/fastah-project/a-quick-start-to-maps-in-r-b9f221f44ff3
* and:https://ourcodingclub.github.io/2016/12/11/maps_tutorial.html

```R
m <- get_map("Vancouver",zoom=12,maptype="terrain",source="google")
n <- get_map("Vancouver",zoom=12,maptype="toner",source="stamen")

ggmap(n) + geom_point(data = filter_step2_ig_van_neighbourhood_2015, 
                      aes(long,lat,color=I(filter_step2_ig_van_neighbourhood_2015$colour)),
                      size=2,alpha=0.7) +
  facet_wrap(~ neighbourhood)+
  theme_minimal()

o <- get_map("Vancouver",zoom=12,maptype="toner-lines",source="stamen")
ggmap(o) + geom_point(data = filter_step2_ig_van_neighbourhood_2015, 
                      aes(long,lat,color=I(filter_step2_ig_van_neighbourhood_2015$colour)),
                      size=I(1.0),alpha=I(0.4)) +
  facet_wrap(~ neighbourhood)+
    theme_void()
```

## 10October2017-Let's try Gastown only

```R
gastown_map <- get_map("Gastown, Vancouver",zoom=15,maptype="toner-lines",source="stamen")
gastown_ig_van_2015 <- 
  filter_step2_ig_van_neighbourhood_2015 %>% 
  filter(neighbourhood == "Gastown")

ggmap(gastown_map) + geom_point(data = gastown_ig_van_2015, 
                      aes(long,lat,color=I(gastown_ig_van_2015$colour)),
                      size=I(1.0),alpha=I(0.4)) +
  theme_void()
```

## 10October2017-let's try labels

```R
gastown_labels_map <- get_map("Gastown, Vancouver",zoom=15,maptype="toner-labels",source="stamen")
ggmap(gastown_labels_map) + geom_point(data = gastown_ig_van_2015, 
                                aes(long,lat,color=I(gastown_ig_van_2015$colour)),
                                size=I(2.0),alpha=I(0.4)) +
  theme_void()
```

## 10October2017-let's try watercolor

```R
gastown_watercolor_map <- get_map("Gastown, Vancouver",zoom=15,maptype="watercolor",source="stamen")
ggmap(gastown_watercolor_map) + geom_point(data = gastown_ig_van_2015, 
                                       aes(long,lat,color=I(gastown_ig_van_2015$colour)),
                                       size=I(2.0),alpha=I(0.4)) +
  theme_void()
```

## 10October2017-Let's try Kensington-Cedar Cottage

```R
kcc_watercolor_map <- get_map("Kensington-Cedar Cottage, Vancouver",zoom=15,maptype="watercolor",source="stamen")
kcc_ig_van_2015 <- 
  filter_step2_ig_van_neighbourhood_2015 %>% 
  filter(neighbourhood == "Kensington-Cedar Cottage")
ggmap(kcc_watercolor_map) + geom_point(data = kcc_ig_van_2015, 
                                           aes(long,lat,color=I(kcc_ig_van_2015$colour)),
                                           size=I(6.0),alpha=I(0.4)) +
  theme_void()
```

## 10October2017-Let's try Commercial Drive

```R
commercial_watercolor_map <- get_map("Commercial, Vancouver",zoom=15,maptype="watercolor",source="stamen")
commercial_ig_van_2015 <- 
  filter_step2_ig_van_neighbourhood_2015 %>% 
  filter(neighbourhood == "Commercial")
ggmap(commercial_watercolor_map) + geom_point(data = commercial_ig_van_2015, 
                                       aes(long,lat,color=I(commercial_ig_van_2015$colour)),
                                       size=I(6.0),alpha=I(0.4)) +
  theme_void()
```

## 10October2017-commercial chromeless

```R
ggplot(data=commercial_ig_van_2015, aes(x=long, y = lat))+
geom_point(aes(long,lat,color=I(commercial_ig_van_2015$colour)),
size=I(6.0),alpha=I(0.4))+
theme_void()
```

## 10October2017-gastown chromeless

```R
ggplot(data=gastown_ig_van_2015, aes(x=long, y = lat))+
geom_point(aes(long,lat,color=I(gastown_ig_van_2015$colour)),
size=I(6.0),alpha=I(0.4))+
theme_void()
```
# 12October2017
## 12October2017-write-filter_step2_ig_van_neighbourhood_2015.csv

* 1\. In R Studio:

```R
setwd("/Users/rtanglao/Dropbox/GIT/ig-ggmap/WITH_NEIGHBOURHOOD_CSV_FILES_FOR_GGMAP_2015/CHROMELESS_MAPS_FOR_EACH_NEIGHBOURHOOD")
write.csv(filter_step2_ig_van_neighbourhood_2015, 
          file = "filter_step2_ig_van_neighbourhood_2015.csv",
          row.names=FALSE)
```

* 2\. from the command line, get the neighbourhoods and create a map for each:

```bash
Rscript ../../create-overplotted-Vancouver-neighbourhood-map.R "Kensington-Cedar Cottage"
Rscript ../../create-overplotted-Vancouver-neighbourhood-map.R "Gastown"
```
