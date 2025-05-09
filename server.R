# server
server <- function(input, output, session) {
  
  purrr::walk(
    city_info_server(),
    ~ mod_city_analysis_server(
      id = .x$input_id_prefix,
      data = .x$data,
      neighbourhood_column = .x$neighbourhood_column,
      price_column = .x$price_column
    )
  )
  
}