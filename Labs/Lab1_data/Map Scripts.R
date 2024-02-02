library(sf)
library(tmap)

# readings files
Champaign_tracts = st_read("Lab1_data/Champaign_county_census_tracts.shp")
Champaign_Zips = st_read("Lab1_data/Champaign_county_zip_codes.shp")

## FIRST LAYER: CENSUS TRACT BOUNADRIES
tm_shape(Champaign_tracts) + tm_fill(col = "gray90") +
  tm_borders(alpha=0.2, col = "gray10") + 
  
  ## SECOND LAYER: ZIP CODE BOUNDARIES WITH LABEL
  tm_shape(Champaign_Zips) + tm_borders(lwd = 2, col = "#0099CC") +
  tm_text("zip", size = 0.7) +
  
  ## MORE CARTOGRAPHIC STYLE
  tm_scale_bar(position = ("left"), lwd = 0.8) +
  tm_layout(frame = FALSE, main.title = "Census tracts and zip code boundaries, Champaign County, IL", main.title.size=0.86
  )

            