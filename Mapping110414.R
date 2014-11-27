
# Created 04-Nov-2014
# load needed libraries
library(ggplot2)
library(ggmap)
library(maps)
library(RSQLite)

# set directory where .sqlite file is located
working_directory <- "~/DeskTopFolder/ModestoJuniorCollege/Fall2014_WebDevJavaScript"

# connect to .sqlite file (database)
con_sqlite <- dbConnect(drv = dbDriver("SQLite"), dbname = paste(working_directory, "ipvisits.sqlite", sep = "/"))

# shows table name in database as visitors
dbListTables(con_sqlite) 

# get all records from table visitors
data_visitors <- dbGetQuery(conn = con_sqlite, "SELECT * FROM visitors")

# check structure of data
str(data_visitors)

# get only records that are in USA
usa <- data_visitors[which(data_visitors$country_code %in% "US"), ]

# map waypoints for USA
map <- get_map(location = 'usa', zoom = 4, scale = 2, maptype = "roadmap")
ggmap(map, extent = "device") +
  geom_point(mapping = aes(x = as.numeric(longitude), y = as.numeric(latitude)),
             data = usa, colour = "red", size = 3)

# disconnect database
dbDisconnect(conn = con_sqlite)

