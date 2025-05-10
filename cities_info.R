# Liste des infos sur les villes avec configuration

cities_info <- list(
  # Infos pour New York
  list(
    city_name = "New York",
    input_id_prefix = "nyc",
    neighbourhood_choices = unique(newyork$neighbourhood),
    data = newyork,
    neighbourhood_column = "neighbourhood",
    price_column = "price"
  ),
  
  # Infos pour San Francisco
  list(
    city_name = "San Francisco",
    input_id_prefix = "san",
    neighbourhood_choices = unique(sanfrancisco$neighbourhood),
    data = sanfrancisco,
    neighbourhood_column = "neighbourhood",
    price_column = "price"
  ),
  
  # Infos pour Amsterdam
  list(
    city_name = "Amsterdam",
    input_id_prefix = "ams",
    neighbourhood_choices = unique(amsterdam$neighbourhood),
    data = amsterdam,
    neighbourhood_column = "neighbourhood",
    price_column = "price"
  )
  
  # Infos pour Paris
  # list(
  #   city_name = "Paris",
  #   input_id_prefix = "paris",
  #   neighbourhood_choices = unique(paris$neighbourhood),
  #   data = paris,
  #   neighbourhood_column = "neighbourhood",
  #   price_column = "price"
  # )
  
)