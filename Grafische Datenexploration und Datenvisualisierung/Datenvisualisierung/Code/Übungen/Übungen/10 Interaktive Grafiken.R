# plotly
library(ggplot2)
library(plotly)
d <- diamonds[sample(nrow(diamonds), 1000), ]
p <- ggplot(data = d, aes(x = carat, y = price)) +
  geom_point(size = 4) +
  geom_smooth(aes(colour = cut, fill = cut))+
  theme_bw()+
  facet_wrap(~ cut)
p
ggplotly(p)



#Shiny
library(shiny)
runExample("01_hello")
runApp("App01", display.mode = "showcase")

runApp("App02")
  