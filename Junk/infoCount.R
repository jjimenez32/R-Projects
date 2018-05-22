plotPopByCountry <-function(popData, countryToPlot){
  infoCount <- info[info$year == countryToPlot,]
  p <-ggplot(data = infoCount, aes(x = year, y = pop)) + geom_point()
  return(p)
}