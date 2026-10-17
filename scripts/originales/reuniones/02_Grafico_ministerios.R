#Gráfico de barras
library(dplyr)
library(ggplot2)
library(readxl)
library(forcats)

#Cargo la base de datos, para eso debo importar el Dataset que vaya a utilizar
datos <- read_excel("Reuniones-Completas-R.xls")

#Crear subconjuntos desde un data frame. Identifico la base y luego indico los criterios.
ministerios <- subset(datos, nivel == 2, select = c(margenOrg, area, subarea, tipo))

str(ministerios$area)

#Renombrar objetos en la variable area
ministerios$area <- fct_recode(ministerios$area, 
                               "cyt" = "sti",
                               "seguridad-defensa" = "security-defense",
                               "trabajo" = "labour",
                               "industria" = "industry",
                               "salud" = "health",
                               "cancilleres" = "foreign",
                               "ambiente" = "environment",
                               "energía" = "energy",
                               "educación" = "education",
                               "economía" = "economy",
                               "manejo de desastres" = "disaster management",
                               "cultura" = "culture",
                               "comunicación" = "communication",
                               "agricultura" = "agriculture"
                               )


#Contar
conteos <- ministerios %>%
  group_by(area) %>%
  summarise(conteo = n())

#Graficar barras

reuniones_ministeriales <- ggplot(conteos) +
  geom_col(aes(x = area, y = conteo))+
  coord_flip()+
  labs(x = "Áreas", y = "Cantidad de Reuniones")+
  theme(legend.position = "none")
ggsave("reuniones_ministeriales.png", reuniones_ministeriales, width = 15, height = 10)

#Crear subconjuntos desde un data frame. Identifico la base y luego indico los criterios.
economia <- subset(datos, area == "economy", select = c(margenOrg, subarea, subarea_economica, tipo, nivel, year, formato, presidencia))

#Contar
conteos_subeconomia <- economia %>%
  group_by(subarea_economica) %>%
  summarise(conteo_2 = n())

ggplot(conteos_subeconomia) +
  geom_col(aes(x = subarea_economica, y = conteo_2))+
  facet_wrap(~subarea, nrow = 1)+
  coord_flip()+
  labs(x = "Áreas", y = "Cantidad de Reuniones")+
  theme(legend.position = "none")

ggplot(economia, aes(x=tipo))+geom_bar()+facet_wrap(~area, nrow = 1)