# count <- 1
# for(i in 1:7){
#   days <- Sys.Date() - i-1
#   days <- gsub("-","", days)
#   country_codes <- c("GT","SV","GP","PA","PR","GY","CO","EC","PY","SR","UY","VE","PE","SR","GF","FK","CL", "BR", "AR", "CU","CR","BB","BS","AW","AI","HN")
# 
#   gdelturl <- paste("http://data.gdeltproject.org/events/", ".export.CSV.zip", sep = days)
#   download.file(gdelturl, dest= "dataset1.zip", mode = "wb")
#   unzip("dataset1.zip", exdir = "./")
#   unlink("dataset1.zip")
#   gdelturl <- gsub("http://data.gdeltproject.org/events/" , "" , gdelturl)
#   gdelturl <- gsub(".zip", "", gdelturl)
#   if (count == 1){
#     gdelt <- read.csv( gdelturl ,sep = "\t",header = TRUE, as.is = FALSE, na.strings = "NA", col.names = c("GlobalEventID","Day","MonthYear","Year","FractionDate","Actor1Code",
#                                                                                                         "Actor1Name","Actor1CountryCode","Actor1KnownGroupCode","Actor1EthnicCode","Actor1Religion1Code","Actor1Religion2Code","Actor1Type1Code","Actor1Type2Code",
#                                                                                                         "Actor1Type3Code","Actor2Code","Actor2Name","Actor2CountryCode","Actor2KnownGroupCode","Actor2EthnicCode", "Actor2Religion1Code","Actor2Religion2Code","Actor2Type1Code",
#                                                                                                         "Actor2Type2Code","Actor2Type3Code","IsRootEvent","EventCode","EventBaseCode","EventRootCode","QuadClass","GoldsteinScale",
#                                                                                                         "NumMentions","NumSources","NumArticles","AvgTone","Actor1Geo_Type","Actor1Geo_Fullname","Actor1Geo_CountryCode","Actor1Geo_ADM1Code","Actor1Geo_Lat","Actor1Geo_Long","Actor1Geo_FeatureID","Actor2Geo_Type","Actor2Geo_Fullname","Actor2Geo_CountryCode",
#                                                                                                         "Actor2Geo_AMD1Code","Actor2Geo_Lat","Actor2Geo_Long","Actor2Geo_FeatureID","ActionGeo_Type","ActionGeo_Fullname",
#                                                                                                         "ActionGeo_CountryCode","ActionGeo_AMD1Code","ActionGeo_Lat","ActionGeo_Long","ActionGeo_FeatureID","Dateadded","Sourceurl") )
# 
#     # gdelt$X <- seq.int(nrow(gdelt))
#     # gdelt <- gdelt[,c("X", setdiff(names(gdelt), "X"))]
#     central_south_gdelt <- dplyr::filter(gdelt, ActionGeo_CountryCode %in% country_codes)
#     central_south_gdelt <- central_south_gdelt[!duplicated(central_south_gdelt$Sourceurl),]
#     unique_gdelt <- unique(central_south_gdelt$Sourceurl)
# 
# 
#     } else{
#     gdelt2 <- read.csv( gdelturl ,sep = "\t",header = TRUE, as.is = FALSE, na.strings = "NA", col.names = c("GlobalEventID","Day","MonthYear","Year","FractionDate","Actor1Code",
#                                                                                                           "Actor1Name","Actor1CountryCode","Actor1KnownGroupCode","Actor1EthnicCode","Actor1Religion1Code","Actor1Religion2Code","Actor1Type1Code","Actor1Type2Code",
#                                                                                                           "Actor1Type3Code","Actor2Code","Actor2Name","Actor2CountryCode","Actor2KnownGroupCode","Actor2EthnicCode", "Actor2Religion1Code","Actor2Religion2Code","Actor2Type1Code",
#                                                                                                           "Actor2Type2Code","Actor2Type3Code","IsRootEvent","EventCode","EventBaseCode","EventRootCode","QuadClass","GoldsteinScale",
#                                                                                                           "NumMentions","NumSources","NumArticles","AvgTone","Actor1Geo_Type","Actor1Geo_Fullname","Actor1Geo_CountryCode","Actor1Geo_ADM1Code","Actor1Geo_Lat","Actor1Geo_Long","Actor1Geo_FeatureID","Actor2Geo_Type","Actor2Geo_Fullname","Actor2Geo_CountryCode",
#                                                                                                           "Actor2Geo_AMD1Code","Actor2Geo_Lat","Actor2Geo_Long","Actor2Geo_FeatureID","ActionGeo_Type","ActionGeo_Fullname",
#                                                                                                           "ActionGeo_CountryCode","ActionGeo_AMD1Code","ActionGeo_Lat","ActionGeo_Long","ActionGeo_FeatureID","Dateadded","Sourceurl") )
# 
#     # gdelt2$X <- seq.int(nrow(gdelt2))
#     # gdelt2 <- gdelt2[,c("X", setdiff(names(gdelt2), "X"))]
#     central_south_gdelt2 <- dplyr::filter(gdelt2, ActionGeo_CountryCode %in% country_codes)
#     central_south_gdelt2 <- central_south_gdelt2[!duplicated(central_south_gdelt2$Sourceurl),]
#     unique_gdelt2 <- unique(central_south_gdelt2$Sourceurl)
# 
#     }
#   if (count == 1){
#     central_south_gdelt_final <- central_south_gdelt
#     rm(central_south_gdelt)
#     rm(gdelt)
#   }else{
#     central_south_gdelt_final <- rbind(central_south_gdelt_final, central_south_gdelt2 )
#     rm(central_south_gdelt2)
#     rm(gdelt2)
#   }
# 
#   if (file.exists(gdelturl)) file.remove(gdelturl)
#   count <- count + 1
# 
# }
# 
# 
# central_south_gdelt_final <- central_south_gdelt_final[!duplicated(central_south_gdelt_final$Sourceurl),]

# central_south_gdelt_final <- as.numeric(central_south_gdelt_final[central_south_gdelt_final$ActionGeo_Lat,])
# central_south_gdelt_final <- as.numeric(central_south_gdelt_final[central_south_gdelt_final$ActionGeo_Long,])


library(shiny)
library(shinydashboard)
library(leaflet)

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(),
  dashboardBody(
  leafletOutput("map", width = "100%", height = "100%")
  # absolutePanel(top =10, right = 10, 
  #               selectInput("ecode", strong("Event Code"), c("All", unique(as.character(mixedsort(central_south_gdelt_final$EventRootCode))))),
  #               selectInput("country", strong("Country"), c("All", unique(as.character(central_south_gdelt_final$ActionGeo_CountryCode))))
  #               )
                
  ))

server <- function(input, output) {
  
  leaflet("map", data = central_south_gdelt_final) %>% 
    setView(lng = -60.2333, lat =-15.9000 , zoom = 3)
    addTiles() %>%
    addCircleMarkers(~jitter(ActionGeo_Long), ~jitter(ActionGeo_Lat),radius = 2 ,
                     fillOpacity = 0.7,
                     popup = content,
                     popupOptions = list(minWidth = 300,maxHeight = 300))
}
  
  
shinyApp(ui, server)
