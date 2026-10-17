# =============================================================================
# Conjunto 2 · Capacidades militares
# 03_figuras_relativo_eeuu.R
#
# Adaptación de GM_comparado.R (Fig. 3.13a) y cinc_index_comparado.R (Fig. 3.13b).
# Se grafica cada versión con el código original:
#   - tesis     : CSV originales (data/raw/militar/)
#   - corregida : CSV de 02_relativo_eeuu.R (data/processed/militar/)
#
# Salidas: outputs/figuras/regeneradas/{gasto_militar_comparado,cinc_comparado}{,_corregida}.png
# =============================================================================

# [CAMBIO] Se cargan sólo los paquetes usados en lugar de library(tidyverse) (D19).
library(ggplot2)
library(dplyr)
library(readr)

stopifnot("Ejecutar desde la raíz del repositorio" = file.exists("brics-tesis-datos.Rproj"))

salida_fig <- "outputs/figuras/regeneradas"
dir.create(salida_fig, recursive = TRUE, showWarnings = FALSE)

# [CAMBIO] Rutas relativas a la raíz del proyecto; se elimina View(datos1).

grafico_gasto_comparado <- function(archivo_csv, archivo_png) {
  datos1 <- read_csv(archivo_csv, show_col_types = FALSE)

  datos1$gastoMilitar2 <- as.numeric(datos1$gastoMilitar)

  datos2 <- filter(datos1,
                   paises == "EEUU" | paises == "G7 (sin EEUU)" | paises == "BRICS")

  gasto_militar <- datos2 %>%
    group_by(paises, year) %>%
    summarize(gastoMilitar2) %>%
    ungroup()

  p <- ggplot(gasto_militar, aes(x = year, y = gastoMilitar2, color = paises)) +
    geom_line() +
    labs(x = "Año", y = "% gasto militar", color = "")+
    theme(legend.position = "bottom")

  ggsave(filename = file.path(salida_fig, archivo_png), plot = p, device = "png", width = 6, height = 4)
}

grafico_cinc_comparado <- function(archivo_csv, archivo_png) {
  datos1 <- read_csv(archivo_csv, show_col_types = FALSE)

  datos1$cinc2 <- as.numeric(datos1$cinc)

  datos2 <- filter(datos1,
                   paises == "EEUU" | paises == "G7 (sin EEUU)" | paises == "BRICS")

  cinc_comparado <- datos2 %>%
    group_by(paises, year) %>%
    summarize(cinc2) %>%
    ungroup()

  p <- ggplot(cinc_comparado, aes(x = year, y = cinc2, color = paises)) +
    geom_line() +
    labs(x = "Año", y = "% CINC index", color = "")+
    theme(legend.position = "bottom")

  ggsave(filename = file.path(salida_fig, archivo_png), plot = p, device = "png", width = 6, height = 4)
}

# Versión tesis (Figs. 3.13a y 3.13b)
grafico_gasto_comparado("data/raw/militar/gasto_militar_comparado.csv", "gasto_militar_comparado.png")
grafico_cinc_comparado("data/raw/militar/cinc_index_comparado.csv",     "cinc_comparado.png")

# Versión corregida
grafico_gasto_comparado("data/processed/militar/gasto_militar_comparado_corregida.csv",
                        "gasto_militar_comparado_corregida.png")
grafico_cinc_comparado("data/processed/militar/cinc_index_comparado_corregida.csv",
                       "cinc_comparado_corregida.png")

message("Figuras 3.13a-b generadas (versiones tesis y corregida)")
