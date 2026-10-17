#Importar datos
library(readr)
datos1 <- read_csv("gasto_militar_comparado.csv")
View(datos1)

#Volver numérico gastoMilitar
datos1$gastoMilitar2 <- as.numeric(datos1$gastoMilitar)

#Filtrar los paises
library(tidyverse)
datos2 <- filter(datos1, 
                 paises == "EEUU" | paises == "G7 (sin EEUU)" | paises == "BRICS")

#Ordenar y agrupar variables
gasto_militar <- datos2 %>%
  group_by(paises, year) %>%
  summarize(gastoMilitar2) %>%
  ungroup()

#Reordenar datos
gasto_militar %>%
  pivot_wider(names_from = "year", values_from = "gastoMilitar2")

#Graficar
p <- ggplot(gasto_militar, aes(x = year, y = gastoMilitar2, color = paises)) +
  geom_line() +
  labs(x = "Año", y = "% gasto militar", color = "")+
  theme(legend.position = "bottom")

#Guardar el gráfico como PNG
ggsave(filename = "gasto_militar_comparado.png", plot = p, device = "png", width = 6, height = 4)