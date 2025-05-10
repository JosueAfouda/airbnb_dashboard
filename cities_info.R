# # Liste des villes avec config
cities_info <- list(
  list(
    city_name = "New York",
    input_id_prefix = "nyc",
    data = newyork,
    neighbourhood_column = "neighbourhood",
    neighbourhood_choices = unique(newyork$neighbourhood),
    price_column = "price",
    map_output_id = "nyc_map",
    avg_price_output_id = "nyc_quartier_avg_price",
    price_chart_output_id = "nyc_price_chart"
  ),
  list(
    city_name = "San Francisco",
    input_id_prefix = "sf",
    data = sanfrancisco,
    neighbourhood_column = "neighbourhood",
    neighbourhood_choices = unique(sanfrancisco$neighbourhood),
    price_column = "price",
    map_output_id = "sf_map",
    avg_price_output_id = "sf_quartier_avg_price",
    price_chart_output_id = "sf_price_chart"
  ),
  
  # Ajout de la ville Amsterdam
  list(
    city_name = "Amsterdam",
    input_id_prefix = "ams",
    data = amsterdam,
    neighbourhood_column = "neighbourhood",
    neighbourhood_choices = unique(amsterdam$neighbourhood),
    price_column = "price",
    map_output_id = "ams_map",
    avg_price_output_id = "ams_quartier_avg_price",
    price_chart_output_id = "ams_price_chart"
  )
)