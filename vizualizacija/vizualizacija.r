# 3. faza: Vizualizacija podatkov

# Funkcija za prikaz napredka discipline

Graf_napredka <- function(razdalja, bazen){
  ggplot(podatki %>% filter(Distance == razdalja, Pool == bazen) %>%
           mutate(zaokrozeni_datumi=Swim_date-day(Swim_date)+1) %>%
           group_by(zaokrozeni_datumi) %>% summarise(Time=min(Time)),
         aes(x=zaokrozeni_datumi, y=Time)) +
    geom_line() + ylab("Čas plavanja") + xlab("Datum")
}


# Funkcija za prikaz napredka plavalca pri neki disciplini

Graf_plavalca <- function(razdalja, bazen, ime){
  ggplot(podatki %>% filter(Distance == razdalja, Pool == bazen, Name == ime) %>%
           mutate(zaokrozeni_datumi=Swim_date-day(Swim_date)+1) %>%
           group_by(zaokrozeni_datumi) %>% summarise(Time=min(Time)),
         aes(x=zaokrozeni_datumi, y=Time), colour = "steelblue", size = 1) +
    geom_line() + ylab("Swim Time") + xlab("Date")
}


# Primerjava kratkih in dolgih bazenov

Graf_LCM_vs_SCM <- function(razdalja){
  SCM_podatki <- podatki %>% filter(Distance == razdalja, Pool == "SCM") %>%
    mutate(zaokrozeni_datumi=Swim_date-day(Swim_date)+1) %>%
    group_by(zaokrozeni_datumi) %>% summarise(Time=min(Time)) %>%
    mutate(Pool="SCM")
  
  LCM_podatki <- podatki %>% filter(Distance == razdalja, Pool == "LCM") %>%
    mutate(zaokrozeni_datumi=Swim_date-day(Swim_date)+1) %>%
    group_by(zaokrozeni_datumi) %>% summarise(Time=min(Time)) %>%
    mutate(Pool="LCM")
  
  ime_grafa <- paste("Primerjava dolgih in kratkih bazenov pri", as.character(razdalja), "metrov delfin")
  
  LCM_vs_SCM <- rbind(SCM_podatki, LCM_podatki)
  
  ggplot(LCM_vs_SCM) +
    geom_line() +
    aes(x = zaokrozeni_datumi, y = Time, col = Pool) +
    ylab("Čas plavanja [sekunde]") + xlab("Datum") + labs(title = ime_grafa)
} 


# Osebni rekordi plavalca

Osebni_rekordi_plavalca <- function(ime){
  vsi_casi <- podatki %>% filter(Name == ime)
  osebni_rekordi <- vsi_casi %>% group_by(Distance, Pool) %>% summarise(Time=min(Time))
  osebni_rekordi
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
    labs(x = "Meet name", y = "Number of top 200 results")
}


# Koliko tekem je bilo kje

tekme_na_drzavo <- as.data.frame(table(dogodki %>% group_by(Meet_country) %>% summarise(Meet_country)))

graf_tekme_na_drzavo <- ggplot(tekme_na_drzavo, 
                          aes(x=reorder(Var1, -Freq), y=Freq)) + 
  geom_bar(stat = "identity", fill="steelblue") +
  labs(x = "Country", y = "Number of competitions")
  
# Uvozim zemljevid za število tekem

zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/110m_cultural.zip",
                             "ne_110m_admin_0_countries", encoding="UTF-8") %>%
  fortify()

colnames(zemljevid)[12] <- "Var1"

