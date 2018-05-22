# library(RgoogleMaps)
# lat <- c(48,64) #define our map's ylim
# lon <- c(-140,-110) #define our map's xlim
# center = c(mean(lat), mean(lon))  #tell what point to center on
# zoom <- 5  #zoom: 1 = furthest out (entire globe), larger numbers = closer in
# terrmap <- GetMap(center=center, zoom=zoom, maptype= "terrain", destfile = "terrain.png") #lots of visual options, just like google maps: maptype = c("roadmap", "mobile", "satellite", "terrain", "hybrid", "mapmaker-roadmap", "mapmaker-hybrid")
samps$size <- "small"  #create a column indicating size of marker
samps$col <- "red"   #create a column indicating color of marker
samps$char <- ""   #normal Google Maps pinpoints will be drawn
mymarkers <- cbind.data.frame(samps$lat, samps$lon, samps$size, samps$col, samps$char)   #create the data frame by binding my data columns of GPS coordinates with the newly created columns
names(mymarkers) <- c("lat", "lon", "size", "col", "char")  #assign column headings
lat <- c(48,60)  #now we are plotting the map
lon <- c(-140,-110)
terrain_close <- GetMap.bbox(lonR= range(lon), latR= range(lat), center= c(49.7, -121.05), destfile= "terrclose.png", markers= mymarkers, zoom=13, maptype="terrain")
