library(shiny)
library(ggplot2)
library(DT)
fluidPage(
  titlePanel("DataTable"),
    fluidRow(
    column(4,
           selectInput("man",
                       strong("Manufacture:"),
                       c("All",
                         unique(as.character(mpg$manufacturer))))
    ),
    column(4,
           selectInput("trans", 
                       strong("Transmission:") ,
                       c("All",
                         unique(as.character(mpg$trans))))
    ),
    column(4,
           selectInput("cyl",
                       strong("Cylinders:"),
                       c("All",
                         unique(as.character(mpg$cyl))))
    ),
    column(4, selectInput("test", strong("TEST"),
               c("TEST", "OPTION1", "OPTION2", "OPTION3", "OPTION4"))
    )
  ),
  fluidRow(
    DT:: dataTableOutput("table")
  )
)
