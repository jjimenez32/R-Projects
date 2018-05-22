# url <- "http://data.gdeltproject.org/gkg/20170731.gkgcounts.csv.zip"
# download.file(url, dest="dataset.zip", mode="wb")
# unzip ("dataset.zip", exdir = "./")
# unlink("dataset.zip")
# gdelt1 <- read.csv("20170731.gkgcounts.csv", sep = "\t", header = TRUE, as.is = TRUE, na.strings = NA)
# sa2 <- c("GT","SV","GP","PA","PR","GY","CO","EC","PY","SR","UY","VE","PE","SR","GF","FK","CL", "BR", "AR", "CU","CR","BB","BS","AW","AI","HN")
# ca2 <- dplyr::filter(gdelt1, GEO_COUNTRYCODE %in% sa2)
# 
# Ecode <- ca2
# Ecode <- Ecode[!duplicated(Ecode$SOURCEURLS),]

yesterday <- Sys.Date() - 1
yesterday <- gsub("-","", yesterday)


# time <- Sys.time()
# 
# time <- gsub("-", "", time)
# time <- gsub(":", "", time)
# time <- gsub("^.*? ", "" , time)

gdelturl <- paste("http://data.gdeltproject.org/events/", ".export.CSV.zip", sep = yesterday)

download.file(gdelturl, dest= "dataset1.zip", mode = "wb")
unzip("dataset1.zip", exdir = "./")
unlink("dataset1.zip")

gkgurl <- paste("http://data.gdeltproject.org/gkg/" , ".gkgcounts.csv.zip" , sep = yesterday)

download.file(gkgurl, dest = "dataset2.zip", mode = "wb")
unzip("dataset2.zip", exdir = "./")
unlink("dataset2.zip")

gdelturl <- gsub("http://data.gdeltproject.org/events/" , "" , gdelturl)
gkgurl <- gsub("http://data.gdeltproject.org/gkg/", "" , gkgurl)

gdelturl <- gsub(".zip", "", gdelturl)
gkgurl <- gsub(".zip", "" , gkgurl)
gkg <- read.csv( gkgurl , sep = "\t", header = TRUE, as.is = TRUE, na.strings = "NA")
gdelt <- read.csv( gdelturl ,sep = "\t",header = TRUE, as.is = TRUE, na.strings = "NA", col.names = c("GlobalEventID","Day","MonthYear","Year","FractionDate","Actor1Code",
                                                                                      "Actor1Name","Actor1CountryCode","Actor1KnownGroupCode","Actor1EthnicCode","Actor1Religion1Code","Actor1Religion2Code","Actor1Type1Code","Actor1Type2Code",
                                                                                      "Actor1Type3Code","Actor2Code","Actor2Name","Actor2CountryCode","Actor2KnownGroupCode","Actor2EthnicCode", "Actor2Religion1Code","Actor2Religion2Code","Actor2Type1Code",
                                                                                      "Actor2Type2Code","Actor2Type3Code","IsRootEvent","EventCode","EventBaseCode","EventRootCode","QuadClass","GoldsteinScale",
                                                                                      "NumMentions","NumSources","NumArticles","AvgTone","Actor1Geo_Type","Actor1Geo_Fullname","Actor1Geo_CountryCode","Actor1Geo_ADM1Code","Actor1Geo_Lat","Actor1Geo_Long","Actor1Geo_FeatureID","Actor2Geo_Type","Actor2Geo_Fullname","Actor2Geo_CountryCode",
                                                                                      "Actor2Geo_AMD1Code","Actor2Geo_Lat","Actor2Geo_Long","Actor2Geo_FeatureID","ActionGeo_Type","ActionGeo_Fullname",
                                                                                      "ActionGeo_CountryCode","ActionGeo_AMD1Code","ActionGeo_Lat","ActionGeo_Long","ActionGeo_FeatureID","Dateadded","Sourceurl") )



gdelt$X <- seq.int(nrow(gdelt))
gdelt <- gdelt[,c("X", setdiff(names(gdelt), "X"))]


country_codes <- c("GT","SV","GP","PA","PR","GY","CO","EC","PY","SR","UY","VE","PE","SR","GF","FK","CL", "BR", "AR", "CU","CR","BB","BS","AW","AI","HN")
central_south_gdelt <- dplyr::filter(gdelt, ActionGeo_CountryCode %in% country_codes)
central_south_gkg <- dplyr::filter(gkg, GEO_COUNTRYCODE %in% country_codes)

central_south_gdelt <- central_south_gdelt[!duplicated(central_south_gdelt$Sourceurl),]
central_south_gkg <- central_south_gkg[!duplicated(central_south_gkg$SOURCEURLS),]

unique_gdelt <- unique(central_south_gdelt$Sourceurl)
unique_gkg <- unique(central_south_gkg$SOURCEURLS)
