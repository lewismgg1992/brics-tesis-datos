# =============================================================================
# run_all.R — Ejecuta todo el repositorio en el orden documentado
#
# Abrir brics-tesis-datos.Rproj en RStudio (o iniciar R en esta carpeta) y
# ejecutar:  source("run_all.R")
#
# Requisito previo (una sola vez): source("scripts/00_entorno/configurar_entorno.R")
# (o renv::restore() si el repositorio ya trae renv.lock).
# Ver docs/reproducibilidad.md.
# =============================================================================

stopifnot("Ejecutar desde la raíz del repositorio" = file.exists("brics-tesis-datos.Rproj"))

pasos <- c(
  "scripts/01_reuniones/01_preparar_base.R",
  "scripts/01_reuniones/02_figuras.R",
  "scripts/02_militar/01_series_paises.R",
  "scripts/02_militar/02_relativo_eeuu.R",
  "scripts/02_militar/03_figuras_relativo_eeuu.R",
  "scripts/03_agnu/01_votaciones.R",
  "tests/verificar_reproduccion.R"
)

for (p in pasos) {
  message("\n== ", p, " ==")
  # Cada script se ejecuta en un entorno propio, como si se abriera por separado
  source(p, local = new.env(), encoding = "UTF-8")
}

message("\nListo. Datos en data/processed/ y figuras en outputs/figuras/regeneradas/")
