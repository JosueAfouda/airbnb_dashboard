
######### Création du Module ##################

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


# Définir les informations pour chaque ville
city_info <- function() {
  
  city_info_list <- list(
    list(
      city_name = "New York",
      input_id_prefix = "nyc",
      neighbourhood_choices = unique(newyork$neighbourhood),
      map_output_id = "nyc_map",
      avg_price_output_id = "nyc_quartier_avg_price",
      price_chart_output_id = "nyc_price_chart"
    ),
    list(
      city_name = "San Francisco",
      input_id_prefix = "sf",
      neighbourhood_choices = unique(sanfrancisco$neighbourhood),
      map_output_id = "sf_map",
      avg_price_output_id = "sf_quartier_avg_price",
      price_chart_output_id = "sf_price_chart"
    ),
    list(
      city_name = "Amsterdam",
      input_id_prefix = "ams",
      neighbourhood_choices = unique(amsterdam$neighbourhood),
      map_output_id = "ams_map",
      avg_price_output_id = "ams_quartier_avg_price",
      price_chart_output_id = "ams_price_chart"
    )
    # list(  # Nouvelle ville ajoutée ici
    #   city_name = "Paris",
    #   input_id_prefix = "paris",
    #   neighbourhood_choices = unique(paris$neighbourhood),
    #   map_output_id = "paris_map",
    #   avg_price_output_id = "paris_quartier_avg_price",
    #   price_chart_output_id = "paris_price_chart"
    # )
  )
  
  city_info_list
  
}


newyork <- read.csv('data/new_york.csv')
sanfrancisco <- read.csv('data/san_francisco.csv')
amsterdam <- read.csv('data/amsterdam.csv')

newyork <- newyork %>%
  mutate(price = as.numeric(str_replace_all(price, ",", "")))


# Simulation de l'ajout des données d'une 4eme ville pour tester le Module
# paris <- read.csv('data/paris.csv')
# paris <- paris %>%
#   mutate(price = as.numeric(str_replace_all(price, ",", "")))



city_info_server <- function() {
  
  # Liste des informations des villes (identique à l'UI)
  city_info <- list(
    list(
      input_id_prefix = "nyc",
      data = newyork,
      neighbourhood_column = "neighbourhood",
      price_column = "price",
      map_output_id = "nyc_map",
      avg_price_output_id = "nyc_quartier_avg_price",
      price_chart_output_id = "nyc_price_chart"
    ),
    list(
      input_id_prefix = "sf",
      data = sanfrancisco,
      neighbourhood_column = "neighbourhood",
      price_column = "price",
      map_output_id = "sf_map",
      avg_price_output_id = "sf_quartier_avg_price",
      price_chart_output_id = "sf_price_chart"
    ),
    list(
      input_id_prefix = "ams",
      data = amsterdam,
      neighbourhood_column = "neighbourhood",
      price_column = "price",
      map_output_id = "ams_map",
      avg_price_output_id = "ams_quartier_avg_price",
      price_chart_output_id = "ams_price_chart"
    )
    # list(  # Paris ajouté ici
    #   input_id_prefix = "paris",
    #   data = paris,
    #   neighbourhood_column = "neighbourhood",
    #   price_column = "price",
    #   map_output_id = "paris_map",
    #   avg_price_output_id = "paris_quartier_avg_price",
    #   price_chart_output_id = "paris_price_chart"
    # )
  )
  
  city_info
  
}

# ui et server ne vont pas changer quel que soit le nombre de villes qu'on va ajouter au dashboard