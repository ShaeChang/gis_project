
# Final Project
# Xiyu Zhang
# 2022-11-14

# Set up ------------------------------------------------------------------

library(tidyverse)
library(sf)
library(tmap)

tmap_mode('view')

# Load polygon data -------------------------------------------------------

# load the North American Electric Reliability Corporation (NERC) Regions 
# GIS Data

RFC_area <- 
  st_read('data/NERC_Regions.geojson') %>% 
  
  # select the region of interest
  # we choose Reliability First Corporation (RFC), which includes NJ, PA, DE, 
  # MD, VA, WV, OH, MI, KY, TN, IN, IL, WI, and DC.
  
  filter(NERC == 'RFC')

# load the census data of the interested states

census_region <-
  st_read('data/cb_2021_us_county_within_cd116_500k/cb_2021_us_county_within_cd116_500k.shp') %>% 
  
  # select states of interest by State FIPS Code
  
  filter(STATEFP %in% 
           c(34, 42, 10, 24, 51, 54, 39, 26, 21, 47, 18, 17, 55, 11)) %>% 
  
  # transform the CRS to the same as other GIS files
  
  st_transform(crs = 
                 st_crs(RFC_area))

# Load point data ---------------------------------------------------------

# load the location of the alternative fuel stations

alt_fuel_stations <-
  st_read('data/alt_fuel_stations_Nov_6_2022.geojson') %>% 
  
  # filter the electricity fuel stations, which is our interest
  
  filter(fuel_type_code == 'ELEC') %>% 
  
  # select the interest features
  
  select(access_code, id, city, state, street_address, zip)

# load the location of Addresses of power plants

power_plant <-
  st_read('data/Power_Plants.geojson')


