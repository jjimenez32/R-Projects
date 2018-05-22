library(ggplot2)
library(DT)

function(input, output){
  
  output$table <- DT:: renderDataTable(DT:: datatable({
    data <- mpg
    if(input$man != "All"){
      data <- data[data$manufacturer == input$man,]
    }
  }))
}