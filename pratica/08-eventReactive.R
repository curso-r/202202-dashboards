library(shiny)

ui <- fluidPage(
  h2("Formulário"),
  textInput(
    inputId = "nome",
    label = "Digite o seu nome"
  ),
  numericInput(
    inputId = "idade",
    label = "Digite a sua idade",
    value = 30,
    min = 18,
    max = NA
  ),
  textInput(
    inputId = "estado",
    label = "Digite o seu estado"
  ),
  actionButton(inputId = "botao", label = "Enviar"),
  h2("Resposta"),
  textOutput(outputId = "frase")
)


server <- function(input, output, session) {

  texto <- eventReactive(input$botao, {
    glue::glue(
      "Olá! Eu sou {input$nome}, tenho {input$idade} e moro em/no {input$estado}."
    )
  })

  output$frase <- renderText({
    browser()
    texto()
  })

}

shinyApp(ui, server)
