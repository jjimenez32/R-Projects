info2 <- read.csv("20170717.export.CSV",sep = "\t",header = TRUE, as.is = TRUE, na.strings = "NA", col.names = c("GlobalEventID","Day","MonthYear","Year","FractionDate","Actor1Code",
                                                                                      "Actor1Name","Actor1CountryCode","Actor1KnownGroupCode","Actor1EthnicCode","Actor1Religion1Code","Actor1Religion2Code","Actor1Type1Code","Actor1Type2Code",
                                                                                      "Actor1Type3Code","Actor2Code","Actor2Name","Actor2CountryCode","Actor2KnownGroupCode","Actor2EthnicCode", "Actor2Religion1Code","Actor2Religion2Code","Actor2Type1Code",
                                                                                      "Actor2Type2Code","Actor2Type3Code","IsRootEvent","EventCode","EventBaseCode","EventRootCode","QuadClass","GoldsteinScale",
                                                                                      "NumMentions","NumSources","NumArticles","AvgTone","Actor1Geo_Type","Actor1Geo_Fullname","Actor1Geo_CountryCode","Actor1Geo_ADM1Code","Actor1Geo_Lat","Actor1Geo_Long","Actor1Geo_FeatureID","Actor2Geo_Type","Actor2Geo_Fullname","Actor2Geo_CountryCode",
                                                                                      "Actor2Geo_AMD1Code","Actor2Geo_Lat","Actor2Geo_Long","Actor2Geo_FeatureID","ActionGeo_Type","ActionGeo_Fullname",
                                                                                      "ActionGeo_CountryCode","ActionGeo_AMD1Code","ActionGeo_Lat","ActionGeo_Long","ActionGeo_FeatureID","Dateadded","Sourceurl") )



info2$X <- seq.int(nrow(info2))
info2 <- info2[,c("X", setdiff(names(info2), "X"))]


sa2 <- c("GT","SV","GP","PA","PR","GY","CO","EC","PY","SR","UY","VE","PE","SR","GF","FK","CL", "BR", "AR", "CU","CR","BB","BS","AW","AI","HN")
ca2 <- dplyr::filter(info2, ActionGeo_CountryCode %in% sa)

