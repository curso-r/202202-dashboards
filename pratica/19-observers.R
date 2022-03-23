library(shiny)
library(dplyr)

dados <- readr::read_rds("../dados/pkmn.rds")

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "geracao",
        label = "Selecione uma geração",
        choices = na.exclude(unique(dados$id_geracao))
      ),
      selectInput(
        "pokemon",
        label = "Selecione um pokemon",
        choices = c("Carregando..." = "")
      )
    ),
    mainPanel(
      fluidRow(
        column(
          offset = 4,
          width = 4,
          uiOutput("pkmn")
        )
      )
    )
  )
)

server <- function(input, output, session) {

  observe({
    opcoes <- dados %>%
      filter(id_geracao == input$geracao) %>%
      pull(pokemon)

    updateSelectInput(
      session,
      inputId = "pokemon",
      choices = opcoes,
      selected = opcoes[1] #já é o padrão selecionar a primeira
    )

  })

  output$pkmn <- renderUI({

    req(input$pokemon)

    id <- dados %>%
      filter(pokemon == input$pokemon) %>%
      pull(id) %>%
      stringr::str_pad(
        width = 3,
        side = "left",
        pad = "0"
      )

    url <- glue::glue(
      "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/images/{id}.png"
    )

    tags$img(
      src = url,
      width = "300px",
      alt = glue::glue("Quem é esse pokemon? É o {input$pokemon}.")
    )

  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
