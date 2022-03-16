library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  title = "Meu dashboard",
  dashboardHeader(
    title = "Meu dashboard"
  ),
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
