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
  tabPanel(
    title = city_name,
    icon = icon("city"),
    fluidRow(
      box(
        width = 12, 
        selectInput("quartier", 
                    "Choisis un quartier", 
                    choices = neighbourhood_choices)
      ),
      box(
        width = 7, 
        title = "Emplacements des logements Airbnb",
        status = "primary", 
        solidHeader = TRUE, 
        leafletOutput("map")
      ),
      box(
        width = 5,
        fluidRow(
          box(
            width = 12, 
            title = "Prix moyen ($) d’un Airbnb dans ce quartier",
            status = "primary", 
            solidHeader = TRUE, 
            valueBoxOutput("avg_price", width = 12)
          )
        ),
        br(),
        fluidRow(
          box(
            width = 12, 
            title = "Prix moyen ($) d’un Airbnb par type de logement",
            status = "primary", 
            solidHeader = TRUE, 
            plotlyOutput("price_chart")
          )
        )
      )
    )
  )
)

# User Interface
ui <- dashboardPage(header, sidebar, body)