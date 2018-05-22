get_article <- function (url = NULL, nlp = FALSE, language = "en") 
{
    require(rPython)
    require(data.table)
    python.exec("from newspaper import Article")
    myList <- list()
    for (i in 1:length(url)) {
        Command <- paste("first_article = Article(url='", url[i], 
            "', language='", language, "')", sep = "")
        try(python.exec(Command))
        try(python.exec("first_article.download()"))
        try(python.exec("first_article.parse()"))
        try(python.exec("a = first_article.title"))
        ti <- python.get("a")
        try(python.exec("a = first_article.authors"))
        au <- python.get("a")
        try(python.exec("a = first_article.text"))
        tx <- python.get("a")
        try(python.exec("a = first_article.top_image"))
        top <- python.get("a")
        try(python.exec("b = first_article.images"))
        img <- python.get("b")
        try(python.exec("b = first_article.movies"))
        mov <- python.get("b")
        au <- paste(au, collapse = "; ")
        img <- paste(img, collapse = "; ")
        mov <- paste(mov, collapse = "; ")
        if (nlp) {
            try(python.exec("first_article.nlp()"))
            try(python.exec("a = first_article.summary"))
            sum <- python.get("a")
            try(python.exec("b = first_article.keywords"))
            key <- python.get("b")
            key <- paste(key, collapse = "; ")
            myList[[i]] <- data.frame(title = ti, authors = au, 
                text = tx,
                topImage = top,
                summary = sum,
                keywords = key,
                images = img,
                movies = mov,
                url = url[i]
                )
        }
        else {
            myList[[i]] <- data.frame(title = ti, authors = au, 
                text = tx,
                topImage = top,
                images = img,
                movies = mov,
                url = url[i]
                )
        }
    }
    return(rbindlist(myList))
    # return(rbind(myList))
}

articles <- get_article(central_south_gkg$SOURCEURLS)