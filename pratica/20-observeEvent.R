library(shiny)

ui <- fluidPage(
  textInput(
    "email",
    label = "Digite o seu e-mail",
    value = ""
  ),
  actionButton(
    "enviar",
    label = "Enviar e-mail",
    icon = icon("envelope")
  )
)

server <- function(input, output, session) {

  observeEvent(input$enviar, {

    if (isTruthy(input$email)) {

      write(input$email, file = "emails.txt", append = TRUE)

      showModal(
        modalDialog(
          "Seu e-mail foi enviado com sucesso!",
          title = "Sucesso!",
          footer = modalButton("Fechar"),
          easyClose = TRUE
        )
      )

    } else {
      showModal(
        modalDialog(
          "Insira um e-mail válido",
          title = "Erro...",
          footer = modalButton("Fechar"),
          easyClose = TRUE
        )
      )
    }



  })

}

shinyApp(ui, server)
