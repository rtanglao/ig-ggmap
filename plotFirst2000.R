library(ggmap)
data3 = read.csv(
  file="https://raw.githubusercontent.com/rtanglao/rtgram/master/first2000-ig-van-2015.csv", 
  stringsAsFactors=F)
theme_map <- function (base_size = 12, base_family = "") {
  theme_gray(base_size = base_size, base_family = base_family) %+replace% 
    theme(
      axis.line=element_blank(),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks=element_blank(),
      axis.ticks.length=unit(0.3, "lines"),
      axis.text = element_text(margin=unit(0.5, "lines")),
      axis.title.x=element_blank(),
      axis.title.y=element_blank(),
      legend.background=element_rect(fill="white", colour=NA),
      legend.key=element_rect(colour="white"),
      legend.key.size=unit(1.2, "lines"),
      legend.position="right",
      legend.text=element_text(size=rel(0.8)),
      legend.title=element_text(size=rel(0.8), face="bold", hjust=0),
      panel.background=element_blank(),
      panel.border=element_blank(),
      panel.grid.major=element_blank(),
      panel.grid.minor=element_blank(),
      panel.margin=unit(0, "lines"),
      plot.background=element_blank(),
      plot.margin=unit(c(1, 1, 0.5, 0.5), "lines"),
      plot.title=element_text(size=rel(1.2)),
      strip.background=element_rect(fill="grey90", colour="grey50"),
      strip.text.x=element_text(size=rel(0.8)),
      strip.text.y=element_text(size=rel(0.8), angle=-90) 
    )   
}
(p <- qplot(long, lat, geom = "point", data = data3, color=I(data3$color), xlim=c(-123.17, -123.06), ylim=c(49.19, 49.324)) + theme_map())
