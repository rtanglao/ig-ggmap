library(ggmap)

args <- commandArgs(TRUE)
 
## Default setting when no arguments passed
if(length(args) < 1) {
  args <- c("--help")
}
if("--help" %in% args) {
  cat(" 
      Arguments:
      what to grep for also what to name the file
      --help              - print this text 
      Example:
      Rscript plot1-day-ig-van-2015-pointsize1.0.alph0.4.R 001_ThuJan1.csv\n\n")
 
  q(save="no")
}

print(args[1])
data4 = read.csv(file=args[1], stringsAsFactors=F)
# following theme is from:
# http://stackoverflow.com/questions/6736378/how-do-i-change-the-background-color-of-a-plot-made-with-ggplot2
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
      strip.background=element_rect(fill="black", colour="black"),
      strip.text.x=element_text(size=rel(0.8)),
      strip.text.y=element_text(size=rel(0.8), angle=-90) 
    )   
}

(p <- qplot(long, lat, geom = "point", data = data4, color=I(data4$color), xlim=c(-123.27, -123.005), ylim=c(49.21, 49.324), size=I(1.0), alpha=I(0.5)) + theme_map())

ggsave(gsub("csv", "png", basename(args[1])), p, width = 26.666666667, height = 15.0, dpi = 72, limitsize = FALSE) # 26.6666667 = 1920/72dpi 15 = 1080/72dpi
