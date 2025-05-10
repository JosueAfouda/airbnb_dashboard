library(shiny)
library(shinydashboard)
library(plotly)
library(dplyr)
library(leaflet)
library(purrr)
library(stringr)

# Import des fonctions/Modules (A ne pas Modifier)
source("functions.R")

# Chargement des données (fichier fichier modifianle pour ajout/supression de ville)
source("data_loader.R")

# Import des informations sur les villes (fichier modifianle pour ajout/supression de ville)
source("cities_info.R")

# Import UI et Server (A ne pas modifier)
source("ui.R")
source("server.R")

# Définir l'application Shiny (A ne pas modifier)
shinyApp(ui = ui, server = server)
