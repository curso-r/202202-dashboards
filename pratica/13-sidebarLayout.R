library(shiny)
library(dplyr)

pkmn <- readr::read_rds("../dados/pkmn.rds")

ui <- fluidPage(
  titlePanel("Shiny com sidebarLayout"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput(
        "pokemon",
        label = "Selecione um Pokemon",
        choices = unique(pkmn$pokemon)
      )
    ),
    mainPanel = mainPanel(
      fluidRow(
        column(
          width = 4,
          offset = 4,
          uiOutput("imagem_pokemon")
          # imageOutput("imagem_pokemon")
        )
      )
    )
  )
)

server <- function(input, output, session) {

  output$imagem_pokemon <- renderUI({

    id <- pkmn %>%
      filter(pokemon == input$pokemon) %>%
      pull(id) %>%
      stringr::str_pad(width = 3, side = "left", pad = "0")

    url <- glue::glue(
      "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/{id}.png"
    )

    img(
      src = url,
      alt = glue::glue("Imagem do pokemon {input$pokemon}"),
      width = 300
    )

  })

  # output$imagem_pokemon <- renderImage({
  #
  #   id <- pkmn %>%
  #     filter(pokemon == input$pokemon) %>%
  #     pull(id) %>%
  #     stringr::str_pad(width = 3, side = "left", pad = "0")
  #
  #   url <- glue::glue(
  #     "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/{id}.png"
  #   )
  #
  #   arquivo <- tempfile(fileext = ".png")
  #   httr::GET(url, httr::write_disk(arquivo, overwrite = TRUE))
  #
  #   # Não funciona no Windows
  #   # download.file(url, arquivo)
  #
  #   list(
  #     src = arquivo,
  #     alt = glue::glue("Imagem do pokemon {input$pokemon}"),
  #     width = 300
  #   )
  #
  # })

}

shinyApp(ui, server)
