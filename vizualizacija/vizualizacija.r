# 3. faza: Vizualizacija podatkov

require(ggplot2)

# Uvozim podatke

Graf_napredek <- function(Razdalja, Bazen)
  ggplot(filter(podatki, Distance == Razdalja, Pool == Bazen), aes(x=Swim_date, y=Time)) +
  geom_line() + 
  ylab("Swim Time") + 
  xlab("Date")