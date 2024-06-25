# Grant Allen
# In this file I will clean the combined data frame we created in the previous file
# Once cleaned, this will be the dataframe used for analysis
rm(list=ls())

area_properties <- read.csv("1_combined_df.csv")

#starting with column names, I remove the "s" from column names where it doesn't make sense
colnames(area_properties)[colnames(area_properties) == "area_names"] <- "area_name"
colnames(area_properties)[colnames(area_properties) == "states"] <- "state"

#cleaning area_page_views column
area_properties$area_page_views <- gsub("total ·", "", area_properties$area_page_views)
area_properties$area_page_views <- trimws(area_properties$area_page_views)
area_properties$area_page_views <- gsub(",","",area_properties$area_page_views)
area_properties$area_page_views <- as.numeric(area_properties$area_page_views)

#cleaning the gps_cords column by splitting it into separate longitude and latitude columns
library(tidyr)
area_properties$gps_cords <- gsub("Google", "", area_properties$gps_cords)
area_properties$gps_cords <- trimws(area_properties$gps_cords)
area_properties <- separate(area_properties, gps_cords, into = c("latitude", "longitude"), sep = ",")
area_properties$latitude <- as.numeric(area_properties$latitude)
area_properties$longitude <- as.numeric(area_properties$longitude)

#cleaning the total_climbs column by converting to numeric
area_properties$total_climbs<- gsub("Total Climbs", "", area_properties$total_climbs)
area_properties$total_climbs<- gsub(",", "", area_properties$total_climbs)
area_properties$total_climbs <- trimws(area_properties$total_climbs)
area_properties$total_climbs <- as.numeric(area_properties$total_climbs)

#resaving the cleaned csv
write.csv(area_properties, file = "2_cleaned_area_properties.csv", row.names = FALSE)
