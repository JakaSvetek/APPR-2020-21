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
         aes(x=zaokrozeni_datumi, y=Time)) +
    geom_line() + ylab("Swim Time") + xlab("Date")
}


# Primerjava kratkih in dolgih bazenov

Graf_LCM_vs_SCM <- function(razdalja){
  ggplot() +
    geom_line(data = podatki %>% filter(Distance == razdalja, Pool == "SCM") %>%
                mutate(zaokrozeni_datumi=Swim_date-day(Swim_date)+1) %>%
                group_by(zaokrozeni_datumi) %>% summarise(Time=min(Time)),
              aes(x=zaokrozeni_datumi, y=Time), size = 1) +
    geom_line(data = podatki %>% filter(Distance == razdalja, Pool == "LCM") %>%
                mutate(zaokrozeni_datumi=Swim_date-day(Swim_date)+1) %>%
                group_by(zaokrozeni_datumi) %>% summarise(Time=min(Time)),
                aes(x=zaokrozeni_datumi, y=Time), colour = "red", size = 1) +
    labs(x = "Date",
         y = "Time[sec]")
}

# Primerjava dveh plavalcev

Primerjava_plavalcev <- function(ime1, ime2){
  plavalec1 <- podatki %>% filter(Name == ime1)
  plavalec2 <- podatki %>% filter(Name == ime2)
  plavalec1 <- plavalec1 %>% group_by(Distance, Pool) %>% summarise(Time=min(Time))
  plavalec2 <- plavalec2 %>% group_by(Distance, Pool) %>% summarise(Time=min(Time))
}
           
           

           
           
