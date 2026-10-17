# =============================================================================
# Conjunto 1 · Reuniones del BRICS (2006-2022)
# 02_figuras.R
#
# Adaptación de tres scripts originales (ver scripts/originales/reuniones/):
#   01_grafico_barras.R     -> Figs. 5.2b, 5.5a, 5.5b, 7.1 y complementaria de formato
#   02_Grafico_ministerios.R -> Fig. 5.4
#   04_graficos_areas.R      -> Fig. 5.3 y complementaria de subáreas económicas
#
# El código de cada gráfico se conserva tal como estaba: datos, variables,
# colores, etiquetas y tamaños. Los cambios son sólo técnicos y están
# documentados en docs/cambios_tecnicos.md (marcados abajo con [CAMBIO]).
#
# Entrada : data/processed/reuniones/reuniones_brics_2006_2022.csv
# Salidas : outputs/figuras/regeneradas/*.png
# =============================================================================

# [CAMBIO] Se cargan sólo los paquetes usados en lugar de library(tidyverse) (D19).
library(ggplot2)
library(dplyr)
library(forcats)
library(readr)

stopifnot("Ejecutar desde la raíz del repositorio" = file.exists("brics-tesis-datos.Rproj"))

salida <- "outputs/figuras/regeneradas"
dir.create(salida, recursive = TRUE, showWarnings = FALSE)

# [CAMBIO] Los originales leían el .xls con read_excel(); aquí se lee la base
# procesada por 01_preparar_base.R (mismas filas y variables usadas en los gráficos).
leer_base <- function() {
  read_csv("data/processed/reuniones/reuniones_brics_2006_2022.csv", show_col_types = FALSE, guess_max = Inf)
}

# Recodificación de 'area' al español, idéntica a la de los scripts originales
recodificar_area <- function(x) {
  fct_recode(x,
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
}

# =============================================================================
# A) Origen: 01_grafico_barras.R
# =============================================================================
datos <- leer_base()
datos$area <- recodificar_area(datos$area)

# [CAMBIO] Se omite el gráfico 'reuniones_totales_niveles.png' (decisión D17 del autor:
# imagen repetida, no utilizada en la tesis). Su código sigue en el script original.

# --- Fig. 5.2b · Reuniones totales por año según tipo (formal / informal) ------
conteos <- datos %>%
  group_by(year, tipo) %>%
  summarize(conteo = n())

conteos <- conteos[complete.cases(conteos), ]
conteos$tipo <- as.character(conteos$tipo)

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
ggsave(file.path(salida, "reuniones_totales_tipo.png"), reuniones_totales, width = 15, height = 10)

# --- Subconjunto de los niveles 2, 3 y 4 ---------------------------------------
datos_reuniones <- subset(datos, nivel > 1, select = c(margenOrg, area, subarea, tipo, nivel, year))

# --- Fig. 5.5a · Reuniones por año, niveles 2-4, según tipo ---------------------
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
ggsave(file.path(salida, "reuniones_niveles.png"), reuniones_niveles, width = 15, height = 10)

# --- Fig. 7.1 · Reuniones por área temática según tipo -------------------------
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
ggsave(file.path(salida, "reuniones_areas.png"), reuniones_areas, width = 15, height = 10)

# --- Fig. 5.5b · Reuniones por área temática, niveles 2-4, según tipo -----------
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
ggsave(file.path(salida, "reuniones_tematicas_nivel.png"), reuniones_tematicas_nivel, width = 15, height = 10)

# --- Complementaria (no usada en la tesis) · Reuniones por año según formato ----
datos$formato <- fct_recode(datos$formato,
                            "híbrido" = "hybrid")

conteos <- datos %>%
  group_by(year, formato) %>%
  summarize(conteo = n())

conteos <- conteos[complete.cases(conteos), ]
conteos$formato <- as.character(conteos$formato)

reuniones_totales_formato <- ggplot(conteos) +
  geom_col(aes(x = year, y = conteo, fill = formato)) +
  scale_fill_manual(
    values = c("#B2A3A3", "#251F1F", "#736767", "#A49696"),
    name = "Nivel reuniones"   # rótulo original (ver docs/cambios_tecnicos.md)
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
ggsave(file.path(salida, "reuniones_totales_formato.png"), reuniones_totales_formato, width = 15, height = 10)

# =============================================================================
# B) Origen: 02_Grafico_ministerios.R
# =============================================================================
datos <- leer_base()

# --- Fig. 5.4 · Reuniones ministeriales (nivel 2) por área ---------------------
ministerios <- subset(datos, nivel == 2, select = c(margenOrg, area, subarea, tipo))

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

conteos <- ministerios %>%
  group_by(area) %>%
  summarise(conteo = n())

reuniones_ministeriales <- ggplot(conteos) +
  geom_col(aes(x = area, y = conteo))+
  coord_flip()+
  labs(x = "Áreas", y = "Cantidad de Reuniones")+
  theme(legend.position = "none")
ggsave(file.path(salida, "reuniones_ministeriales.png"), reuniones_ministeriales, width = 15, height = 10)

# [CAMBIO] Se omiten los dos gráficos exploratorios finales del original, que no se guardaban.

# =============================================================================
# C) Origen: 04_graficos_areas.R
# =============================================================================
data1 <- leer_base()

# [CAMBIO] El subconjunto económico se toma ANTES de traducir 'area' al español.
# En el original se filtraba area == "economy" después de traducirla a "economía",
# lo que deja el subconjunto vacío al ejecutar el script de corrido.
# El gráfico resultante es el mismo que areas_economicas.png (verificado contra los
# conteos de la base; ver docs/decisiones.md, aclaración A1).
area_economica <- subset(data1, area == "economy")

data1$area <- recodificar_area(data1$area)

# [CAMBIO] Se omiten library(plyr), library(car) y la variable auxiliar 'formalidad'
# (plyr::revalue), que no intervenían en ningún gráfico. Cargar plyr después de
# dplyr enmascara summarize() y podría alterar los conteos de la sección A.

# --- Fig. 5.3 · Áreas temáticas según presidencia pro tempore -------------------
area_presidencias <- ggplot(data1, aes(x = area, fill = tipo)) +
  geom_bar()+
  coord_flip()+
  facet_wrap(~presidencia, nrow = 3)+
  scale_fill_manual(
    values = c("#736767", "#B2A3A3")) +
  labs(fill = "Tipo", y = "Áreas temáticas", x = "Cantidad de reuniones")
ggsave(file.path(salida, "area_presidencias.png"), area_presidencias, width = 15, height = 10)

# --- Complementaria (no usada en la tesis) · Subáreas económicas según tipo -----
areas_economicas <- ggplot(area_economica, aes(x = subarea_economica, fill = tipo)) +
  geom_bar()+
  coord_flip()+
  facet_wrap(~subarea, nrow = 1)

ggsave(file.path(salida, "areas_economicas.png"), areas_economicas, width = 15, height = 10)

message("Figuras de reuniones generadas en ", salida)
