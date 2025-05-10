library(shiny)
library(shinydashboard)
library(plotly)
library(dplyr)
library(leaflet)
library(purrr)
library(stringr)

# Chargement des données (fichier modifiable pour ajout/supression de villes)
source("data_loader.R")

# Import des fonctions (A ne pas modifier)
source("functions.R") 

# Import des infos des villes (fichier modifiable pour ajout/supression de villes)
source("cities_info.R")

# Import UI et Server (A ne pas modifier)
source("ui.R")
source("server.R")

# Exécuter l'app (A ne pas modifier)
shinyApp(ui = ui, server = server)