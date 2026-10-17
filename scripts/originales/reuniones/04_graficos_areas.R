#Cargar la base de datos
library(readxl)
data1 <- read_excel("Reuniones-Completas-R.xls")

#Conociendo la base
#table(data1$sector)

#Libreria para recodificar
library(tidyverse)
library(plyr)
library(forcats)
library(car)

#Renombrar objetos en la variable area
data1$area <- fct_recode(data1$area, 
                         "cyt" = "sti",
                         "seguridad-defensa" = "security-defense",
                         "trabajo" = "labour",
                         "industria" = "industry",
                         "salud" = "health",
                         "gobierno" = "government",
                         "cancilleres" = "foreign",
                         "ambiente" = "environment",
                         "energía" = "energy",
                         "educación" = "education",
                         "economía" = "economy",
                         "manejo de desastres" = "disaster management",
                         "cultura" = "culture",
                         "comunicación" = "communication",
                         "agricultura" = "agriculture",
                         "infraestructura" = "infrastructure",
                         "organización" = "organizational")

#Recodificado con library(plyr)
data1$formalidad <- revalue(data1$tipo,c("formal"="1","informal"="0"))

table(data1$formalidad)

#Gráfico de barras
library(ggplot2)

#Mismo gráfico anterior pero segmentado por region del país
area_presidencias <- ggplot(data1, aes(x = area, fill = tipo)) + 
  geom_bar()+
  coord_flip()+
  facet_wrap(~presidencia, nrow = 3)+
  scale_fill_manual(
    values = c("#736767", "#B2A3A3")) +
  labs(fill = "Tipo", y = "Áreas temáticas", x = "Cantidad de reuniones")
ggsave("area_presidencias.png", area_presidencias, width = 15, height = 10)

#############################################################################################

#Subgrupo economico
area_economica <- subset(data1, area == "economy")

#Mismo gráfico anterior pero segmentado por region del país
areas_economicas <- ggplot(area_economica, aes(x = subarea_economica, fill = tipo)) + 
  geom_bar()+
  coord_flip()+
  facet_wrap(~subarea, nrow = 1)

ggsave("areas_economicas.png", areas_economicas, width = 15, height = 10)