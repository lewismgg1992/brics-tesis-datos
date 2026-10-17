# =============================================================================
# Conjunto 2 · Capacidades militares
# 02_relativo_eeuu.R
#
# Indicadores relativos a EEUU (EEUU = 100) cada 5 años, 1980-2015, para cada
# país y para los agregados "G7 (sin EEUU)" y "BRICS" (Fig. 3.13).
#
# En la tesis estos valores se calcularon a mano en una planilla
# (data/raw/militar/00_capabilities_militares.ods) y se copiaron a dos CSV,
# que son la VERSIÓN TESIS y se publican sin cambios en data/raw/militar/.
# Este script reemplaza ese paso manual y:
#   1. reconstruye desde NMC los valores de la versión tesis, con sus mismas
#      reglas, y los compara celda por celda con los CSV originales;
#   2. calcula la VERSIÓN CORREGIDA (decisiones D3 y D8 del autor).
#
# Fórmula : índice = valor del país (o suma del grupo) / valor de EEUU × 100
#
# Versión tesis (reglas reconstruidas en la Etapa 4):
#   - CINC de EEUU en 1980 = valor de 1981 (error de transcripción);
#   - Alemania 1980 y 1985 = 0 (sin dato con el código GMY);
#   - CINC truncado y gasto redondeado a 2 decimales.
# Versión corregida:
#   - CINC de EEUU en 1980 correcto;
#   - Alemania Occidental (GFR) en 1980 y 1985;
#   - ambos indicadores redondeados a 2 decimales.
#
# Entradas: data/raw/militar/NMC-60-abridged_extracto_G7_BRICS_1980-2015.csv
#           data/raw/militar/{gasto_militar,cinc_index}_comparado.csv (versión tesis)
# Salidas : data/processed/militar/gasto_militar_comparado_corregida.csv
#           data/processed/militar/cinc_index_comparado_corregida.csv
#           data/processed/militar/verificacion_version_tesis.csv
# =============================================================================

# [CAMBIO] Se cargan sólo los paquetes usados en lugar de library(tidyverse) (D19).
library(dplyr)
library(tidyr)
library(readr)

stopifnot("Ejecutar desde la raíz del repositorio" = file.exists("brics-tesis-datos.Rproj"))

salida_dato <- "data/processed/militar"
dir.create(salida_dato, recursive = TRUE, showWarnings = FALSE)

nmc <- read_csv("data/raw/militar/NMC-60-abridged_extracto_G7_BRICS_1980-2015.csv",
                show_col_types = FALSE)

anios <- seq(1980, 2015, by = 5)
g7    <- c("GMY", "UKG", "FRN", "CAN", "ITA", "JPN")   # G7 sin EEUU
brics <- c("BRA", "RUS", "IND", "CHN", "SAF")
orden <- c("EEUU", g7, brics, "G7 (sin EEUU)", "BRICS")  # orden de los CSV originales

