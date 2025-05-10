# # Liste des villes avec config
cities_info_ui <- list(
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
  )
)