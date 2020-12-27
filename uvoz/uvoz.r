# UVOZ PODATKOV

library(dplyr)
library(tidyr)
library(readr)


razdalje <- c("50"="%OS", "100"="%OS", "200"="%M:%OS") # oblike časov pri posameznih razdaljah
bazeni <- c("SCM", "LCM")


podatki <- lapply(names(razdalje), function(razdalja)
  lapply(bazeni, function(bazen)
    sprintf("podatki/%sm_%s.csv", razdalja, bazen) %>%
      read_csv(na="-", locale=locale(encoding="UTF-8", date_format="%d/%m/%Y"),
               col_types=cols(swim_time=col_time(format=razdalje[razdalja]))) %>%
      mutate(Distance=parse_factor(razdalja, levels=names(razdalje), ordered=TRUE), # razdalja bo urejen faktor
             Pool=parse_factor(bazen, levels=bazeni))) %>%
    bind_rows()) %>% bind_rows() %>%
  transmute(Name=full_name_computed, Country=team_short_name, Birth_date=birth_date,
            Distance, Pool, Time=swim_time, Points=fina_points, Swim_date=swim_date,
            Meet_name=meet_name, Meet_city=meet_city, Meet_country=country_code)

plavalci <- podatki %>% select(Name, Country, Birth_date) %>% unique()

dogodki <- podatki %>% drop_na(Meet_name) %>%
  select(Meet_name, Meet_city, Meet_country) %>% unique()

podatki <- podatki %>% select(-Country, -Birth_date, -Meet_city, -Meet_country)