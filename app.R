library(shinydashboard)
library(shiny)

source("tabs/data_inspect_tab.R")
source("tabs/machine_learning_tab.R")

ui <- dashboardPage(
  dashboardHeader(title = "Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      data_inspect_tab.menuItem,
      machine_learning_tab.menuItem
    )
  ),
  dashboardBody(
    tabItems(
      data_inspect_tab.body,
      machine_learning_tab.body
    )
  )
)

server <- function(input, output) {
  data_inspect_tab.server(input, output)
  machine_learning_tab.server(input, output)
}

shinyApp(ui, server)