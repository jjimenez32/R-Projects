



library("aws.s3")
Sys.setenv("AWS_ACCESS_KEY_ID" = "AKIAJ52XWTI6BQMHMT3A",
           
           "AWS_SECRET_ACCESS_KEY" = "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",
           
           "AWS_DEFAULT_REGION" = "us-east-1")


# library(devtools)
# require(gdeltcol)


# afg <- subset_gdelt_country(type = "aws", start = "2017-06-28", stop = "2017-06-29")





fighting <- subset(ca2, EventRootCode == 19)



unique_articles <- unique(fighting$Sourceurl)



max(table(fighting$Sourceurl))


require(article)

myArticles <- get_article(unique_articles)

require(dplyr)

fighting <- dplyr::left_join(fighting, myArticles, by = c("Sourceurl" = "url"))



table(fighting$ActionGeo_Lat)


content <- paste(sep = "",
                 
                 "<b>Title: </b>", 
                 
                 fighting$title, "<br/>",
                 
                 "<b>Summary: </b>", "<br/>",
                 
                 fighting$text , "<br/>"
                 
)


require(leaflet)

leaflet(data = fighting) %>%
  
  addTiles() %>%  # Add default OpenStreetMap map tiles
  
  addCircleMarkers(~jitter(ActionGeo_Long), ~jitter(ActionGeo_Lat),radius = 2 ,
                   
                   fillOpacity = 0.7,
                   
                   popup= content,
                   
                   popupOptions = list(minWidth = 300,maxHeight = 300))
