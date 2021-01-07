shinyUI(
  fluidPage(
    theme = shinytheme("yeti"),
    navbarPage("NASLOV NASLOV NASLOV",
               tabPanel("Analiza tekem",
                        titlePanel(title = h2("Analiza najboljših tekme za posamične discipline")),
                        sidebarLayout(
                          sidebarPanel(
                            selectInput(
                              inputId = "dolzina",
                              label = "Dolžina",
                              choices = c("50", "100", "200")
                            ),
                            selectInput(
                              inputId = "bazen",
                              label = "Bazen",
                              choices = c("SCM", "LCM")
                            )
                          ),
                          mainPanel(
                            plotOutput(outputId = "graf_tekem")
                          )
                        )))
  )
)