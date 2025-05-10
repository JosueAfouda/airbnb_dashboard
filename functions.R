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
        title = "Emplacement des logements Airbnb",
        status = "primary",
        solidHeader = TRUE,
        leafletOutput(ns("map"), height = "690px")
      ),
      box(
        width = 5,
        fluidRow(
          box(
            width = 12,
            title = "prix moyen ($) d'un Airbnb dans ce quartier",
            status = "primary",
            solidHeader = TRUE,
            valueBoxOutput(ns("avg_price"), width = 12)
          )
        ),
        br(),
        fluidRow(
          box(
            width = 12,
            title = "Prix moyen ($) d'un Airbnb par type de logement",
            status = "primary",
            solidHeader = TRUE,
            plotlyOutput(ns("price_chart"),height = "480px")
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
    
    # Données filtrées pour le quartier sélectionné par l'utilisateur
    filtered_data <- reactive({
      data %>% filter(!!sym(neighbourhood_column) == input$quartier)
    })
    
    # Carte leaflet
    output$map <- renderLeaflet({
      leaflet(data = filtered_data()) %>% 
        addTiles() %>% 
        addMarkers()
    })
    
    # ValueBox pour le prix moyen
    output$avg_price <- renderValueBox({
      valueBox(
        value = paste(round(mean(filtered_data()[[price_column]], na.rm = TRUE), 1), "$"),
        subtitle = " ",
        icon = icon("money-bill-wave"),
        color = "purple"
      )
    })
    
    # Diagramme en barres du prix moyen par type de logement
    output$price_chart <- renderPlotly({
      data_summary <- filtered_data() %>% 
        group_by(room_type) %>% 
        summarize(avg_price = mean(!!sym(price_column), na.rm = TRUE), .groups = "drop")
      
      ggplot(data_summary, aes(x = room_type, y = avg_price, fill = room_type)) +
        geom_col(show.legend = FALSE) +
        theme_minimal()
      
    })
    
  })
}
