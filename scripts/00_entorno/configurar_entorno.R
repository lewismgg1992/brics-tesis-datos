# =============================================================================
# scripts/00_entorno/configurar_entorno.R
#
# Instala los paquetes que usa el repositorio y registra sus versiones en
# renv.lock. Se ejecuta UNA vez, desde la raíz del proyecto:
#     source("scripts/00_entorno/configurar_entorno.R")
#
# Criterio (decisiones D5 y D19):
#   - La tesis se procesó con las últimas versiones de R y de los paquetes
#     disponibles en 2023, sin registro exacto. Ese entorno no puede
#     reconstruirse de forma fiable en versiones actuales de R: los paquetes de
#     2023 deben compilarse y algunos no compilan en R >= 4.5.
#   - Por eso la reproducción usa la versión de R instalada y los paquetes
#     actuales, y renv.lock registra exactamente cuáles se usaron.
#   - Los datos procesados no dependen de estas versiones (son conteos y
#     cocientes). Sí pueden variar detalles gráficos de las figuras (ggplot2) y,
#     en el conjunto AGNU, los datos si 'unvotes' no está en la versión 0.3.0.
#
# Sólo se instalan los paquetes que usan los scripts (no 'tidyverse' completo),
# más 'ragg' como dispositivo gráfico para los PNG.
# =============================================================================

stopifnot("Ejecutar desde la raíz del repositorio" = file.exists("brics-tesis-datos.Rproj"))

paquetes <- c("ggplot2", "dplyr", "tidyr", "readr", "forcats", "tibble",
              "readxl", "scales", "lubridate", "ggthemes", "unvotes",
              # Dispositivo gráfico: ggsave() lo usa automáticamente para los PNG
              # cuando está instalado. Evita depender de Cairo/Pango para encontrar
              # las fuentes del sistema (ver docs/decisiones.md, R1).
              "ragg")

message("R en uso: ", R.version.string)

# Descargas lentas o interrumpidas: más tiempo antes de abandonar una descarga
options(timeout = max(600, getOption("timeout")))

# Fuentes, en orden de preferencia:
#   1. Posit Package Manager: binarios ya compilados (rápido; evita compilar en Linux)
#   2. CRAN: si la anterior falla (en Linux compila desde el código fuente)
fuentes <- c(P3M  = "https://packagemanager.posit.co/cran/latest",
             CRAN = "https://cloud.r-project.org")

if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv", repos = fuentes[["CRAN"]])
}

if (!file.exists("renv/activate.R")) {
  renv::init(bare = TRUE, restart = FALSE)
} else {
  renv::activate()
}

instalado <- FALSE
for (nombre in names(fuentes)) {
  message("\nInstalando paquetes desde ", nombre, " (", fuentes[[nombre]], ")...")
  options(repos = c(CRAN = fuentes[[nombre]]))
  instalado <- tryCatch({
    renv::install(paquetes, prompt = FALSE)
    TRUE
  }, error = function(e) {
    message("Falló la instalación desde ", nombre, ": ", conditionMessage(e))
    FALSE
  })
  if (instalado) break
}
if (!instalado) stop("No se pudieron instalar los paquetes desde ninguna fuente. Ver docs/reproducibilidad.md")

# Registrar el entorno: CRAN como repositorio de referencia en renv.lock
options(repos = c(CRAN = fuentes[["CRAN"]]))
renv::snapshot(packages = c("renv", paquetes), prompt = FALSE)

v_unvotes <- as.character(packageVersion("unvotes"))
message("\nEntorno registrado en renv.lock")
message("unvotes instalado: ", v_unvotes,
        if (v_unvotes == "0.3.0") " (la misma versión que en 2023)" else
          "  <-- ATENCIÓN: distinta de 0.3.0; los datos de votaciones pueden diferir")
message("Siguiente paso: source(\"run_all.R\")")