zemljevid$Var1 <- gsub("US1", "USA", zemljevid$Var1)
zemljevid$Var1 <- gsub("AU1", "AUS", zemljevid$Var1)
zemljevid$Var1 <- gsub("COG", "CGO", zemljevid$Var1)
zemljevid$Var1 <- gsub("CH1", "CHN", zemljevid$Var1)
zemljevid$Var1 <- gsub("HRV", "CRO", zemljevid$Var1)
zemljevid$Var1 <- gsub("DN1", "DEN", zemljevid$Var1)
zemljevid$Var1 <- gsub("FI1", "FIN", zemljevid$Var1)
zemljevid$Var1 <- gsub("FR1", "FRA", zemljevid$Var1)
zemljevid$Var1 <- gsub("GB1", "GBR", zemljevid$Var1)
zemljevid$Var1 <- gsub("DEU", "GER", zemljevid$Var1)
zemljevid$Var1 <- gsub("GRC", "GRE", zemljevid$Var1)
zemljevid$Var1 <- gsub("IDN", "INA", zemljevid$Var1)
zemljevid$Var1 <- gsub("IS1", "ISN", zemljevid$Var1)
zemljevid$Var1 <- gsub("MYS", "MAS", zemljevid$Var1)
zemljevid$Var1 <- gsub("NL1", "NED", zemljevid$Var1)
zemljevid$Var1 <- gsub("NZ1", "NZL", zemljevid$Var1)
zemljevid$Var1 <- gsub("ZAF", "RSA", zemljevid$Var1)
zemljevid$Var1 <- gsub("CHE", "SUI", zemljevid$Var1)
zemljevid$Var1 <- gsub("ARE", "UAE", zemljevid$Var1)

zemljevid_tekem <- ggplot() +
  geom_polygon(data=right_join(tekme_na_drzavo, zemljevid, by="Var1"), 
               aes(x=long, y=lat, group=group, fill=Freq)) +
  xlab("") +
  ylab("") + 
  ggtitle("Zemljevid tekem po državah") + 
  theme(axis.title=element_blank(), axis.text=element_blank(), 
        axis.ticks=element_blank(), panel.background = element_blank()) + 
  scale_fill_gradient(low = '#FCDADA', high='#970303', limits=c(1,35)) +
  labs(fill="Število tekem")

# plot(zemljevid_tekem)


# Najštevilčnejše reprezentance delfinistov

stevilo_plavalcev_iz_posamicnih_drzav <- as.data.frame(table(plavalci %>% group_by(Country) %>% summarise(Country)))

graf_stevila_plavalcev_iz_posamicnih_drzav <- ggplot(stevilo_plavalcev_iz_posamicnih_drzav, 
                                                     aes(x=reorder(Var1, Freq), y=Freq)) + 
  geom_bar(stat = "identity", fill="steelblue") +
  geom_text(aes(label=Freq)) +
  labs(x = "Country", y = "Number of top 200 swimmers") +
  coord_flip()

# Uvozim zemljevid za število najboljših delfinistov

zemljevid2 <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/110m_cultural.zip",
                             "ne_110m_admin_0_countries", encoding="UTF-8") %>%
  fortify()

colnames(zemljevid2)[11] <- "Var1"

zemljevid2$Var1 <- gsub("United Kingdom", "Great Britain", zemljevid2$Var1)
zemljevid2$Var1 <- gsub("Russia", "Russian Federation", zemljevid2$Var1)
zemljevid2$Var1 <- gsub("Republic of Serbia", "Serbia", zemljevid2$Var1)

zemljevid_stevilo_delfinistov <- ggplot() +
  geom_polygon(data=right_join(stevilo_plavalcev_iz_posamicnih_drzav, zemljevid2, by="Var1"), 
               aes(x=long, y=lat, group=group, fill=Freq)) +
  xlab("") +
  ylab("") + 
  ggtitle("Zemljevid števila delfinistov iz držav") + 
  theme(axis.title=element_blank(), axis.text=element_blank(), 
        axis.ticks=element_blank(), panel.background = element_blank()) + 
  scale_fill_gradient(low = '#FCDADA', high='#970303', limits=c(1,20)) +
  labs(fill="Število delfinistov")

# Starost rekorderjev

t <- ((right_join(podatki, plavalci, by="Name")) %>% 
        filter(Points>=1000)) %>% 
  select(Name, Swim_date, Birth_date)

graf_starosti_rekorderjev <- ggplot(as.data.frame(table(floor((t$Swim_date - t$Birth_date)/365.25))),
                                    aes(x=Var1, y=Freq)) +
  geom_bar(stat = "identity", fill = "steelblue")


