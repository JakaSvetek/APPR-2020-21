shinyUI(
  fluidPage(
    theme = shinytheme("yeti"),
    navbarPage("Tekme in plavalci",
               
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
                            plotOutput(outputId = "graf_tekem",
                                       height = 800)
                          )
                        )),

               tabPanel("Napredek plavalca",
                        titlePanel(title = h2("Število točk plavalca skozi čas")),
                        sidebarLayout(
                          sidebarPanel(
                            selectInput(
                              inputId = "ime",
                              label = "Ime",
                              choices = (as.data.frame(table(podatki$Name)) %>% filter(Freq > 2))$Var1
                            )
                          ),
                          mainPanel(
                            plotOutput(outputId = "graf_tock_plavalca")
                          )
                        ))
               )
  )
)