# 3. faza: Vizualizacija podatkov

require(ggplot2)
require(data.table)

# Funkcija, ki za vsak datum vrne najboljši rezultat

Graf_napredek <- function(razdalja, bazen){
  podatki <- podatki %>% mutate(zaokrozeni_datumi = format(as.Date(Swim_date), "%Y/%m"))
  disciplina <- filter(podatki, Distance == razdalja, Pool == bazen)
  disciplina <- disciplina %>% group_by(zaokrozeni_datumi) %>% summarise(Time = min(Time))
  ggplot(disciplina, aes(x=zaokrozeni_datumi, y=Time)) +
  geom_point() +
  ylab("Swim Time") + 
  xlab("Date")
  }

# Funkcija za napredek plavalca

Napredek_plvalca <- function(razdalja, bazen, ime){
  podatki <- podatki %>% mutate(zaokrozeni_datumi = format(as.Date(Swim_date), "%Y/%m"))
  disciplina <- filter(podatki, Distance == razdalja, Pool == bazen, Name == ime)
  disciplina <- disciplina %>% group_by(zaokrozeni_datumi) %>% summarise(Time = min(Time))
  ggplot(disciplina, aes(x=zaokrozeni_datumi, y=Time)) +
  geom_point() +
  ylab("Swim Time") + 
  xlab("Date")
}