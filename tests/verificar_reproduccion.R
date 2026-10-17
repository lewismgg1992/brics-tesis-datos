# =============================================================================
# tests/verificar_reproduccion.R
#
# Comprueba que el repositorio produce lo esperado. Se ejecuta al final de
# run_all.R o por separado, desde la raíz del proyecto.
#
# Los valores esperados se fijaron en la Etapa 4 con un cálculo independiente
# (Python, sobre los mismos archivos brutos). Si una comprobación falla, el
# mensaje indica qué difiere.
#
# Las figuras no se comparan píxel a píxel: la versión de ggplot2 y el sistema
# de fuentes cambian detalles gráficos sin cambiar los datos. Se verifica que
# existan, y la comparación visual con outputs/figuras/tesis/ se registra en
# docs/reproducibilidad.md.
# =============================================================================

# [CAMBIO] Se cargan sólo los paquetes usados en lugar de library(tidyverse) (D19).
suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(tibble)
})

stopifnot("Ejecutar desde la raíz del repositorio" = file.exists("brics-tesis-datos.Rproj"))

resultados <- tibble(prueba = character(), ok = logical(), detalle = character())
probar <- function(prueba, condicion, detalle = "") {
  detalle <- paste(as.character(detalle), collapse = " ")   # siempre texto, de longitud 1
  resultados <<- add_row(resultados, prueba = prueba, ok = isTRUE(condicion), detalle = detalle)
}

# --- 1. Datos brutos: presentes e íntegros -------------------------------------------
md5_brutos <- c(
  "data/raw/reuniones/Reuniones-Completas-R.xls"                   = "2b9d7231d57ac67675e08b2c6cad808d",
  "data/raw/militar/00_capabilities_militares.ods"                 = "8abd2b623151abecd7cda5748367d316",
  "data/raw/militar/gasto_militar_comparado.csv"                   = "2d3ad1f4cccd04c2e0a3f5d77eefc314",
  "data/raw/militar/cinc_index_comparado.csv"                      = "17f088928fec64b3e53d6dea83508044",
  "data/raw/militar/NMC-60-abridged_extracto_G7_BRICS_1980-2015.csv" = "85782b5b5dbe8834d5bb559a872f639b"
)
for (f in names(md5_brutos)) {
  probar(paste("md5", f), file.exists(f) && unname(tools::md5sum(f)) == md5_brutos[[f]])
}

# --- 2. Reuniones --------------------------------------------------------------------
base <- read_csv("data/processed/reuniones/reuniones_brics_2006_2022.csv", show_col_types = FALSE, guess_max = Inf)
cambios <- read_csv("data/processed/reuniones/registro_cambios.csv", show_col_types = FALSE)

probar("reuniones: 1321 filas", nrow(base) == 1321, nrow(base))
esperado_nivel <- c(`1` = 24, `2` = 230, `3` = 746, `4` = 321)
obs_nivel <- table(base$nivel)
probar("reuniones: totales por nivel", all(obs_nivel[names(esperado_nivel)] == esperado_nivel),
       paste(names(obs_nivel), obs_nivel, collapse = " "))
esperado_anio <- c(1, 1, 6, 10, 21, 32, 30, 47, 37, 124, 133, 110, 123, 116, 138, 197, 195)
probar("reuniones: totales por año 2006-2022",
       identical(as.numeric(table(factor(base$year, levels = 2006:2022))), esperado_anio))
probar("reuniones: 1168 formales / 153 informales",
       sum(base$tipo == "formal") == 1168 && sum(base$tipo == "informal") == 153)
probar("reuniones: 371 reuniones económicas con subárea económica",
       sum(!is.na(base$subarea_economica)) == 371)
probar("reuniones: 230 celdas en el registro de cambios", nrow(cambios) == 230, nrow(cambios))
probar("reuniones: países y siglas corregidos (D24, D26)",
       all(base$pais[base$id_reunion %in% c(310, 324, 327:331, 321)] == "Sudáfrica") &&
         base$pais[base$id_reunion == 204] == "India" &&
         base$pais[base$id_reunion == 95] == "Países Bajos" &&
         base$pais[base$id_reunion == 262] == "Singapur" &&
         base$margenOrg[base$id_reunion == 287] == "RCWIE" &&
         !any(base$margenOrg %in% "RSW") &&
         !any(base$pais %in% c("Gran Bretaña", "Píses Bajos") & base$ciudad %in% c("East London", "La Haya")))
probar("reuniones: Hokkaido 2008 = G8",
       base$margenOrg[base$year == 2008 & base$nivel == 1 & base$ciudad %in% "Hokkaido"] == "G8")
