app_title = "Airbnb Business"

# Header
header <- dashboardHeader(
  title = app_title
)

# Sidebar
sidebar <- dashboardSidebar()

# Body
neighbourhood_choices <- unique(newyork$neighbourhood)
city_name <- "NewYork"
body <- dashboardBody(
  mod_city_analysis_ui(id = "nyc", 
                       city_name = city_name, 
                       neighbourhood_choices = neighbourhood_choices)
)

# User Interface
ui <- dashboardPage(header, sidebar, body)