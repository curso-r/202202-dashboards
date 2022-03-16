library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  title = "Meu dashboard",
  dashboardHeader(
    title = "Meu dashboard"
  ),
  dashboardSidebar(
    textInput(
      "texto",
      label = "Seu nome",
      value = ""
    ),
    sidebarMenu(
      menuItem("Página 1", tabName = "pag1"),
      menuItem("Página 2", tabName = "pag2"),
      menuItem("Página 3", tabName = "pag3"),
      menuItem(
        "Outras páginas",
        menuSubItem(
          "Página 4",
          tabName = "pag4"
        ),
        menuSubItem(
          "Página 5",
          tabName = "pag5"
        ),
        menuSubItem(
          "Página 6",
          tabName = "pag6"
        )
      )
    )
  ),
  dashboardBody(
    textOutput("nome"),
    tabItems(
      tabItem(
        tabName = "pag1",
        h2("Conteúdo da página 1"),
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
      tabItem(
        tabName = "pag2",
        h2("Conteúdo da página 2"),
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
      tabItem(
        tabName = "pag3",
        h2("Conteúdo da página 3")
      ),
      tabItem(
        tabName = "pag4",
        h2("Conteúdo da página 4")
      ),
      tabItem(
        tabName = "pag5",
        h2("Conteúdo da página 5")
      ),
      tabItem(
        tabName = "pag6",
        h2("Conteúdo da página 6")
      )
    )
  )
)

server <- function(input, output, session) {

  output$nome <- renderText({
    glue::glue("Olá, {input$texto}!")
  })

  output$grafico <- renderPlot({
    hist(mtcars[[input$opcoes]])
  })

  output$grafico_tela2 <- renderPlot({
    ggplot(mtcars) +
      geom_point(aes(x = .data[[input$opcoes_tela2]], y = mpg))
  })

}

shinyApp(ui, server)
