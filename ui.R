app_title = "Airbnb Business"

# Header
header <- dashboardHeader(
  title = app_title
)

# Sidebar
sidebar <- dashboardSidebar(disable = TRUE)

city_tabs <- map(cities_info, ~ mod_city_analysis_ui(
  id = .x$input_id_prefix,
  city_name = .x$city_name,
  neighbourhood_choices = .x$neighbourhood_choices
))

# Body
body <- dashboardBody(
  
  tabItem(
    tabName = "Airbnb",
    fluidRow(
      tabsetPanel(
        !!!city_tabs
      )
    )
  )
  
)

# User Interface
ui <- dashboardPage(header, sidebar, body)