calcular <- function(indicador, tipo_version) {
  d <- nmc %>% filter(year %in% anios)

  if (tipo_version == "corregida") {
    # Alemania Occidental para 1980 y 1985 (D8); desde 1990, Alemania unificada
    d <- d %>%
      filter(!(stateabb == "GFR" & year >= 1990)) %>%
      mutate(stateabb = if_else(stateabb == "GFR", "GMY", stateabb))
  } else {
    d <- d %>% filter(stateabb != "GFR")
  }

  valores <- d %>% select(stateabb, year, valor = all_of(indicador))

  if (tipo_version == "tesis" && indicador == "cinc") {
    # Error de transcripción de la planilla: CINC de EEUU 1980 = valor de 1981
    usa_1981 <- nmc %>% filter(stateabb == "USA", year == 1981) %>% pull(cinc)
    valores$valor[valores$stateabb == "USA" & valores$year == 1980] <- usa_1981
  }

  eeuu <- valores %>% filter(stateabb == "USA") %>% select(year, eeuu = valor)

  paises <- valores %>%
    filter(stateabb %in% c(g7, brics)) %>%
    complete(stateabb = c(g7, brics), year = anios, fill = list(valor = 0)) %>%  # Alemania 1980-85 = 0 en la versión tesis
    left_join(eeuu, by = "year") %>%
    mutate(indice = valor / eeuu * 100)

  grupos <- paises %>%
    mutate(grupo = if_else(stateabb %in% g7, "G7 (sin EEUU)", "BRICS")) %>%
    group_by(paises = grupo, year) %>%
    summarize(indice = sum(valor) / first(eeuu) * 100, .groups = "drop")

  resultado <- bind_rows(
    tibble(paises = "EEUU", year = anios, indice = 100),
    paises %>% select(paises = stateabb, year, indice),
    grupos
  ) %>%
    mutate(paises = factor(paises, levels = orden)) %>%
    arrange(paises, year) %>%
    mutate(paises = as.character(paises))

  # Redondeo: en la versión tesis, el CINC fue truncado y el gasto redondeado
  if (tipo_version == "tesis" && indicador == "cinc") {
    resultado$indice <- trunc(resultado$indice * 100) / 100
  } else {
    resultado$indice <- round(resultado$indice, 2)
  }
  resultado
}

# --- 1. Verificación de la versión tesis (CSV originales) -----------------------------
original_gasto <- read_csv("data/raw/militar/gasto_militar_comparado.csv", show_col_types = FALSE)
original_cinc  <- read_csv("data/raw/militar/cinc_index_comparado.csv",    show_col_types = FALSE)

verificacion <- bind_rows(
  original_gasto %>% rename(csv_tesis = gastoMilitar) %>%
    left_join(calcular("milex", "tesis") %>% rename(reconstruido = indice), by = c("paises", "year")) %>%
    left_join(calcular("milex", "corregida") %>% rename(corregido = indice), by = c("paises", "year")) %>%
    mutate(indicador = "gasto_militar", .before = 1),
  original_cinc %>% rename(csv_tesis = cinc) %>%
    left_join(calcular("cinc", "tesis") %>% rename(reconstruido = indice), by = c("paises", "year")) %>%
    left_join(calcular("cinc", "corregida") %>% rename(corregido = indice), by = c("paises", "year")) %>%
    mutate(indicador = "cinc", .before = 1)
) %>%
  mutate(coincide_tesis = abs(csv_tesis - reconstruido) < 1e-6,
         dif_corregida  = round(corregido - csv_tesis, 2))

write_csv(verificacion, file.path(salida_dato, "verificacion_version_tesis.csv"))

no_coinciden <- verificacion %>% filter(!coincide_tesis)
# Resultado esperado (Etapa 4): 3 celdas de gasto militar transcriptas a mano con otro
# valor (JPN 2015, ITA 1985, CHN 2000) y ninguna de CINC.
stopifnot(nrow(verificacion) == 224, !anyNA(verificacion$reconstruido), !anyNA(verificacion$corregido))
message("Versión tesis: ", sum(verificacion$coincide_tesis), " de 224 celdas reconstruidas exactamente")
if (nrow(no_coinciden) > 0) {
  message("Celdas que no coinciden con los CSV originales:")
  print(as.data.frame(no_coinciden[, c("indicador", "paises", "year", "csv_tesis", "reconstruido")]))
}

# --- 2. Versión corregida -------------------------------------------------------------
write_csv(calcular("milex", "corregida") %>% rename(gastoMilitar = indice),
          file.path(salida_dato, "gasto_militar_comparado_corregida.csv"))
write_csv(calcular("cinc", "corregida") %>% rename(cinc = indice),
          file.path(salida_dato, "cinc_index_comparado_corregida.csv"))

message("Indicadores relativos a EEUU (versión corregida) generados en ", salida_dato)
