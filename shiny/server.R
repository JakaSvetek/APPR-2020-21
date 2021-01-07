shinyServer(function(input, output){
  
  output$graf_tekem <- renderPlot({
    print(ggplot(as.data.frame(table((podatki %>% 
                                        filter(Distance == input$dolzina, Pool == input$bazen)) %>%
                                       group_by(Meet_name)%>% 
                                       summarise(Meet_name))), 
                 aes(x=reorder(Var1, Freq), y=Freq)) + 
            geom_bar(stat = "identity", fill="steelblue") +
            coord_flip() +
            labs(x = "Ime tekme", y = "Število novih top 200 časov"))
  })
  
  output$graf_tock_plavalca <- renderPlot({
    print(ggplot(podatki %>%
                   filter(Name == input$ime) %>%
                   mutate(zaokrozeni_datumi = Swim_date - day(Swim_date) + 1) %>%
                   group_by(zaokrozeni_datumi) %>%
                   summarise(Points = max(Points)),
                 aes(x = zaokrozeni_datumi, y = Points)) +
            geom_line(size = 1, colour = "steelblue") +
            ylab("FINA točke") +
            xlab("Datum") +
            geom_point(size = 2, colour = "steelblue")
          )
  })
  
})
