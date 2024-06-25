#Grant Allen
#This file is used to quickly manually enter soil property data from each of the 10 climbing areas scraped in mp_scraping file
#the data will be entered in the same order as climbing areas are listed in mp_df data frame

rm(list=ls())

area_names <- c("Wasatch Range", "Joshua Tree National Park", "Yosemite National Park", "Sierra Eastside", "The Gunks", "Boulder", "Smith Rock", "Red River Gorge", "Red Rocks", "Southeast Utah")
avail_water_holding_capacity <- c(6, 5, 6, 6, 20, 5, 8, 11, 3, 2)
drainage_class <- c("Well drained", "Somewhat excessively drained", "Somewhat excessively drained", "Somewhat excessively drained", "Well drained", "Somewhat excessively drained", "Well drained", "Well drained", "Well drained", "Well drained")
rock_fragments <- c(43, 40, 31, 42, 21, 44, 32, 12, 51, 37)
sand <- c(40, 85, 81, 82, 36, 69, 29, 46, 49, 69)
silt <- c(30, 15, 16, 19, 48, 22, 37, 23, 34, 8)
clay <- c(20, 8, 2, 5, 12, 11, 31, 16, 16, 9)
soil_depth <- c(120, 125, 153, 62, 89, 129, 87, 130, 71, 43)
soil_order <- c("mollisols", "entisols", "entisols", "entisols", "inceptisols", "inceptisols", "mollisols", "inceptisols", "mollisols", "entisols")

#creating the dataframe with all vectors
soil_df <- data.frame(area_names, avail_water_holding_capacity, drainage_class, rock_fragments, sand, silt, clay, soil_depth, soil_order)

#saving as csv
write.csv(soil_df, "0_soil_df.csv", row.names = FALSE)
