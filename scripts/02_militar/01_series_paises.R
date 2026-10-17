# =============================================================================
# Conjunto 2 · Capacidades militares (G7 y BRICS, 1980-2015)
# 01_series_paises.R
#
# Adaptación de capabilities_militares.R (Fig. 3.12, CINC) y gastos_militares.R
# (Fig. 3.11, gasto militar). Genera dos versiones:
#   - tesis     : idéntica al cálculo original. Alemania sólo desde 1990, porque
#                 el filtro original usa 'GMY' y en NMC Alemania Occidental
#                 1980-1990 figura como 'GFR'.
#   - corregida : agrega Alemania Occidental (GFR) para 1980-1989 bajo la serie
#                 'GMY' (decisión D8 del autor). Desde 1990 se usa GMY, como en la tesis.
#
# Entrada : data/raw/militar/NMC-60-abridged_extracto_G7_BRICS_1980-2015.csv
#           (extracto de NMC v6.0, Correlates of War; ver docs/fuentes.md)
# Salidas : data/processed/militar/series_paises_1980_2015_{tesis,corregida}.csv
#           outputs/figuras/regeneradas/{CINCIndex_paises,GastoMilitar_paises}{,_corregida}.png
# =============================================================================

# [CAMBIO] Se cargan sólo los paquetes usados en lugar de library(tidyverse) (D19).
library(ggplot2)
library(dplyr)
library(readr)
library(scales)

stopifnot("Ejecutar desde la raíz del repositorio" = file.exists("brics-tesis-datos.Rproj"))

salida_fig  <- "outputs/figuras/regeneradas"
salida_dato <- "data/processed/militar"
dir.create(salida_fig,  recursive = TRUE, showWarnings = FALSE)
dir.create(salida_dato, recursive = TRUE, showWarnings = FALSE)

# [CAMBIO] Se lee el extracto publicado en lugar del archivo NMC completo, y se
# elimina View(datos1). El extracto conserva las filas originales sin modificar.
datos1 <- read_csv("data/raw/militar/NMC-60-abridged_extracto_G7_BRICS_1980-2015.csv",
                   show_col_types = FALSE)
stopifnot(nrow(datos1) == 433, all(datos1$version == 2021))

paises <- c("USA", "CAN", "UKG", "FRN", "JPN", "ITA", "GMY", "BRA", "RUS", "IND", "CHN", "SAF")

# --- Versión tesis: mismo filtro que los scripts originales ----------------------
tesis <- datos1 %>%
  filter(stateabb %in% paises, year > 1979 & year < 2016) %>%
  select(stateabb, ccode, year, milex, cinc)

# --- Versión corregida: Alemania Occidental 1980-1989 como serie 'GMY' -----------
corregida <- datos1 %>%
  filter(stateabb %in% c(paises, "GFR"), year > 1979 & year < 2016) %>%
  filter(!(stateabb == "GFR" & year >= 1990)) %>%
  mutate(stateabb_nmc = stateabb,
         stateabb = if_else(stateabb == "GFR", "GMY", stateabb)) %>%
  select(stateabb, stateabb_nmc, ccode, year, milex, cinc)

# Comprobaciones: NMC codifica faltantes como -9; no debe haber ninguno aquí
stopifnot(nrow(tesis) == 422, nrow(corregida) == 432,
          !any(tesis$milex < 0), !any(corregida$milex < 0),
          !any(duplicated(corregida[c("stateabb", "year")])))

write_csv(tesis,     file.path(salida_dato, "series_paises_1980_2015_tesis.csv"))
write_csv(corregida, file.path(salida_dato, "series_paises_1980_2015_corregida.csv"))

# --- Gráficos: código original, aplicado a cada versión ----------------------------
grafico_cinc <- function(datos2, archivo) {
  datos_capability <- datos2 %>%
    group_by(stateabb, year) %>%
    summarize(cinc) %>%
    ungroup()

  p <- ggplot(datos_capability, aes(x = year, y = cinc, linetype = stateabb, color = stateabb, group = stateabb)) +
    geom_line()+
    labs(x = "Año", y = "CINC index", color = "", linetype = "")

  ggsave(filename = file.path(salida_fig, archivo), plot = p, device = "png", width = 8, height = 6)
}

grafico_gasto <- function(datos2, archivo, rotulo_corregido = FALSE) {
  gasto_militar <- datos2 %>%
    group_by(stateabb, year) %>%
    summarize(milex) %>%
    ungroup()

  # Rótulo original (versión tesis): milex está en miles de USD corrientes, por lo
  # que x / 1e6 expresa miles de millones, aunque el eje muestre "M".
  label_millions <- function(x) {
    paste0(round(x / 1e6, 1), "M")
  }

  # [CAMBIO] Versión corregida (decisión D22): mismo cálculo (x / 1e6), con la
  # unidad correcta en el título del eje y sin el sufijo "M".
  if (rotulo_corregido) {
    etiquetas <- function(x) round(x / 1e6, 1)
    titulo_y  <- "Gasto militar (miles de millones de USD corrientes)"
  } else {
    etiquetas <- label_millions
    titulo_y  <- "Gasto Militar"
  }

  p <- ggplot(gasto_militar, aes(x = year, y = milex, linetype = stateabb, color = stateabb, group = stateabb)) +
    geom_line()+
    scale_y_continuous(labels = etiquetas)+
    labs(x = "Año", y = titulo_y, color = "", linetype = "")

  ggsave(filename = file.path(salida_fig, archivo), plot = p, device = "png", width = 8, height = 6)
}

grafico_cinc(tesis,      "CINCIndex_paises.png")            # Fig. 3.12 (tesis)
grafico_gasto(tesis,     "GastoMilitar_paises.png")         # Fig. 3.11 (tesis)
grafico_cinc(corregida,  "CINCIndex_paises_corregida.png")
grafico_gasto(corregida, "GastoMilitar_paises_corregida.png", rotulo_corregido = TRUE)

message("Series por país y figuras 3.11-3.12 generadas (versiones tesis y corregida)")
