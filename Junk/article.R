    ## Download Files

  # Read CSV from Web

    # the url for the online CSV
    url <- "https://raw.githubusercontent.com/fivethirtyeight/data/master/nba-tattoos/nba-tattoos-data.csv"

    # use read.csv to import
    tatoo <- read.csv(url,stringsAsFactors = TRUE)


    # Calculate Percentage of tattoo
    sum(tatoo[,2] == "yes")/nrow(tatoo)


  # Download ZIP File

    # Download and read in GDELT Data for 2017-05-27
    

    # download .zip file and unzip contents
    download.file(url, dest="dataset.zip", mode="wb") 
    unzip ("dataset.zip", exdir = "./")
    unlink("dataset.zip")

## Extract titles and paragraphs
    
    library(rvest)
    
    scraping_wiki <- read_html("https://en.wikipedia.org/wiki/Nigerian_Armed_Forces")
    
    scraping_wiki %>% html_nodes("h1") %>% html_text()

    scraping_wiki %>% html_nodes("h2") %>% html_text()
    
    scraping_wiki %>% html_nodes("p") %>% html_text()
    
    scraping_wiki %>% html_nodes("p") %>% .[[1]] %>% html_text() 
    
    
    
## Extract links
    html_attr(html_nodes(scraping_wiki, "a"), "href") 

## Extract tables
    scraping_wiki <- read_html("https://en.wikipedia.org/wiki/Northern_Fleet")
    
    cities <- scraping_wiki %>% html_nodes("table") %>% .[[1]] %>% html_table(fill=TRUE)
    
    #scraping_wiki %>% html_nodes("table")  %>% .[[2]] %>% html_table(fill=TRUE)
    
    
    ## Automate extraction
    
    ## Extract Maryland Zip Codes
    zip_page <- read_html("https://www.unitedstateszipcodes.org/md/")
    zip <- zip_page %>% html_nodes("table")  %>% .[[2]] %>% html_table(fill=TRUE)
    zip <- as.numeric(zip[4:82,1])
    

    url <- ("http://offender.fdle.state.fl.us/offender/offenderSearchNav.do")
    url <- ("http://www.dpscs.state.md.us/sorSearch/search.do?searchType=byZip&zip=21921&start=1")
    page  <- read_html(url) 
    name <- page %>% html_nodes('#results_tab-List') %>% html_nodes('.reg_name') %>% html_text()
    address <- page %>% html_nodes('#results_tab-List') %>% html_nodes('.cl_item_container') %>% html_text()
    address <-   address[grep("Primary Residence", address)]
    address <- gsub("[\t\r\n]", "", address)
    address <- gsub("Primary Residence : ", "", address)

    myList <- list()
    myList[[1]] <- data.frame(name = name, address = address)
    
    
    links <- html_attr(html_nodes(page, "a"), "href") 
    links <- links[grep("=byZip&zip=21921&",links)]
    
    ##Now let's automate this
    index <- seq(1,91,by=10)
    
    for(i in 2:10){
      url <- paste("http://www.dpscs.state.md.us/sorSearch/search.do?searchType=byZip&zip=21921&start=",index[i],sep="")
      page  <- read_html(url)
      name <- page %>% html_nodes('#results_tab-List') %>% html_nodes('.reg_name') %>% html_text()
      address <- page %>% html_nodes('#results_tab-List') %>% html_nodes('.cl_item_container') %>% html_text()
      address <-   address[grep("Primary Residence", address)]
      address <- gsub("[\t\r\n]", "", address)
      address <- gsub("Primary Residence : ", "", address)
      myList[[i]] <- data.frame(name = name, address = address)
      
      links <- html_attr(html_nodes(page, "a"), "href") 
      links <- links[grep("=byZip&zip=21921&",links)]
      print(i)
    }
    
    require(data.table)
    final <- rbindlist(myList)
    
    require(ggmap)
    loc <- geocode(as.character(final$address))
    loc <- subset(loc,lon>-78 & lat < 40)
    qmplot(lon,lat,data=loc, source = "google", maptype="roadmap", colour = I('red'), size = I(1))

    ##Lazy loading
    
  #Discuss Lazy Loading on mobile.twitter

## INSCOM ``article`` package
    
    #Install 'article'
    require(devtools)
    install_github("maelezo/article", auth_token = 'e626c65d5e2f51b03e4f7c256c2f3efdda338448' )
    
    #Build news source list of articles
    require(article)
    cnn <- build_paper(domain = "http://cnn.com")
    aj <- build_paper(domain = "http://www.aljazeera.com/")
    
    #Get articles from many URL's
    cnn_articles <- get_article(url = cnn[1:10], nlp = False)
    names(cnn_articles)
    
    
    #
  

## Explain ``httr``
    
    #The 'httr' package allows R users to easily execute GET, POST, PUT, and DELETE commands
    # Take a look at https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html
    
    library(httr)
    r <- GET("http://httpbin.org/get")
    
    status_code(r)
    
    headers(r)
    
    str(content(r))
    
    #Several of our packages use 'httr' to interact with an API
    search <- "walt disney"
    
    term <- gsub(' +', ' ', search)
    term <- gsub(' ', '\\+', term)
    
    wikiMain <- 'https://en.wikipedia.org'
    qry <- paste(wikiMain, '/w/api.php?action=query&format=json&list=search&utf8=1&srsearch=',term, sep = "")
    
    #get results
    fetch <- GET(qry)
    
    #parse results
    return <- content(fetch)
    
    df <- as.data.frame(t(sapply(return$query$search, FUN='unlist')), stringsAsFactors = FALSE)
    
    removeHTML <- function(x){
      x %>%
        read_html() %>%
        html_text()
    }
    
    try(df$snippet <- sapply(df$snippet, removeHTML))
    
    ##Selenium Demo


