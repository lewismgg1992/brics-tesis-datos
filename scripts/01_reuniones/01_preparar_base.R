# =============================================================================
# Conjunto 1 · Reuniones del BRICS (2006-2022)
# 01_preparar_base.R
#
# Convierte la base original (Reuniones-Completas-R.xls, versión definitiva
# usada en la tesis) en un CSV procesado. Las correcciones se limitan a
# errores de escritura y a correcciones aprobadas por el autor (Hokkaido 2008,
# D11; países mal asignados, D24; Singapur y RCWIE, D26).
# Cada celda modificada queda en data/processed/reuniones/registro_cambios.csv.
#
# Entrada : data/raw/reuniones/Reuniones-Completas-R.xls   (no se modifica)
# Salidas : data/processed/reuniones/reuniones_brics_2006_2022.csv
#           data/processed/reuniones/registro_cambios.csv
#
# Ejecutar desde la raíz del proyecto (abrir brics-tesis-datos.Rproj).
# =============================================================================

library(readxl)
library(dplyr)
library(readr)

stopifnot("Ejecutar desde la raíz del repositorio" = file.exists("brics-tesis-datos.Rproj"))

archivo_bruto <- "data/raw/reuniones/Reuniones-Completas-R.xls"

# --- Integridad del insumo ----------------------------------------------------
md5_esperado <- "2b9d7231d57ac67675e08b2c6cad808d"
stopifnot("El archivo bruto no coincide con el usado en la tesis" =
            unname(tools::md5sum(archivo_bruto)) == md5_esperado)

# trim_ws = FALSE: los scripts originales leían con el valor por defecto (TRUE),
# que elimina los espacios sobrantes en silencio. Aquí se leen tal cual para que
# esa limpieza quede registrada abajo. El resultado es el mismo.
datos <- read_excel(archivo_bruto, trim_ws = FALSE)
stopifnot(nrow(datos) == 1321, ncol(datos) == 15)

# Identificador estable: posición de la fila en el archivo original
datos <- datos %>% mutate(id_reunion = row_number(), .before = 1)

# --- Correcciones registradas -------------------------------------------------
cambios <- list()

registrar <- function(df, filas, columna, nuevo, motivo) {
  if (!any(filas)) return(df)
  # Los valores se calculan antes de armar la tabla: dentro de tibble() cada
  # columna nueva tapa a los objetos del mismo nombre en las columnas siguientes.
  ids       <- df$id_reunion[filas]
  originales <- as.character(df[[columna]][filas])
  nuevos     <- as.character(nuevo[filas])
  cambios[[length(cambios) + 1]] <<- data.frame(
    id_reunion     = ids,
    variable       = columna,
    valor_original = originales,
    valor_nuevo    = nuevos,
    motivo         = motivo,
    stringsAsFactors = FALSE
  )
  df[[columna]][filas] <- nuevo[filas]
  df
}

# 1) Espacios sobrantes al inicio o al final de los textos
for (v in names(datos)[sapply(datos, is.character)]) {
  x <- datos[[v]]
  recortado <- trimws(x)
  filas <- !is.na(x) & x != recortado
  datos <- registrar(datos, filas, v, recortado, "Espacio sobrante al inicio o al final")
}

# 2) Mes escrito en inglés
nuevo <- ifelse(datos$mes %in% "june", "junio", datos$mes)
datos <- registrar(datos, datos$mes %in% "june", "mes", nuevo, "Mes escrito en inglés")

# 3) Subáreas con escritura inconsistente
equivalencias <- c("agua"                        = "water",
                   "International-organizations" = "international-organizations",
                   "International-security"      = "international-security")
filas <- datos$subarea %in% names(equivalencias)
nuevo <- ifelse(filas, equivalencias[datos$subarea], datos$subarea)
datos <- registrar(datos, filas, "subarea", nuevo, "Unificación de escritura de la categoría")

# 4) Hokkaido 2008: reunión al margen del G8, no del G20 (decisión D11 del autor)
filas <- datos$year == 2008 & datos$nivel == 1 & datos$ciudad %in% "Hokkaido" & datos$margenOrg %in% "G20"
stopifnot(sum(filas) == 1)
nuevo <- ifelse(filas, "G8", datos$margenOrg)
datos <- registrar(datos, filas, "margenOrg", nuevo, "Corrección del autor (D11): reunión al margen del G8")

# 5) País mal asignado o mal escrito, heredado de las tablas fuente (decisión D24 del autor)
#    Se identifica cada reunión por id_reunion y se comprueba el valor original.
correcciones_pais <- data.frame(
  id_reunion = c(310, 324, 327, 328, 329, 330, 331, 204, 321, 95),
  ciudad     = c(rep("East London", 7), "Hyderabad", "Gauteng", "La Haya"),
  original   = c(rep("Gran Bretaña", 7), "Pakistán", "China", "Píses Bajos"),
  correcto   = c(rep("Sudáfrica", 7), "India", "Sudáfrica", "Países Bajos"),
  motivo     = c(rep("Corrección del autor (D24): la ciudad está en Sudáfrica", 7),
                 "Corrección del autor (D24): la ciudad está en India",
                 "Corrección del autor (D24): la provincia está en Sudáfrica",
                 "Corrección del autor (D24): errata en el nombre del país"),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(correcciones_pais))) {
  cp <- correcciones_pais[i, ]
  filas <- datos$id_reunion == cp$id_reunion
  stopifnot(sum(filas) == 1,
            datos$ciudad[filas] %in% cp$ciudad,
            datos$pais[filas]   %in% cp$original)
  nuevo <- ifelse(filas, cp$correcto, datos$pais)
  datos <- registrar(datos, filas, "pais", nuevo, cp$motivo)
}

# 6) Singapur: único país escrito en inglés (decisión D26 del autor)
filas <- datos$id_reunion == 262
stopifnot(sum(filas) == 1, datos$pais[filas] %in% "Singapore")
nuevo <- ifelse(filas, "Singapur", datos$pais)
datos <- registrar(datos, filas, "pais", nuevo, "Corrección del autor (D26): nombre del país en español")

# 7) Russian Competition Week: dos siglas para el mismo foro; se unifica en RCWIE (decisión D26)
filas <- datos$id_reunion == 287
stopifnot(sum(filas) == 1, datos$margenOrg[filas] %in% "RSW")
nuevo <- ifelse(filas, "RCWIE", datos$margenOrg)
datos <- registrar(datos, filas, "margenOrg", nuevo,
                   "Corrección del autor (D26): misma organización marco que RCWIE (Russian Competition Week)")

registro <- bind_rows(cambios)

# --- Comprobaciones de integridad ----------------------------------------------
stopifnot(
  nrow(datos) == 1321,
  !anyNA(datos$nivel), all(datos$nivel %in% 1:4),
  !anyNA(datos$year),  all(datos$year %in% 2006:2022),
  all(datos$tipo %in% c("formal", "informal")),
  # La subárea económica existe sólo (y siempre) en el área económica
  all(!is.na(datos$subarea_economica) == (datos$area == "economy")),
  # Regla formal / informal: única excepción documentada, São Paulo 2008 (D11)
  sum(datos$tipo == "informal" & datos$margenOrg %in% "BRICS") == 1
)

# --- Salidas -------------------------------------------------------------------
dir.create("data/processed/reuniones", recursive = TRUE, showWarnings = FALSE)
write_csv(datos,    "data/processed/reuniones/reuniones_brics_2006_2022.csv", na = "")
write_csv(registro, "data/processed/reuniones/registro_cambios.csv",          na = "")

message("Base procesada: ", nrow(datos), " reuniones; celdas modificadas: ", nrow(registro))
