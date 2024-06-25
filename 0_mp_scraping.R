#Grant Allen
#This file is used to scrape the information on the top 10 climbing areas in the United States on the website Mountain Project.

# Areas scraped: Wasatch Range (Utah), Joshua Tree (California), Yosemite (California), Sierra Eastside/Bishop (California), The Gunks (New York), Boulder (Colorado), Smith Rock (Oregon),
# Red River Gorge (Kentucky), Red Rocks (Nevada), Southeast Utah/Moab (Utah)


rm(list=ls())


#We will use the package xml2 to scrape
library(xml2)

#Initializing the vectors we will use to store all area data
area_names <- character(0)
states <- character(0)
area_page_views <- character(0)
total_climbs <- character(0)
gps_cords <- character(0)
trad_climbs <- integer(0)
sport_climbs <- integer(0)
toprope_climbs <- integer(0)
boulder_climbs <- integer(0)
ice_climbs <- integer(0)
aid_climbs <- integer(0)
mixed_climbs <- integer(0)
alpine_climbs <- integer(0)
table <- character(0)
count <- 0

#Creating the list of climbing areas that the web scraper will iterate through
url_list <- c("https://www.mountainproject.com/area/105739213/wasatch-range", 
              "https://www.mountainproject.com/area/105720495/joshua-tree-national-park", 
              "https://www.mountainproject.com/area/105833381/yosemite-national-park", 
              "https://www.mountainproject.com/area/105798288/sierra-eastside", 
              "https://www.mountainproject.com/area/105798167/the-gunks",
              "https://www.mountainproject.com/area/105801420/boulder",
              "https://www.mountainproject.com/area/105788989/smith-rock",
              "https://www.mountainproject.com/area/105841134/red-river-gorge",
              "https://www.mountainproject.com/area/105731932/red-rocks",
              "https://www.mountainproject.com/area/105716711/southeast-utah")

#setting the user agent
user_agent <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36"

for (i in url_list){
  count + 1
  print(i)
  Sys.sleep(10)
  #Establish the url for the specific climbing area, the first climbing area to be scraped is Wasatch range (this will need to be changed and the steps following repeated for each area)
  url <- i
  
  #accesing the page with the user agent
  page <- read_html(url, user_agent)
  
  #extracting the area name and adding it to the vector
  area_name <- xml_text(xml_find_all(page, "//h1"))
  area_names <- c(area_names, area_name)
  
  #extracting the area state and adding it to the vector
  state <- xml_text(xml_find_all(page, "//div[@class='mb-half small text-warm']"))
  states <- c(states, state)
  
  #extracting the table data, from this I will pull page views and gps
  table <- xml_text(xml_find_all(page, "//table[@class='description-details']"))
  table <- unlist(strsplit(table, "\n"))
  area_page_view <- table[10]
  area_page_views <- c(area_page_views, area_page_view)
  gps_cord <- table[5]
  gps_cords <- c(gps_cords, gps_cord)
  
  #extracting the total number of climbs for each area and additing it to the vector
  total_climb <- xml_text(xml_find_all(page, "//div[@class='col-lg-6 text-xs-center']/h2"))
  total_climb <- total_climb[-2]
  total_climbs <- c(total_climbs, total_climb)
  
  #making the program wait between each page to mimic human behavior
  random_value <- sample(3:15, 1)
  print(paste("waiting", random_value, "seconds"))
  Sys.sleep(random_value)
  print("Moving to the next url")

}

#adding in the data that had to be manually scraped
trad_climbs <- c(1878, 4381, 1649, 1283, 885, 2844, 398, 806, 1563, 2751)
sport_climbs <- c(2826, 721, 400, 2266, 0, 1547, 933, 2145, 962, 348)
toprope_climbs <- c(411, 658, 214, 359, 253, 464, 70, 38, 131, 73)
boulder_climbs <- c(1687, 1437, 607, 2518, 250, 1237, 84, 236, 18, 329)
ice_climbs <- c(142, 0, 0, 38, 0, 0, 0, 0, 0, 0)
aid_climbs <- c(58, 0, 144, 13, 10, 27, 11, 0, 19, 319)
mixed_climbs <- c(95, 0, 0, 31, 0, 0, 6, 0, 0, 0)
alpine_climbs <- c(221, 0, 240, 292, 0, 0, 0, 0, 0, 0)


#combining to create the data frame that will be cleaned
mp_df <- data.frame(area_names, states, area_page_views, gps_cords, total_climbs, trad_climbs, sport_climbs, toprope_climbs, boulder_climbs, ice_climbs, aid_climbs, mixed_climbs, alpine_climbs)


#before saving as csv, I do some initial cleaning so the saving goes smoothly
#cleaning area names
mp_df$area_names <- gsub("Climbing", "", mp_df$area_names)
mp_df$area_names <- gsub(" Rock ", "", mp_df$area_names)
mp_df$area_names <- trimws(mp_df$area_names)

#cleaning states
mp_df$states <- trimws(mp_df$states)
mp_df$states <- gsub("All Locations", "", mp_df$states)
mp_df$states <- gsub(">", "", mp_df$states)
mp_df$states <- gsub("Central Oregon", "", mp_df$states)
mp_df$states <- gsub("Southern Nevada", "", mp_df$states)
mp_df$states <- trimws(mp_df$states)

#saving the data frame as a csv to import into the cleaning script
write.csv(mp_df, "0_mp_df.csv", row.names = FALSE)
