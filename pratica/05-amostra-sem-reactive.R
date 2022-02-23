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

  output$grafico <- renderPlot({

    amostra <- sample(1:10, input$tamanho, replace = TRUE)

    # amostra %>%
    #   table() %>%
    #   barplot()

    tibble::tibble(x = amostra) %>%
      ggplot(aes(x = x)) +
      geom_bar()

  })

  output$resultado <- renderText({

    amostra <- sample(1:10, input$tamanho, replace = TRUE)

    contagem <- table(amostra)

    valor <- names(which.max(contagem))

    glue::glue("O número mais sorteado foi o {valor}")
    # paste0("O número mais sorteado foi o ", valor)

  })


}

shinyApp(ui, server)
