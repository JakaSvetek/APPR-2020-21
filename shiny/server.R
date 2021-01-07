shinyServer(function(input, output){
  output$graf_tekem <- renderPlot({
    print(ggplot(as.data.frame(table((podatki %>% 
                                        filter(Distance == input$dolzina, Pool == input$bazen)) %>%
                                       group_by(Meet_name)%>% 
                                       summarise(Meet_name))), 
                 aes(x=reorder(Var1, Freq), y=Freq)) + 
            geom_bar(stat = "identity", fill="steelblue") +
            coord_flip() +
            labs(x = "Ime tekme", y = "Število najboljših 200 časov"))
  })
})

