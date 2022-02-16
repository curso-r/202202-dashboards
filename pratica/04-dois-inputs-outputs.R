library(shiny)
library(dplyr)

ui <- fluidPage(
  selectInput(
    inputId = "variavel_A",
    label = "Variável A",
    choices = names(mtcars)
  ),
  plotOutput(outputId = "histograma_A"),
  selectInput(
    inputId = "variavel_B",
    label = "Variável B",
    choices = names(mtcars)
  ),
  plotOutput(outputId = "histograma_B")
)

server <- function(input, output, session) {

  output$histograma_A <- renderPlot({
    print("Gerando histograma A...")
    vetor <- mtcars[[input$variavel_A]]
    hist(vetor)
  })

  output$histograma_B <- renderPlot({
    print("Gerando histograma B...")
    vetor <- mtcars[[input$variavel_B]]
    hist(vetor)
  })

}

shinyApp(ui, server)
