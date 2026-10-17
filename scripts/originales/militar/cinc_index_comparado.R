#Importar datos
library(readr)
datos1 <- read_csv("cinc_index_comparado.csv")
View(datos1)

#Volver numérico gastoMilitar
datos1$cinc2 <- as.numeric(datos1$cinc)

#Filtrar los paises
library(tidyverse)
datos2 <- filter(datos1, 
                 paises == "EEUU" | paises == "G7 (sin EEUU)" | paises == "BRICS")

#Ordenar y agrupar variables
cinc_comparado <- datos2 %>%
  group_by(paises, year) %>%
  summarize(cinc2) %>%
  ungroup()

#Reordenar datos
cinc_comparado %>%
  pivot_wider(names_from = "year", values_from = "cinc2")

#Graficar
p <- ggplot(cinc_comparado, aes(x = year, y = cinc2, color = paises)) +
  geom_line() +
  labs(x = "Año", y = "% CINC index", color = "")+
  theme(legend.position = "bottom")

#Guardar el gráfico como PNG
ggsave(filename = "cinc_comparado.png", plot = p, device = "png", width = 6, height = 4)