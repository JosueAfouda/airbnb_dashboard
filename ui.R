app_title = "Airbnb Business"

# Header
header <- dashboardHeader(
  title = app_title
)

# Sidebar
sidebar <- dashboardSidebar(disable = TRUE)

# Body
city_tabs <- map(cities_info, ~ mod_city_analysis_ui(
  id = .x$input_id_prefix,
  city_name = .x$city_name,
  neighbourhood_choices = .x$neighbourhood_choices
))

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

# Ui Interface
ui <- dashboardPage(header, sidebar, body)