probar("reuniones: 8 reuniones sin presidencia (2006-2008)",
       sum(is.na(base$presidencia)) == 8 && all(base$year[is.na(base$presidencia)] <= 2008))

# --- 3. Capacidades militares ------------------------------------------------------------
ver <- read_csv("data/processed/militar/verificacion_version_tesis.csv", show_col_types = FALSE)
probar("militar: 221 de 224 celdas de la versión tesis reconstruidas", sum(ver$coincide_tesis) == 221)

corr_g <- read_csv("data/processed/militar/gasto_militar_comparado_corregida.csv", show_col_types = FALSE)
corr_c <- read_csv("data/processed/militar/cinc_index_comparado_corregida.csv",    show_col_types = FALSE)
valor <- function(d, p, a, v) d[[v]][d$paises == p & d$year == a]
probar("militar corregida: gasto G7 (sin EEUU) 1980 = 71.63", abs(valor(corr_g, "G7 (sin EEUU)", 1980, "gastoMilitar") - 71.63) < 1e-6)
probar("militar corregida: gasto BRICS 2015 = 45.72",         abs(valor(corr_g, "BRICS", 2015, "gastoMilitar") - 45.72) < 1e-6)
probar("militar corregida: CINC G7 (sin EEUU) 1980 = 125.58", abs(valor(corr_c, "G7 (sin EEUU)", 1980, "cinc") - 125.58) < 1e-6)
probar("militar corregida: CINC BRICS 1980 = 278.37",         abs(valor(corr_c, "BRICS", 1980, "cinc") - 278.37) < 1e-6)
probar("militar corregida: CINC Alemania 1980 = 24.38",       abs(valor(corr_c, "GMY", 1980, "cinc") - 24.38) < 1e-6)

series_t <- read_csv("data/processed/militar/series_paises_1980_2015_tesis.csv",     show_col_types = FALSE)
series_c <- read_csv("data/processed/militar/series_paises_1980_2015_corregida.csv", show_col_types = FALSE)
probar("militar: series tesis 422 filas / corregida 432", nrow(series_t) == 422 && nrow(series_c) == 432)

# --- 4. AGNU ------------------------------------------------------------------------------
agnu_archivo <- "data/processed/agnu/votos_brics_pais_anio_tema.csv"
if (file.exists(agnu_archivo)) {
  agnu <- read_csv(agnu_archivo, show_col_types = FALSE)
  probar("agnu: 5 países", n_distinct(agnu$country) == 5)
  probar("agnu: 6 temas",  n_distinct(agnu$issue) == 6)
  probar("agnu: Sí + No + Abstención = 1", all(abs(agnu$percent_yes + agnu$percent_no + agnu$percent_abstain - 1) < 1e-9))
  probar("agnu: más de 5 votaciones en cada fila", all(agnu$votes > 5))
  probar("agnu: unvotes 0.3.0", as.character(packageVersion("unvotes")) == "0.3.0",
         as.character(packageVersion("unvotes")))
  message("AGNU: años cubiertos ", min(agnu$year), "-", max(agnu$year))
} else {
  probar("agnu: tabla resumida generada", FALSE, "Falta ejecutar scripts/03_agnu/01_votaciones.R")
}

# --- 5. Figuras regeneradas ----------------------------------------------------------------
figuras <- c(
  # Tesis
  "reuniones_totales_tipo.png", "area_presidencias.png", "reuniones_ministeriales.png",
  "reuniones_niveles.png", "reuniones_tematicas_nivel.png", "reuniones_areas.png",
  "GastoMilitar_paises.png", "CINCIndex_paises.png", "gasto_militar_comparado.png", "cinc_comparado.png",
  "votaciones_comparadas.png", "votaciones_NEGATIVAS_comparadas.png", "votaciones_ABSTENCIONES_comparadas.png",
  # Complementarias
  "reuniones_totales_formato.png", "areas_economicas.png",
  # Versión corregida
  "GastoMilitar_paises_corregida.png", "CINCIndex_paises_corregida.png",
  "gasto_militar_comparado_corregida.png", "cinc_comparado_corregida.png"
)
faltan <- figuras[!file.exists(file.path("outputs/figuras/regeneradas", figuras))]
probar("figuras: 19 generadas", length(faltan) == 0, paste(faltan, collapse = ", "))
probar("figuras: dispositivo gráfico ragg instalado (texto legible en los PNG)",
       requireNamespace("ragg", quietly = TRUE))

# --- Resumen ---------------------------------------------------------------------------------
print(resultados, n = Inf)
if (all(resultados$ok)) {
  message("\nTodas las comprobaciones (", nrow(resultados), ") se cumplen.")
} else {
  stop(sum(!resultados$ok), " comprobación(es) fallaron. Ver la tabla anterior.")
}
