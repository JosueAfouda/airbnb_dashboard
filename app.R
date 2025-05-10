library(shiny)
library(shinydashboard)
library(plotly)
library(dplyr)
library(leaflet)
library(purrr)
library(stringr)

# Import des fonctions/Modules
source("functions.R")

# Import UI et Server
source("ui.R")
source("server.R")

# Définir l'application Shiny
shinyApp(ui = ui, server = server)
