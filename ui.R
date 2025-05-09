app_title = "Airbnb Business"

# Header
header <- dashboardHeader(
  title = app_title,
  tags$li(
    class = "dropdown",
    tags$a(
      href = "https://www.linkedin.com/in/josu%C3%A9-afouda",
      "Author: Josué AFOUDA",
      target = "_blank",
      style = "color: yellow;" # Add this line to set the text color to black
    )
  )
)

# Sidebar
sidebar <- dashboardSidebar(disable = TRUE)

city_tabs <- map(city_info(), ~ mod_city_analysis_ui(
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