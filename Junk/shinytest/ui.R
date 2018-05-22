library(shiny)



shinyUI(fluidPage(
  titlePanel(h1(strong("censusVis"))),
  sidebarPanel(
    helpText("Create demographic maps with information from the 2010 US Census"),
    selectInput("var", label = "Choose a variable to display",
                choices = list("Percent White","Percent Black", "Percent Hispanic", "Percent Asian"),
                selected = "Percent White"),
    sliderInput("range", label = "Range of Interest",
                min = 0, max = 100, value = c(0,100))
  ),
  mainPanel(textOutput("text1"),
            textOutput("text2"))
))
