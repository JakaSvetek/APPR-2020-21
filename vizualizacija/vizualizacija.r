# 3. faza: Vizualizacija podatkov

# Funkcija za prikaz napredka discipline

Graf_napredek <- function(razdalja, bazen){
  ggplot(podatki %>% filter(Distance == razdalja, Pool == bazen) %>%
           mutate(zaokrozeni_datumi=Swim_date-day(Swim_date)+1) %>%
           group_by(zaokrozeni_datumi) %>% summarise(Time=min(Time)),
         aes(x=zaokrozeni_datumi, y=Time)) +
    geom_line() + ylab("Swim Time") + xlab("Date")
}

# Funkcija za prikaz napredka plavalca

Graf_plavalca <- function(razdalja, bazen, ime){
  ggplot(podatki %>% filter(Distance == razdalja, Pool == bazen, Name == ime) %>%
           mutate(zaokrozeni_datumi=Swim_date-day(Swim_date)+1) %>%
           group_by(zaokrozeni_datumi) %>% summarise(Time=min(Time)),
         aes(x=zaokrozeni_datumi, y=Time), colour = "steelblue", size = 1) +
    geom_line() + ylab("Swim Time") + xlab("Date")
}


# Primerjava kratkih in dolgih bazenov

Graf_LCM_vs_SCM <- function(razdalja){
  ggplot() +
    geom_line(data = podatki %>% filter(Distance == razdalja, Pool == "SCM") %>%
                mutate(zaokrozeni_datumi=Swim_date-day(Swim_date)+1) %>%
                group_by(zaokrozeni_datumi) %>% summarise(Time=min(Time)),
              aes(x=zaokrozeni_datumi, y=Time), colour = "steelblue", size = 1) +
    geom_line(data = podatki %>% filter(Distance == razdalja, Pool == "LCM") %>%
                mutate(zaokrozeni_datumi=Swim_date-day(Swim_date)+1) %>%
                group_by(zaokrozeni_datumi) %>% summarise(Time=min(Time)),
                aes(x=zaokrozeni_datumi, y=Time), colour = "red", size = 1) +
    labs(x = "Date",
         y = "Time[sec]")
}

# Osebni rekordi plavalca

Osebni_rekordi_plavalca <- function(ime){
  vsi_casi <- podatki %>% filter(Name == ime)
  osebni_rekordi <- vsi_casi %>% group_by(Distance, Pool) %>% summarise(Time=min(Time))
  osebni_rekordi
}


# Primerjava dveh plavalcev

Primerjava_plavalcev <- function(ime1, ime2){
  plavalec1 <- podatki %>% filter(Name == ime1)
  plavalec2 <- podatki %>% filter(Name == ime2)
  plavalec1 <- plavalec1 %>% group_by(Distance, Pool) %>% summarise(Time=min(Time))
  plavalec2 <- plavalec2 %>% group_by(Distance, Pool) %>% summarise(Time=min(Time))
}
           

# Najboljse tekme (stevilo novih casov na tekmi) po disciplini

Najboljse_tekme <- function(dolzina, bazen){
  ggplot(as.data.frame(table((podatki %>% 
                                filter(Distance == dolzina, Pool == bazen)) %>%
                               group_by(Meet_name)%>% 
                               summarise(Meet_name))), 
         aes(x=reorder(Var1, Freq), y=Freq)) + 
    geom_bar(stat = "identity", fill="steelblue") +
    coord_flip() +
    geom_text(aes(label=Freq)) +
    labs(x = "Meet name", y = "Number of top 200 results")
}


# Koliko tekem je bilo kje

tekme_na_drzavo <- ggplot(as.data.frame(table(dogodki %>% 
                                                group_by(Meet_country) %>% 
                                                summarise(Meet_country))), 
                          aes(x=reorder(Var1, -Freq), y=Freq)) + 
  geom_bar(stat = "identity", fill="steelblue") +
  geom_text(aes(label=Freq)) +
  labs(x = "Country", y = "Number of competitions")


tekme_na_mesto <- ggplot(as.data.frame(table(dogodki %>% 
                                                group_by(Meet_city) %>% 
                                                summarise(Meet_city))), 
                          aes(x=reorder(Var1, Freq), y=Freq)) + 
  geom_bar(stat = "identity", fill="steelblue") +
  geom_text(aes(label=Freq)) +
  labs(x = "City", y = "Number of competitions") +
  coord_flip()



# Najboljše reprezentance

stevila_plavalcev_iz_posamicnih_drzav <- ggplot(as.data.frame(table(plavalci %>% 
                                                                      group_by(Country) %>% 
                                                                      summarise(Country))), 
                                                aes(x=reorder(Var1, Freq), y=Freq)) + 
  geom_bar(stat = "identity", fill="steelblue") +
  geom_text(aes(label=Freq)) +
  labs(x = "Country", y = "Number of top 200 swimmers") +
  coord_flip()
  
  
# stevia_rezultatov_posamicnih_drzav <- 

          
