library(shiny)
library(dplyr)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h3("Remover uma linha"),
      numericInput(
        "linha",
        label = "Escolha uma linha para remover",
        value = 1,
        min = 1
      ),
      actionButton("remover", label = "Clique para remover"),
      h3("Adicionar uma linha aleatória"),
      # numericInput(
      #   "mpg",
      #   label = "Escolha o valor de MPG",
      #   value = 30
      # ),
      actionButton("adicionar", label = "Clique para adicionar")
    ),
    mainPanel(
      reactable::reactableOutput("tabela")
    )
  )
)

server <- function(input, output, session) {

  mtcars_reativa <- reactiveVal(value = mtcars)

  observeEvent(input$remover, {
    nova_mtcars <- mtcars_reativa() %>%
      slice(-input$linha)
    mtcars_reativa(nova_mtcars)
  })

  # observeEvent(input$adicionar, {
  #   nova_mtcars <- mtcars_reativa() %>%
  #     tibble::add_row(mpg = input$mpg, .before = 1)
  #   mtcars_reativa(nova_mtcars)
  # })

  observeEvent(input$adicionar, {
    nova_linha <- slice_sample(mtcars, n = 1)
    nova_mtcars <- bind_rows(nova_linha, mtcars_reativa())
    mtcars_reativa(nova_mtcars)
  })

  output$tabela <- reactable::renderReactable({
    mtcars_reativa() %>%
      reactable::reactable(width = 600)
  })

}

shinyApp(ui, server)
