library(shiny)

ui <- fluidPage(
  headerPanel("Hello !"),
  mainPanel(
    actionButton("bouton", "Clic !"),
    textOutput("texte")
  )
)
