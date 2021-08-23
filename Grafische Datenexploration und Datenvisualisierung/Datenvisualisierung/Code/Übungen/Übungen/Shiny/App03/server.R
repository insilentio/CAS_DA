library(shiny)
library(ggplot2)
source("plot_map.R")
SchweizGeo<-read.csv("daten/schweizGeo.csv")
altersmediane <- sapply(SchweizGeo[c("alter_0_19","alter_20_64","alter_65.")],median,na.rm=TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
    output$map <- renderPlot({ 

    variables<-switch(input$var,
                      "Altersgruppe: 0-19" = "alter_0_19",
                      "Altersgruppe: 20-64" = "alter_20_64",
                      "Altersgruppe: 65 plus" = "alter_65.")
    
    legend<-switch(input$var,
                   "Altersgruppe: 0-19" = "Altersgruppe \n 0 bis 19 Jahre \n (in %)",
                   "Altersgruppe: 20-64" = "Altersgruppe \n 20 bis 64 Jahre \n (in %)",
                   "Altersgruppe: 65 plus"= "Altersgruppe \n 65 plus \n (in %)")
    
    plot_map(daten = SchweizGeo, mediane = altersmediane, var = variables, legend.title = legend )
  })
})
