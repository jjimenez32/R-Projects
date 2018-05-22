#################################################
#
#               Gedelt  APP
#             By Jonathan Jimenez
#
#
#
#
#
#################################################
library(shiny)
library(leaflet)
library(RColorBrewer)
require(dplyr)
require(article)




Ecode <- subset(ca2, EventRootCode == 1)


ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top =10, right = 10,
                textInput("caption", "Event Root Code"),
                # actionButton("submit", "Submit"),
                textOutput("text")
  )
)



server <- function(input, output, session){
  eventInput <- eventReactive( input$submit, {
    input$caption
  })

  filteredData <- reactive({
    Ecode <- subset(ca2, EventRootCode == input$caption)
  })
  
  

  
  output$map <- renderLeaflet({

    uniqueArticles <- unique(Ecode$Sourceurl)
    articles <- get_article(uniqueArticles)    

    Ecode <- left_join(Ecode, articles, by = c("Sourceurl" = "url"))
    
    content <- paste(sep = "",
                 "<b>Title: </b>",
                 Ecode$title, "<br/>",
                 "<b>Summary: </b>", "<br/>",
                 Ecode$text , "<br/>",
                 "<b>URL: </b>", "<br/>",
                 Ecode$Sourceurl, "<br/>")

    leaflet(Ecode) %>%
                   addTiles() %>% 
                   addCircleMarkers(~jitter(ActionGeo_Long), ~jitter(ActionGeo_Lat),radius = 2 ,
                                    fillOpacity = 0.7,
                                    popup = content,
                                    popupOptions = list(minWidth = 300,maxHeight = 300))
    
  })

  observe({        

    uniqueArticles <- unique(Ecode$Sourceurl)
    articles <- get_article(uniqueArticles)        
    Ecode <- subset(ca2, EventRootCode == input$caption)
    Ecode <- left_join(Ecode, articles, by = c("Sourceurl" = "url"))
    content <- paste(sep = "",
                 "<b>Title: </b>",
                 Ecode$title, "<br/>",
                 "<b>Summary: </b>", "<br/>",
                 Ecode$text , "<br/>",
                 "<b>URL: </b>", "<br/>",
                 Ecode$Sourceurl, "<br/>")

    leafletProxy("map", data = Ecode) %>%
                   addTiles() %>%
                   addCircleMarkers(~jitter(ActionGeo_Long), ~jitter(ActionGeo_Lat),radius = 2 ,
                                    fillOpacity = 0.7,
                                    popup = content,
                                    popupOptions = list(minWidth = 300,maxHeight = 300))
  })

  
}


shinyApp(ui, server)