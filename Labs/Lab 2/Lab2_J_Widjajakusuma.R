library(sf)
library(dplyr)
library(terra)
library(spData)
data(us_states)
data(us_states_df)

##Q1
us_states_name = dplyr::select(us_states, NAME)
print (us_states_name)
# What is the class of the new object and what makes it geographic?
# The class of the object is a sf object, its geographic due to its 
# multiploygon geometry type, 2 dimensional spatial data with both x and w coordinates
# and the presence of the bounding box which outlites the spatial extent of the collection
# over a specific geographic area

##Q2
pop_one = dplyr::select(us_states, total_pop_10, total_pop_15)
print(pop_one)
pop_two = dplyr::select(us_states, contains("pop"))
print(pop_two)
pop_three = dplyr::select(us_states, matches("^total_pop_"))
print(pop_three)

##Q3
#A.
filter(us_states, REGION == "Midwest")
print (midwest_region)
# answer: Indiana, Kansas, Minnesota, Missouri, North Dakota, South Dakota, Illinois, Iowa, Michigan, Nebraska
#B
west_region = filter(us_states, REGION == "West" & total_pop_15 > 5000000 & as.numeric(AREA) < 250000)
print (west_region)
# answer: Arizona, Colarado, California
#C
south_region = filter(us_states, REGION == "South", as.numeric(AREA) > 150000 & total_pop_15 > 7000000)
print (south_region)

##Q4
total = sum(us_states$total_pop_15)
print(total)
minimum = min(us_states$total_pop_15)
print(minimum)
maximum = max(us_states$total_pop_15)
print(maximum)
# answer: 
# total = 314375347
# minimum = 579679
# maximum = 38421464

##Q5
south = filter(us_states, REGION == "South")
print(nrow(south))
west = filter(us_states, REGION == "West")
print(nrow(west))
northeast = filter(us_states, REGION == "Norteast")
print(nrow(northeast))
midwest = filter(us_states, REGION == "Midwest")
print(nrow(midwest))
# South = 17 states
# West = 11 states
# Northeast = 9 states
# Midwest = 12 states

##Q6
south_pop_total = sum(us_states$total_pop_15[us_states$REGION == "South"])
print(south_pop_total) # Total = 118575377
south_pop_min = min(us_states$total_pop_15[us_states$REGION == "South"])
print(south_pop_min) # Minimum = 647484
south_pop_max = max(us_states$total_pop_15[us_states$REGION == "South"])
print(south_pop_max) # Maximum = 26538614

west_pop_total = sum(us_states$total_pop_15[us_states$REGION == "West"])
print(west_pop_total) # Total = 38421464
west_pop_min = min(us_states$total_pop_15[us_states$REGION == "West"])
print(west_pop_min) # Minimum = 579679
west_pop_max = max(us_states$total_pop_15[us_states$REGION == "West"])
print(west_pop_max) # Maximum = 72264052

northeast_pop_total = sum(us_states$total_pop_15[us_states$REGION == "Norteast"])
print(northeast_pop_total) # Total = 55989520
northeast_pop_min = min(us_states$total_pop_15[us_states$REGION == "Norteast"])
print(northeast_pop_min) # Minimum = 626604
northeast_pop_max = max(us_states$total_pop_15[us_states$REGION == "Norteast"])
print(northeast_pop_max) # Maximum = 19673174

midwest_pop_total = sum(us_states$total_pop_15[us_states$REGION == "Midwest"])
print(midwest_pop_total) # Total = 67546398
midwest_pop_min = min(us_states$total_pop_15[us_states$REGION == "Midwest"])
print(midwest_pop_min) # Minimum = 721640
midwest_pop_max = max(us_states$total_pop_15[us_states$REGION == "Midwest"])
print(midwest_pop_max) # Maximum = 12873761

##Q7
us_states_stat = left_join(us_states, us_states_df, by = c("NAME" = "state"))
# function - left_join() because its used for merging 2 different data frames by matching rows
# from the left data frame to the right data frame based on a common key. The variable that is 
# key is the state and NAME variable which represents the name of the states in each data frames
# the class of the new object is a sf object

##Q8
extra_rows = anti_join(us_states_df, us_states, by = c("state" = "NAME"))
extra_rows
# the extra 2 rows are Alaska and Hawaii, we can find it using the dplyr::anti_join() function

##Q9
us_states_stats_new = us_states_stat %>% mutate(poverty_change = poverty_level_15 - poverty_level_10)
plot(us_states_stats_new["poverty_change"], main = "Change in Poverty Level from 2010 to 2015")

##Q10 - continue this
largest_increase = aggregate(poverty_change ~ REGION, FUN = sum, data = us_states_stats_new, na.rm = TRUE)
max_increase = largest_increase[which.max(largest_increase$poverty_change), ]
# largest increase is the South Region
