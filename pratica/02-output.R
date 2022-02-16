library(shiny)

ui <- fluidPage(
  "Um histograma",
  plotOutput(outputId = "hist", height = "500px"),
  "Esse é o nosso app!"
)

server <- function(input, output, session) {

  output$hist <- renderPlot({
    hist(mtcars$mpg)
  })

}

shinyApp(ui, server)
