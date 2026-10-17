#Importar datos
library(readr)
datos1 <- read_csv("NMC-60-abridged.csv")
View(datos1)

#Filtrar los paises
library(tidyverse)
datos2 <- filter(datos1, 
                 stateabb == "USA" | stateabb == "CAN" | stateabb == "UKG" | stateabb == "FRN" | stateabb == "JPN" | 
                   stateabb == "ITA" | stateabb == "GMY" | stateabb == "BRA" | stateabb == "RUS" | stateabb == "IND" | stateabb == "CHN" | stateabb == "SAF")


#Ordenar y agrupar variables
gasto_militar <- datos2 %>%
  group_by(stateabb, year) %>%
  summarize(milex) %>%
  ungroup()

#Filtrar los valores que se encuentran comprendidos entre 1980 - 2009
gasto_militar <- filter(gasto_militar, year > 1979 & year < 2016)

#Reordenar datos
gasto_militar %>%
  pivot_wider(names_from = "year", values_from = "milex")

#Graficar
label_millions <- function(x) {
  paste0(round(x / 1e6, 1), "M")
}

library(scales)
p <- ggplot(gasto_militar, aes(x = year, y = milex, linetype = stateabb, color = stateabb, group = stateabb)) +
  geom_line()+
  scale_y_continuous(labels = label_millions)+
  labs(x = "Año", y = "Gasto Militar", color = "", linetype = "")

ggsave(filename = "GastoMilitar_paises.png", plot = p, device = "png", width = 8, height = 6)