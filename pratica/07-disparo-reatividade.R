library(shiny)

ui <- fluidPage(
  textInput(
    inputId = "entrada",
    label = "Escreva um texto"
  ),
  textOutput(outputId = "saida")
)

server <- function(input, output, session) {

  texto <- reactive({
    print("RODEI A EXP REATIVA")
    input$entrada
  })

  output$saida <- renderText({
    print("RODEI O OBSERVER")
    input$entrada
  })

}

shinyApp(ui, server)
