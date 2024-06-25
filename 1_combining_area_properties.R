# Grant Allen
# This file will be used to horizontally merge the mountain project and soil csvs
# I will merge the files using the common column of area_names
rm(list=ls())

mp_df <- read.csv("0_mp_df.csv")

soil_df <- read.csv("0_soil_df.csv")

combined_df <- merge(mp_df, soil_df, by="area_names")

#saving as csv
write.csv(combined_df, "1_combined_df.csv", row.names = FALSE)
