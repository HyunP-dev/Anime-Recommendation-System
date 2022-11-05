library(shinydashboard)
library(shiny)
library(DBI)

animedb <- dbConnect(RSQLite::SQLite(), "anime.sqlite")
users_number <- dbGetQuery(animedb, "SELECT count(DISTINCT user_id) FROM rating_complete;")
anime_number <- dbGetQuery(animedb, "SELECT count(1) FROM anime;")

studios_number <- dbGetQuery(animedb, "SELECT Studios FROM anime;")[,1] |>
  strsplit(", ") |>
  unlist() |>
  unique() |>
  length()
genres_number <- dbGetQuery(animedb, "SELECT Genres FROM anime;")[,1] |>
  strsplit(", ") |>
  unlist() |>
  unique() |>
  length()

users_number.id <- "usersNumberTxt"
anime_number.id <- "animeNumberTxt"
studios_number.id <- "studiosNumberTxt"
genres_number.id <- "genresNumberTxt"

data_inspect_tab.name <- "data_inspect_tab"

data_inspect_tab.menuItem <- menuItem("Data Inspect",
                                      tabName = data_inspect_tab.name,
                                      icon = icon("database"))

data_inspect_tab.body <-
  tabItem(tabName = data_inspect_tab.name,
          fluidRow(
            valueBoxOutput(users_number.id, width = 3),
            valueBoxOutput(anime_number.id, width = 3),
            valueBoxOutput(studios_number.id, width = 3),
            valueBoxOutput(genres_number.id, width = 3)
          ),
          fluidRow(
            box(plotOutput("plot1", height = 250)),

            box(
              title = "Controls",
              sliderInput("slider", "Number of observations:", 1, 100, 50)
            )
          )
  )

data_inspect_tab.server <- function(input, output) {
  output[[users_number.id]] <- renderValueBox({
    valueBox(users_number, "Users", icon = icon("user"), color = "blue")
  })
  output[[anime_number.id]] <- renderValueBox({
    valueBox(anime_number, "Animations", icon = icon("film"), color = "blue")
  })
  output[[studios_number.id]] <- renderValueBox({
    valueBox(studios_number, "Studios", icon = icon("building"), color = "blue")
  })
  output[[genres_number.id]] <- renderValueBox({
    valueBox(genres_number, "Genres", icon = icon("camera-movie"), color = "blue")
  })
}