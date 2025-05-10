newyork <- read.csv('data/new_york.csv')
# View(head(newyork))
# glimpse(newyork)

sanfrancisco <- read.csv('data/san_francisco.csv')
# View(head(sanfrancisco))
# glimpse(sanfrancisco)

amsterdam <- read.csv('data/amsterdam.csv')
# View(head(amsterdam))
# glimpse(amsterdam)

newyork <- newyork %>%
  mutate(price = as.numeric(str_replace_all(price, ",", "")))
# glimpse(newyork)

# Module UI
mod_city_analysis_ui <- function(id, city_name, neighbourhood_choices) {
  ns <- NS(id)
  tabPanel(
    title = city_name,
    icon = icon("city"),
    fluidRow(
      box(
        width = 12, 
        selectInput(ns("quartier"), 
                    "Choisis un quartier", 
                    choices = neighbourhood_choices)
      ),
      box(
        width = 7, 
        title = "Emplacements des logements Airbnb",
        status = "primary", 
        solidHeader = TRUE, 
        leafletOutput(ns("map"), height = "690px")
      ),
      box(
        width = 5,
        fluidRow(
          box(
            width = 12, 
            title = "Prix moyen ($) d’un Airbnb dans ce quartier",
            status = "primary", 
            solidHeader = TRUE, 
            valueBoxOutput(ns("avg_price"), width = 12)
          )
        ),
        br(),
        fluidRow(
          box(
            width = 12, 
            title = "Prix moyen ($) d’un Airbnb par type de logement",
            status = "primary", 
            solidHeader = TRUE, 
            plotlyOutput(ns("price_chart"), height = "450px")
          )
        )
      )
    )
  )
}


# Module Server
mod_city_analysis_server <- function(id, data, neighbourhood_column, price_column) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    filtered_data <- reactive({
      data %>% filter(!!sym(neighbourhood_column) == input$quartier)
    })
    
    output$map <- renderLeaflet({
      leaflet(data = filtered_data()) %>%
        addTiles() %>%
        addMarkers()
    })
    
    output$avg_price <- renderValueBox({
      valueBox(
        value = paste(round(mean(filtered_data()[[price_column]], na.rm = TRUE), 1), "$"),
        subtitle = " ",
        icon = icon("money-bill-wave"),
        color = "purple"
      )
    })
    
    output$price_chart <- renderPlotly({
      data_summary <- filtered_data() %>%
        group_by(room_type) %>%
        summarize(avg_price = mean(!!sym(price_column), na.rm = TRUE), .groups = "drop")
      
      p <- ggplot(data_summary, aes(x = room_type, y = avg_price, fill = room_type)) +
        geom_col(show.legend = FALSE) +
        theme_minimal()
      ggplotly(p)
    })
  })
}
