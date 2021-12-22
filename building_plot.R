library(sf)
library(mapview)
library(htmlwidgets)
library(leaflet)

buildings <- st_read("utrecht-latest-free/gis_osm_buildings_a_free_1.shp")
land <- st_read("utrecht-latest-free/gis_osm_landuse_a_free_1.shp")

mapview(buildings)
mapview(land)



lat <- 52.092877
lon <- 5.086639

m <- leaflet() %>% 
  setView(lon, lat, zoom = 15) %>% 
  addProviderTiles("CartoDB.Positron", group = "CartoDB") %>%
  addProviderTiles("Esri.WorldImagery", group = "Esri Satellite") %>%
  addProviderTiles("OpenStreetMap", group = "Open Street Map") %>% 
  addScaleBar(position = "bottomleft", options = scaleBarOptions(maxWidth = 200, metric = TRUE, imperial = TRUE, updateWhenIdle = TRUE)) %>% 
  leafem::addMouseCoordinates(proj4string = CRS(ukgrid), native.crs = F)

m <- m %>% addPolygons(data = buildings, color = "black", weight = 1, smoothFactor = 0.5,
                       opacity = 1.0, fillOpacity = 0.2,
                       fillColor = "yellow",
                       highlightOptions = highlightOptions(color = "white", weight = 2,
                                                           bringToFront = FALSE), group = "Scoping Area")

saveWidget(m, file="buildings.html")
