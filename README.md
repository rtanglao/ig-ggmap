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

1. ```map <- qmap('Vancouver,BC', zoom = 12, maptype = ‘hybrid’)```
2. ```data2 = read.csv(file="~rtanglao/Dropbox/GIT/rtgram/first20-ig-van-2015.csv", stringsAsFactors=F)```
3. ```map + geom_point(data = data2, aes(x = long, y=lat, color=color), size=1)``` yields:
* result is here: [https://www.flickr.com/photos/roland/25598368011/](https://www.flickr.com/photos/roland/25598368011/) bugs: markers are the wrong color! need to get rid of map chrome