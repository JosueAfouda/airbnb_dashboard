# Serveur
server <- function(input, output, session) {
  
  # Données filtrées selon le quartier sélectionné
  filtered_data <- reactive({
    newyork %>% filter(neighbourhood == input[["nyc-quartier"]])
  })
  
  # Carte Leaflet
  output[["nyc-map"]] <- renderLeaflet({
    leaflet(data = filtered_data()) %>%
      addTiles() %>%
      addMarkers()
  })
  
  # ValueBox pour le prix moyen
  output[["nyc-avg_price"]] <- renderValueBox({
    valueBox(
      value = paste(round(mean(filtered_data()[["price"]], na.rm = TRUE), 1), "$"),
      subtitle = " ",
      icon = icon("money-bill-wave"),
      color = "purple"
    )
  })
  
  # Graphique Plotly des prix moyens par type de chambre
  output[["nyc-price_chart"]] <- renderPlotly({
    data_summary <- filtered_data() %>%
      group_by(room_type) %>%
      summarize(avg_price = mean(price, na.rm = TRUE), .groups = "drop")
    
    p <- ggplot(data_summary, aes(x = room_type, y = avg_price, fill = room_type)) +
      geom_col(show.legend = FALSE) +
      theme_minimal()
    
    ggplotly(p)
  })
}
