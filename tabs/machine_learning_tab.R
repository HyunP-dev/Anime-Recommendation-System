library(shinydashboard)
library(shiny)

machine_learning_tab.name <- "machine_learning_tab"

machine_learning_tab.menuItem <-
  menuItem("Machine Learning", tabName = machine_learning_tab.name, icon = icon("brain"))

machine_learning_tab.body <-
  tabItem(tabName = machine_learning_tab.name,
          h2("Widgets tab content")
  )

machine_learning_tab.server <- function(input, output) {

}