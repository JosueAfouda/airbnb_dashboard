# Serveur
server <- function(input, output, session) {
  
  walk(
    cities_info,
    ~ mod_city_analysis_server(
      id = .x$input_id_prefix,
      data = .x$data,
      neighbourhood_column = .x$neighbourhood_column,
      price_column = .x$price_column
    )
  )
  
}
