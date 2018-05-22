library(shiny)

server <- function(input,output, session){
  rv = reactiveValues()

  rv$mess = ""

  observeEvent(input$bouton, {
    withProgress({
      setProgress(message = "Initialization...")
      Sys.sleep(1)
      setProgress(message = "Almost ready...")
      Sys.sleep(3)
      setProgress(message = "Ok !")
      Sys.sleep(2)
    })
  })
}

