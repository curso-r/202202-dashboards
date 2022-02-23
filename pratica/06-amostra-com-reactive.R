library(shiny)
library(ggplot2)
library(magrittr)

ui <- fluidPage(
  h1("Resultado do sorteio"),
  numericInput(
    inputId = "tamanho",
    label = "Selecione o tamanho da amostra",
    value = 100,
    min = 10,
    max = 100000,
    step = 10
  ),
  plotOutput(outputId = "grafico"),
  textOutput(outputId = "resultado")
)

server <- function(input, output, session) {

  amostra <- reactive({
    sample(1:10, input$tamanho, replace = TRUE)
  })

  output$grafico <- renderPlot({

    tibble::tibble(x = amostra()) %>%
      ggplot(aes(x = x)) +
      geom_bar()

  })

  output$resultado <- renderText({

    contagem <- table(amostra())

    valor <- names(which.max(contagem))

    glue::glue("O número mais sorteado foi o {valor}")

  })

}

shinyApp(ui, server)
