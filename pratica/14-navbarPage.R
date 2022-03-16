library(shiny)
library(ggplot2)

ui <- navbarPage(
  title = "Shiny com navbarPage",
  tabPanel(
    title = "Tela 1",
    fluidRow(
      column(
        width = 4,
        selectInput(
          "opcoes",
          label = "Escolha uma opção",
          choices = names(mtcars)
        )
      ),
      column(
        width = 8,
        plotOutput("grafico")
      )
    )
  ),
  tabPanel(
    title = "Tela 2",
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "opcoes_tela2",
          label = "Escolha uma opção",
          choices = names(mtcars)
        )
      ),
      mainPanel(
        plotOutput("grafico_tela2")
      )
    )
  ),
  navbarMenu(
    title = "Mais opções",
    tabPanel(
      title = "Tela 3",
      h2("Tela 3")
    ),
    tabPanel(
      title = "Tela 4",
      h2("Tela 4")
    ),
    tabPanel(
      title = "Tela 5",
      h2("Tela 5")
    )
  )
)

server <- function(input, output, session) {

  output$grafico <- renderPlot({
    hist(mtcars[[input$opcoes]])
  })

  output$grafico_tela2 <- renderPlot({
    ggplot(mtcars) +
      geom_point(aes(x = .data[[input$opcoes_tela2]], y = mpg))
  })

}

shinyApp(ui, server)
