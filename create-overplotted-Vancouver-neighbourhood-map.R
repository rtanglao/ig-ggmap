library(tidyverse)
library(ggmap)

args <- commandArgs(TRUE)

## Default setting when no arguments passed
if(length(args) < 1) {
  args <- c("--help")
}

if("--help" %in% args) {
  cat(' 
      Arguments:
      CSV file with Vancouver neighbourhood files
      --help              - print this text 
      Example:
      Rscript create-overplotted-neighbourhood-map.R "Kensington-Cedar Cottage"\n\n')
  q(save="no")
}
all_neighbourhoods_ig_van_2015 = read.csv(
  "filter_step2_ig_van_neighbourhood_2015.csv", 
  stringsAsFactors=F)
neighbourhood_ig_van_2015 <- 
  all_neighbourhoods_ig_van_2015 %>% 
  filter(neighbourhood == args[1])

plot = ggplot(data=neighbourhood_ig_van_2015, aes(x=long, y = lat))+
  geom_point(aes(long,lat,color=I(neighbourhood_ig_van_2015$colour)),
             size=I(6.0),alpha=I(0.4))+
  theme_void()

ggsave(
  paste0(
    args[1],
    "-instagram-vancouver-2015-average-colour-overplotted.png"),
    #multiply height and width by dpi to get px
    plot, width = 25.833333333, height = 15.666666667, dpi = 72, limitsize = FALSE)