# Guía de reproducibilidad

Instrucciones para regenerar, desde cero, los datos procesados y las figuras del repositorio.

## Requisitos

- **R** 4.3 o posterior. El repositorio se probó con R 4.6.1 en Ubuntu 24.04 (16/10/2026). La tesis se procesó con la última versión de R disponible en 2023; ver `docs/decisiones.md`, D5 y D19.
- **RStudio** (opcional): facilita abrir el proyecto, pero no es necesario.
- **Conexión a internet** durante la configuración, para instalar paquetes.
- **Sólo en Linux:** bibliotecas del sistema que necesita el dispositivo gráfico `ragg` para compilarse. En Ubuntu/Debian se instalan desde la terminal con:

  ```bash
  sudo apt install libfontconfig1-dev libfreetype6-dev libharfbuzz-dev libfribidi-dev \
                   libpng-dev libtiff5-dev libjpeg-dev libwebp-dev
  ```

  En Windows y macOS no hace falta: los paquetes se instalan ya compilados.

## Pasos

1. Abrir `brics-tesis-datos.Rproj` en RStudio, o iniciar R en la carpeta del repositorio.
2. Configurar el entorno. Se hace una sola vez y tarda unos minutos:

   ```r
   source("scripts/00_entorno/configurar_entorno.R")
   ```

   Si el repositorio ya trae `renv.lock`, se puede usar en su lugar `renv::restore()` para instalar exactamente las versiones registradas.
3. Ejecutar todo:

   ```r
   source("run_all.R")
   ```

## Qué hace `run_all.R`

| Orden | Script | Produce |
|---|---|---|
| 1 | `scripts/01_reuniones/01_preparar_base.R` | Base de reuniones procesada y registro de cambios |
| 2 | `scripts/01_reuniones/02_figuras.R` | Figs. 5.2b, 5.3, 5.4, 5.5a-b, 7.1 y 2 complementarias |
| 3 | `scripts/02_militar/01_series_paises.R` | Series por país y Figs. 3.11-3.12 (versiones tesis y corregida) |
| 4 | `scripts/02_militar/02_relativo_eeuu.R` | Verificación de la versión tesis e indicadores corregidos |
| 5 | `scripts/02_militar/03_figuras_relativo_eeuu.R` | Figs. 3.13a-b (versiones tesis y corregida) |
| 6 | `scripts/03_agnu/01_votaciones.R` | Tabla resumida y Figs. 5.8a-c |
| 7 | `tests/verificar_reproduccion.R` | Tabla con las 28 comprobaciones |

## Resultado esperado

- La última línea de la consola debe decir: `Todas las comprobaciones (27) se cumplen.`
- Datos procesados en `data/processed/` y 19 figuras en `outputs/figuras/regeneradas/`.
- Mensajes esperables durante la ejecución:
  - "Versión tesis: 221 de 224 celdas reconstruidas exactamente", seguido de 3 celdas de gasto militar que no coinciden. Son los errores de transcripción ya documentados en `docs/decisiones.md`.
  - "AGNU: años cubiertos 1946-2019".

## Grado de reproducción

| Componente | Resultado (prueba del 16/10/2026) |
|---|---|
| Datos procesados de reuniones | **Exacta.** Los conteos coinciden con la tesis |
| Indicadores militares, versión tesis | **Exacta.** Se publican los CSV originales; 221 de 224 celdas se reconstruyen desde NMC v6.0 |
| Votaciones AGNU | **Exacta en los datos**, con `unvotes` 0.3.0. Con otra versión los datos pueden diferir |
| Figuras | **Aproximada.** Mismos datos, variables, colores y rótulos. Pueden diferir la tipografía y detalles del tema gráfico según la versión de ggplot2 y el sistema |

## Problemas conocidos y soluciones

| Síntoma | Causa | Solución |
|---|---|---|
| El texto de las figuras aparece como recuadros con códigos | El dispositivo Cairo no encuentra las fuentes del sistema | Instalar `ragg`. `configurar_entorno.R` ya lo incluye; `ggsave()` lo usa automáticamente |
| Falla la instalación de `systemfonts`, `textshaping` o `ragg` (por ejemplo, falta `fontconfig.h`) | Faltan bibliotecas del sistema (sólo Linux) | Instalar las bibliotecas indicadas en "Requisitos" |
| Se corta la descarga de un paquete | Conexión inestable | Volver a ejecutar `configurar_entorno.R`. Si la primera fuente falla, el script prueba otra (CRAN) |
| La comprobación "agnu: unvotes 0.3.0" falla | Versión distinta de `unvotes` | Instalar la 0.3.0. Los datos de votaciones dependen de la versión |
