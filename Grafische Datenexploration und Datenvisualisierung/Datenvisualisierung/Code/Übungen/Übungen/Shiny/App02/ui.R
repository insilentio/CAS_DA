library(shiny)
shinyUI(fluidPage(
  titlePanel("STAR WARS"),
 
  sidebarLayout(
    sidebarPanel("Seiten-Panel"),
    mainPanel(h6("Episode IV", align = "center"),
              h5("A NEW HOPE", align = "center"),
              h4("It is a period of civil war.", align = "center"),
              h3("Rebel spaceships, striking", align = "center"),
              h2("from a hidden base, have won", align = "center"),
              h1("their first victory against the", align = "center"),
              h1(strong("evil Galactic Empire."), align = "center")),
    position = "r"
    )
))
