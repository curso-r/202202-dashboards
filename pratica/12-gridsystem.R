quadrado <- function(text = "") {
  div(
    style = "background: purple; height: 100px; text-align: center; color: white; font-size: 24px;",
    text
  )
}

library(shiny)

ui <- fluidPage(
  fluidRow(
    column(
      width = 2,
      quadrado(1)
    ),
    column(
      width = 2,
      quadrado(2)
    ),
    column(
      width = 2,
      quadrado(3)
    ),
    column(
      width = 2,
      quadrado(4)
    ),
    column(
      width = 2,
      quadrado(5)
    ),
    column(
      width = 2,
      selectInput("teste", "teste", c(1, 2, 3))
    )
  ),
  fluidRow(
    column(
      offset = 10,
      width = 2,
      selectInput("teste2", "teste", c(1, 2, 3))
    )
  ),
  fluidRow(
    column(
      width = 2,
      selectInput("teste3", "teste", c(1, 2, 3))
    ),
    column(
      width = 2,
      selectInput("teste4", "teste", c(1, 2, 3))
    )
  ),
  fluidRow(
    column(
      width = 6,
      quadrado("tam = 6")
    ),
    column(
      width = 7,
      quadrado("tam = 7")
    )
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
