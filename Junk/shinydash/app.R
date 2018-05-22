#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)  


uniqueArticles <- unique(ca2$Sourceurl)    

articles <- get_article(uniqueArticles)    

# Define UI for application that draws a histogram
ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody( tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  box(title ="basic map",
      collapsible = TRUE,
      leafletOutput("map", width = "100%", height = "100%")),
  absolutePanel(top =10, right = 10,
                textInput("caption", "Event Root Code")
                # actionButton("submit", "Submit"),
  ),
  abosultePanel(top = 10, right = 10,
                textInput("country", "Country"))
  )
)

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) 
{
  eventInput <- eventReactive( input$submit, {
    input$caption
  })

  # filteredData <- reactive({
  #   Ecode <- subset(ca2, EventRootCode == input$caption)
  #  })
  # 
  

  
  output$map <- renderLeaflet({
    Ecode <- subset(ca2, EventRootCode == input$caption)
    Ecode <- left_join(ca2, articles, by = c("Sourceurl" = "url"))
    Ecode <- Ecode[!duplicated(Ecode$Sourceurl),]
    content <- paste(sep = "",
                 "<b>Title: </b>",
                 Ecode$title, "<br/>",
                 "<b>Summary: </b>", "<br/>",
                 Ecode$text , "<br/>",
                 "<b>URL: </b>", "<br/>",
                 Ecode$Sourceurl, "<br/>")
    leaflet(Ecode) %>%
        setView(lng = -60.2333, lat =-15.9000 , zoom = 4)
                    # addTiles() #%>% 
                   # addCircleMarkers(~jitter(ActionGeo_Long), ~jitter(ActionGeo_Lat),radius = 2 ,
                   #                  fillOpacity = 0.7,
                   #                  popup = content,
                   #                  popupOptions = list(minWidth = 300,maxHeight = 300))
    
  })

  observe({
    # uniqueArticles <- unique(ca2$Sourceurl)
    # articles <- get_article(uniqueArticles)
    Ecode <- subset(ca2, EventRootCode == input$caption)
    Ecode <- left_join(Ecode, articles, by = c("Sourceurl" = "url"))
    Ecode <- Ecode[!duplicated(Ecode$Sourceurl),]
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

  
})
# Run the application 
 shinyApp(ui = ui, server = server)

