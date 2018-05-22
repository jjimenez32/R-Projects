# uri <- sprintf("file://%s", system.file(file.path("doc", "Daily Media Highlights06JULY2017.pdf"), package = "tm"))
# if (all(file.exists(Sys.which(c("pdfinfo", "pdftotext"))))){
#   pdf <- readPDF(control = list(text = "-layout"))(elem = list(uri = uri),
#                                                    laguage = "en",
#                                                    id = "id1")
#   content(pdf)[1:13]
# }
# VCorpus(URISource(uri, mode = ""),
#         readerControl = list(reader = readPDF(engine = "ghostscript")))

# dat <- pdf(elem = list( uri = "/home/os184462/Daily Media Highlights 06JUL2017.pdf"), language ='en', id= 'id1')
# 
# 
# out <- read.csv(textConnection(dat), header = FALSE)

#rand <- read.csv("20150612.export.CSV")
# download.file("https://s3.amazonaws.com/africa-gdelt2/africa_gdelt_201701.csv.gz", destfile = "africa_gdelt_201701.csv.gz")
# rand2 <- read.csv("africa_gdelt_201701.csv.gz", as.is = TRUE)
