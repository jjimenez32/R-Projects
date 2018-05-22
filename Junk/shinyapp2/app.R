# library(shiny)
# library(article)
# library(dplyr)
# library(leaflet)
# if (interactive()) {
# 
#   shinyApp(
#     ui = basicPage(
#       numericInput("num", label = "Make changes", value = 1),
#       submitButton("Update View", icon("refresh")),
#       helpText("When you click the button above, you should see",
#                "the output below update to reflect the value you",
#                "entered at the top:"),
#       verbatimTextOutput("value")
#     ),
#     server = function(input, output) {
# 
#       # submit buttons do not have a value of their own,
#       # they control when the app accesses values of other widgets.
#       # input$num is the value of the number widget.
#       output$value <- renderPrint({ input$num })
#     }
#   )
# }

## Only run examples in interactive R sessions
# if (interactive()) {
#   
#   ui <- fluidPage(
#     uiOutput("moreControls")
#   )
#   
#   server <- function(input, output) {
#     output$moreControls <- renderUI({
#       tagList(
#         sliderInput("n", "N", 1, 1000, 500),
#         textInput("label", "Label")
#       )
#     })
#   }
#   shinyApp(ui, server)
# }

# 
# r_colors <- rgb(t(col2rgb(colors()) / 255))
# names(r_colors) <- colors()
# 
# ui <- fluidPage(
#   leafletOutput("mymap"),
#   p(),
#   actionButton("recalc", "New points")
# )
# 
# server <- function(input, output, session) {
#   
#   points <- eventReactive(input$recalc, {
#     cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
#   }, ignoreNULL = FALSE)
#   
#   output$mymap <- renderLeaflet({
#     leaflet() %>%
#       addProviderTiles(providers$Stamen.TonerLite,
#                        options = providerTileOptions(noWrap = TRUE)
#       ) %>%
#       addMarkers(data = points())
#   })
# }
# 
# shinyApp(ui, server)


library(shiny)
library(leaflet)
library(RColorBrewer)

content <- paste(sep = "",
                 "<b>Title: </b>", 
                 fighting$title, "<br/>",
                "<b>Summary: </b>", "<br/>",
                 fighting$text , "<br/>")
                 

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                sliderInput("range", "Magnitudes", min(quakes$mag), max(quakes$mag),
                            value = range(quakes$mag), step = 0.1
                ),
                selectInput("colors", "Color Scheme",
                            rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
                ),
                checkboxInput("legend", "Show legend", TRUE),
                textInput("caption", "Event Code"),
                actionButton("submit", "Submit"),
                textOutput("out")
                
  )
)

server <- function(input, output, session) {
  
  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    fighting
  })
  
  # This reactive expression represents the palette function,
  # which changes as the user makes selections in UI.
  colorpal <- reactive({
    colorNumeric(input$colors, fighting$ActionGeo_Lat)
  })
  
  # inputData <- reactive(input$submit,{
  #   input$caption
  # })
  # 
  # output$out <- renderText({
  #   leafletProxy("map", data = )
  # })
  # 
  output$map <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    leaflet(fighting) %>% addTiles() %>%
      fitBounds(~min(ActionGeo_Long), ~min(ActionGeo_Lat), ~max(ActionGeo_Long), ~max(ActionGeo_Lat))
  })
  
  # Incremental changes to the map (in this case, replacing the
  # circles when a new color is chosen) should be performed in
  # an observer. Each independent set of things that can change
  # should be managed in its own observer.
  observe({
    pal <- colorpal()
    
    leafletProxy("map", data = filteredData()) %>%
      clearShapes() %>%
      addCircles(radius = ~10^ActionGeo_Lat/10, weight = 1, color = "#777777",
                 fillColor = ~pal(ActionGeo_Lat), fillOpacity = 0.7, popup = ~paste(ActionGeo_Lat)
      )
  })
  
  # Use a separate observer to recreate the legend as needed.
  observe({
    proxy <- leafletProxy("map", data = fighting)
    
    # Remove any existing legend, and only if the legend is
    # enabled, create a new one.
    proxy %>% clearControls()
    if (input$legend) {
      pal <- colorpal()
      proxy %>% addLegend(position = "bottomright",
                          pal = pal, values = ~ActionGeo_Lat
      )
    }
  })
}

shinyApp(ui, server)