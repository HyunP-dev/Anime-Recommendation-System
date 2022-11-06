library(shinydashboard)
library(shiny)
library(DBI)

animedb <- dbConnect(RSQLite::SQLite(), "anime.sqlite")
users_number <- dbGetQuery(animedb, "SELECT count(DISTINCT user_id) FROM rating_complete;")
anime_number <- dbGetQuery(animedb, "SELECT count(1) FROM anime;")

studios_number <- dbGetQuery(animedb, "SELECT Studios FROM anime;")[, 1] |>
  strsplit(", ") |>
  unlist() |>
  unique() |>
  length()
genres_number <- dbGetQuery(animedb, "SELECT Genres FROM anime;")[, 1] |>
  strsplit(", ") |>
  unlist() |>
  unique() |>
  length()

users_number.id <- "usersNumberTxt"
anime_number.id <- "animeNumberTxt"
studios_number.id <- "studiosNumberTxt"
genres_number.id <- "genresNumberTxt"

id_input.id <- "idInput"
sql_input.id <- "sqlInput"
sql_output.id <- "sqlOutput"
sql_button.id <- "sqlRun"

data_inspect_tab.name <- "data_inspect_tab"

data_inspect_tab.menuItem <- menuItem("Data Inspect",
  tabName = data_inspect_tab.name,
  icon = icon("database")
)

data_inspect_tab.body <-
  tabItem(
    tabName = data_inspect_tab.name,
    fluidRow(
      valueBoxOutput(users_number.id, width = 3),
      valueBoxOutput(anime_number.id, width = 3),
      valueBoxOutput(studios_number.id, width = 3),
      valueBoxOutput(genres_number.id, width = 3)
    ),
    tabsetPanel(
      type = "tabs",
      tabPanel(
        "SQL Query",
        div(style = "height: 10px;"),
        textInput(sql_input.id, "SQL Query",
          value = "SELECT * FROM anime LIMIT 5;",
          width = "calc(100% - 60px)"
        ),
        tags$style(
          type = "text/css",
          paste0("#", sql_input.id, " {float: left;}")
        ),
        actionButton(sql_button.id, "RUN",
          style = "width: 50px; margin-top: -20px; margin-left:10px;"
        ),
        div(style = "height: 10px;"),
        DT::dataTableOutput(sql_output.id)
      ),
      tabPanel(
        "USER Inspect",
        sidebarLayout(
          sidebarPanel(
            textInput(id_input.id, "USER ID:", value = ""),
            sliderInput(
              inputId = "bins",
              label = "Number of bins:",
              min = 1,
              max = 50,
              value = 30
            )
          ),
          mainPanel(
            plotOutput(outputId = "distPlot")
          )
        )
      )
    )
  )


data_inspect_tab.server <- function(input, output, session) {
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

  reactive_df <- reactiveValues(data = NULL)
  observeEvent(input[[sql_button.id]], {
    reactive_df$data <- dbGetQuery(animedb, input[[sql_input.id]])
  })

  output[[sql_output.id]] <- DT::renderDataTable({
    DT::datatable(reactive_df$data, options = list(pageLength = 10))
  })
}