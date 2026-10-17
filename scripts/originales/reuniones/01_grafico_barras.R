# Cargar librerias
library(tidyverse)
library(ggplot2)
library(readxl)

# Importar base
datos <- read_excel("Reuniones-Completas-R.xls")

#Renombrar objetos en la variable area
datos$area <- fct_recode(datos$area, 
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

###############################################################################################################

# Manipulacion de datos
conteos <- datos %>%
  group_by(year, nivel) %>%
  summarize(conteo = n())

# Me quedo con los casos completos (sin NA)
conteos <- conteos[complete.cases(conteos), ]

# Crear grafico
# Convertir 'nivel' a caracter para que no use gradiente en el fill.
conteos$nivel <- as.character(conteos$nivel)

#Reuniones totales, rellenado según el nivel
reuniones_totales <- ggplot(conteos) +
  geom_col(aes(x = year, y = conteo, fill = nivel)) + 
  scale_fill_manual(
    values = c("#251F1F", "#A49696", "#736767", "#B2A3A3"),
    name = "Nivel reuniones"
  ) + 
  labs(
    x = "Año",
    y = "Cantidad de reuniones",
    caption = "",
    title = "",
    subtitle = ""
  ) + 
  theme(
    legend.position = "bottom"
  )
ggsave("reuniones_totales_niveles.png", reuniones_totales, width = 15, height = 10)

###############################################################################################################

# Manipulacion de datos
conteos <- datos %>%
  group_by(year, tipo) %>%
  summarize(conteo = n())

# Me quedo con los casos completos (sin NA)
conteos <- conteos[complete.cases(conteos), ]

# Crear grafico
# Convertir 'nivel' a caracter para que no use gradiente en el fill.
conteos$tipo <- as.character(conteos$tipo)

#Reuniones totales, rellenado según el tipo
reuniones_totales <- ggplot(conteos) +
  geom_col(aes(x = year, y = conteo, fill = tipo)) + 
  scale_fill_manual(
    values = c("#736767", "#B2A3A3"),
    name = "Tipo"
  ) + 
  labs(
    x = "Año",
    y = "Cantidad de reuniones",
    caption = "",
    title = "",
    subtitle = ""
  ) + 
  theme(
    legend.position = "bottom"
  )
ggsave("reuniones_totales_tipo.png", reuniones_totales, width = 15, height = 10)

###############################################################################################################

#Subset reuniones en los cuatro niveles
datos_reuniones <- subset(datos, nivel > 1, select = c(margenOrg, area, subarea, tipo, nivel, year))

#Gráfico reuniones a lo largo del período 2006 - 2022, según si fueron formales o informales
reuniones_niveles <- ggplot(datos_reuniones, aes(x = year, fill = tipo))+ 
  geom_bar()+
  facet_wrap(~nivel, nrow = 4)+
  scale_fill_manual(
    values = c("#736767", "#B2A3A3"),
    name = "Tipo") +
  theme(
    legend.position = "bottom"
  )+
  labs(
    fill = "Tipo",
    x = "Año",
    y = "Cantidad de Reuniones",
    caption = "",
    title = "",
    subtitle = "")
ggsave("reuniones_niveles.png", reuniones_niveles, width = 15, height = 10)


#Reuniones clasificadas según el área temática, y rellenado por el tipo
reuniones_areas <- ggplot(datos, aes(x = area, fill = tipo))+ 
  geom_bar()+
  coord_flip()+
  scale_fill_manual(
    values = c("#736767", "#B2A3A3"),
    name = "Tipo") +
  theme(
    legend.position = "bottom"
  )+
  labs(
    fill = "Tipo",
    x = "Cantidad de Reuniones",
    y = "Áreas temáticas",
    caption = "",
    title = "",
    subtitle = "")
ggsave("reuniones_areas.png", reuniones_areas, width = 15, height = 10)

#Reuniones clasificadas según el área temática, segmentadas por nivel y rellenado por el tipo
reuniones_tematicas_nivel <- ggplot(datos_reuniones, aes(x = area, fill = tipo))+ 
  geom_bar()+
  coord_flip()+
  facet_wrap(~nivel, nrow = 4)+
  scale_fill_manual(
    values = c("#736767", "#B2A3A3"),
    name = "Tipo") +
  theme(
    legend.position = "bottom"
  )+
  labs(
    fill = "Tipo",
    x = "Cantidad de Reuniones",
    y = "Áreas temáticas",
    caption = "",
    title = "",
    subtitle = "")
ggsave("reuniones_tematicas_nivel.png", reuniones_tematicas_nivel, width = 15, height = 10)


###############################################################################################################
#Renombrar objetos en la variable area
datos$formato <- fct_recode(datos$formato, 
                         "híbrido" = "hybrid")

# Manipulacion de datos
conteos <- datos %>%
  group_by(year, formato) %>%
  summarize(conteo = n())

# Me quedo con los casos completos (sin NA)
conteos <- conteos[complete.cases(conteos), ]

# Crear grafico
# Convertir 'nivel' a caracter para que no use gradiente en el fill.
conteos$formato <- as.character(conteos$formato)

#Reuniones totales, rellenado según el formato
reuniones_totales_formato <- ggplot(conteos) +
  geom_col(aes(x = year, y = conteo, fill = formato)) + 
  scale_fill_manual(
    values = c("#B2A3A3", "#251F1F", "#736767", "#A49696"),
    name = "Nivel reuniones"
  ) + 
  labs(
    x = "Año",
    y = "Cantidad de reuniones",
    caption = "",
    title = "",
    subtitle = ""
  ) + 
  theme(
    legend.position = "bottom"
  )
ggsave("reuniones_totales_formato.png", reuniones_totales_formato, width = 15, height = 10)
