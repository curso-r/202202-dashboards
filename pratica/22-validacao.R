library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)

imdb <- readr::read_rds("../dados/imdb.rds")

generos <- imdb %>%
  pull(generos) %>%
  stringr::str_split(pattern = "\\|") %>%
  unlist() %>%
  unique()

ui <- dashboardPage(
  title = "Meu dashboard",
  skin = "purple",
  dashboardHeader(
    title = "Meu dashboard"
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("mtcars", tabName = "pag1", icon = icon("car")),
      menuItem("IMDB", tabName = "pag2", icon = icon("film"))
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(
        rel = "stylesheet",
        href = "custom.css"
      )
    ),
    tabItems(
      tabItem(
        tabName = "pag1",
        h2("Conteúdo da página 1"),
        fluidRow(
          box(
            title = "Filtros",
            width = 12,
            fluidRow(
              column(
                width = 6,
                selectInput(
                  "variavel1",
                  label = "Escolha o eixo x",
                  choices = names(mtcars)
                )
              ),
              column(
                width = 6,
                selectInput(
                  "variavel2",
                  label = "Escolha o eixo y",
                  choices = names(mtcars)
                )
              )
            )
          )
        ),
        fluidRow(
          column(
            width = 12,
            plotOutput("grafico")
          )
        )
      ),
      tabItem(
        tabName = "pag2",
        h2("IMDB"),
        fluidRow(
          box(
            width = 12,
            title = "Filtros",
            fluidRow(
              column(
                width = 6,
                selectInput(
                  "genero",
                  label = "Escolha o gênero",
                  choices = generos,
                  multiple = TRUE
                )
              )
            )
          )
        ),
        fluidRow(
          valueBoxOutput("num_filmes", width = 4),
          valueBoxOutput("orcamento_medio", width = 4),
          valueBoxOutput("receita_media", width = 4)
        ),
        fluidRow(
          tabBox(
            width = 12,
            tabPanel(
              title = "Número de filmes",
              plotOutput("grafico_num_filmes")
            ),
            tabPanel(
              title = "Orçamento médio",
              plotOutput("grafico_orc_medio")
            ),
            tabPanel(
              title = "Receita média",
              plotOutput("grafico_receita_media")
            )
          )
        )
      )
    )
  )
)

server <- function(input, output, session) {

  output$grafico <- renderPlot({
    ggplot(mtcars) +
      geom_point(aes(
        x = .data[[input$variavel1]],
        y = .data[[input$variavel2]]
      ))
  })

  base_filtrada <- reactive({
    req(input$genero)
    imdb %>%
      filter(stringr::str_detect(generos, input$genero))
  })

  output$num_filmes <- renderValueBox({

    num_filmes <- base_filtrada() %>%
      nrow()

    valueBox(
      value = num_filmes,
      subtitle = "Número de filmes",
      icon = icon("film"),
      color = "orange"
    )
  })

  output$orcamento_medio <- renderValueBox({

    orc_medio <- base_filtrada() %>%
      summarise(orc_medio = mean(orcamento, na.rm = TRUE)) %>%
      pull(orc_medio) %>%
      scales::dollar(accuracy = 1)

    valueBox(
      value = orc_medio,
      subtitle = "Orçamento médio",
      icon = icon("dollar-sign"),
      color = "red"
    )
  })

  output$receita_media <- renderValueBox({

    receita_media <- base_filtrada() %>%
      summarise(receita_media = mean(receita, na.rm = TRUE)) %>%
      pull(receita_media) %>%
      scales::dollar(accuracy = 1)

    valueBox(
      value = receita_media,
      subtitle = "Receita média",
      icon = icon("dollar-sign"),
      color = "green"
    )
  })

  output$grafico_num_filmes <- renderPlot({

    validate(
      need(
        isTruthy(input$genero),
        "Selecione ao menos um gênero..."
      )
    )

    imdb %>%
      filter(stringr::str_detect(generos, input$genero)) %>%
      count(ano) %>%
      ggplot(aes(x = ano, y = n)) +
      geom_col()
  })

  output$grafico_orc_medio <- renderPlot({

    base_filtrada() %>%
      group_by(ano) %>%
      summarise(
        orc_medio = mean(orcamento, na.rm = TRUE)
      ) %>%
      ggplot(aes(x = ano, y = orc_medio)) +
      geom_col()
  })

  output$grafico_receita_media <- renderPlot({

    base_filtrada() %>%
      group_by(ano) %>%
      summarise(
        receita_media = mean(receita, na.rm = TRUE)
      ) %>%
      ggplot(aes(x = ano, y = receita_media)) +
      geom_col()
  })


}

shinyApp(ui, server)
