# Serveur
server <- function(input, output, session) {
  
  mod_city_analysis_server(id = "nyc", 
                           data = newyork, 
                           neighbourhood_column = "neighbourhood", 
                           price_column = "price")
  
}
