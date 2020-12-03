# UVOZ PODATKOV

library(dplyr)
library(tidyr)
library(readr)

stolpci <- c("Name", "Country", "Birth_date", "Time", "Points", "Swim_date", "Meet_name", "Meet_city", "Meet_country")



SCM50 <- read.csv("podatki/50m_SCM.csv", encoding = "UTF-8") %>%
  select(1, 2, 3, 6, 7, 9, 14, 15, 16) %>%
  .[c(5, 4, 6, 2, 7, 3, 1, 8, 9)]
colnames(SCM50) <- stolpci


SCM100 <- read.csv("podatki/100m_SCM.csv", encoding = "UTF-8") %>%
  select(1, 2, 3, 6, 7, 9, 14, 15, 16) %>%
  .[c(5, 4, 6, 2, 7, 3, 1, 8, 9)]
colnames(SCM100) <- stolpci


SCM200 <- read.csv("podatki/200m_SCM.csv", encoding = "UTF-8") %>%
  select(1, 2, 3, 6, 7, 9, 14, 15, 16) %>%
  .[c(5, 4, 6, 2, 7, 3, 1, 8, 9)]
colnames(SCM200) <- stolpci


LCM50 <- read.csv("podatki/50m_LCM.csv", encoding = "UTF-8") %>%
  select(1, 2, 3, 6, 7, 9, 14, 15, 16) %>%
  .[c(5, 4, 6, 2, 7, 3, 1, 8, 9)]
colnames(LCM50) <- stolpci


LCM100 <- read.csv("podatki/100m_LCM.csv", encoding = "UTF-8") %>%
  select(1, 2, 3, 6, 7, 9, 14, 15, 16) %>%
  .[c(5, 4, 6, 2, 7, 3, 1, 8, 9)]
colnames(LCM100) <- stolpci


LCM200 <- read.csv("podatki/200m_LCM.csv", encoding = "UTF-8") %>%
  select(1, 2, 3, 6, 7, 9, 14, 15, 16) %>%
  .[c(5, 4, 6, 2, 7, 3, 1, 8, 9)]
colnames(LCM200) <- stolpci


