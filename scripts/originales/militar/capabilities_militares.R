#Importar datos

library(readr)
datos1 <- read_csv("NMC-60-abridged.csv")
View(datos1)

#Seleccionar la variable CINC index
library(tidyverse)
capability_index <- select(datos1, cinc, year, milex, stateabb)

#Filtrar los paises
datos2 <- filter(datos1, 
                 stateabb == "USA" | stateabb == "CAN" | stateabb == "UKG" | stateabb == "FRN" | stateabb == "JPN" | 
                   stateabb == "ITA" | stateabb == "GMY" | stateabb == "BRA" | stateabb == "RUS" | stateabb == "IND" | stateabb == "CHN" | stateabb == "SAF")


#Ordenar y agrupar variables
datos_capability <- datos2 %>%
  group_by(stateabb, year) %>%
  summarize(cinc) %>%
  ungroup()

#Filtrar los valores que se encuentran comprendidos entre 1980 - 2009
datos_capability <- filter(datos_capability, year > 1979 & year < 2016)

#Reordenar datos
datos_capability %>%
  pivot_wider(names_from = "year", values_from = "cinc")

#Graficar
p <- ggplot(datos_capability, aes(x = year, y = cinc, linetype = stateabb, color = stateabb, group = stateabb)) +
  geom_line()+
  labs(x = "Año", y = "CINC index", color = "", linetype = "")

ggsave(filename = "CINCIndex_paises.png", plot = p, device = "png", width = 8, height = 6)



