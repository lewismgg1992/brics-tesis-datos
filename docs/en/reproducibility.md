# Reproducibility guide

[Versión en español](../reproducibilidad.md) · **English**

Instructions to regenerate, from scratch, the processed data and the figures in this repository.

## Requirements

- **R** 4.3 or later. The repository was tested with R 4.6.1 on Ubuntu 24.04 (16 October 2026). The thesis was processed with the latest version of R available in 2023; see `docs/decisiones.md` (Spanish), D5 and D19.
- **RStudio** (optional): convenient for opening the project, but not required.
- **Internet connection** during setup, to install packages.
- **Linux only:** system libraries that the `ragg` graphics device needs to compile. On Ubuntu/Debian, install them from the terminal with:

  ```bash
  sudo apt install libfontconfig1-dev libfreetype6-dev libharfbuzz-dev libfribidi-dev \
                   libpng-dev libtiff5-dev libjpeg-dev libwebp-dev
  ```

  Not needed on Windows or macOS, where packages are installed precompiled.

## Steps

1. Open `brics-tesis-datos.Rproj` in RStudio, or start R in the repository folder.
2. Set up the environment. This is done once and takes a few minutes:

   ```r
   source("scripts/00_entorno/configurar_entorno.R")
   ```

   Alternatively, `renv::restore()` installs exactly the versions recorded in `renv.lock`.
3. Run everything:

   ```r
   source("run_all.R")
   ```

## What `run_all.R` does

| Order | Script | Output |
|---|---|---|
| 1 | `scripts/01_reuniones/01_preparar_base.R` | Processed meetings database and change log |
| 2 | `scripts/01_reuniones/02_figuras.R` | Figs. 5.2b, 5.3, 5.4, 5.5a-b, 7.1 and 2 supplementary figures |
| 3 | `scripts/02_militar/01_series_paises.R` | Country series and Figs. 3.11–3.12 (thesis and corrected versions) |
| 4 | `scripts/02_militar/02_relativo_eeuu.R` | Check of the thesis version and corrected indicators |
| 5 | `scripts/02_militar/03_figuras_relativo_eeuu.R` | Figs. 3.13a-b (thesis and corrected versions) |
| 6 | `scripts/03_agnu/01_votaciones.R` | Summary table and Figs. 5.8a-c |
| 7 | `tests/verificar_reproduccion.R` | Table with the 28 checks |

Console messages are in Spanish.

## Expected result

- The last console line should read `Todas las comprobaciones (28) se cumplen.` ("All 28 checks pass").
- Processed data in `data/processed/` and 19 figures in `outputs/figuras/regeneradas/`.
- Expected messages during the run:
  - "Versión tesis: 221 de 224 celdas reconstruidas exactamente" (thesis version: 221 of 224 cells reconstructed exactly), followed by 3 military expenditure cells that do not match. These are the transcription errors documented in `docs/decisiones.md`.
  - "AGNU: años cubiertos 1946-2019" (UN General Assembly: years covered 1946–2019).

## Degree of reproduction

| Component | Result (test of 16 October 2026) |
|---|---|
| Processed meetings data | **Exact.** Counts match the thesis |
| Military indicators, thesis version | **Exact.** The original CSVs are published; 221 of 224 cells are reconstructed from NMC v6.0 |
| UN General Assembly votes | **Exact in the data**, with `unvotes` 0.3.0. Other versions may yield different data |
| Figures | **Approximate.** Same data, variables, colors and labels. Fonts and details of the graphic theme may differ depending on the ggplot2 version and the system |

## Known issues and solutions

| Symptom | Cause | Solution |
|---|---|---|
| Figure text appears as boxes with codes | The Cairo device cannot find the system fonts | Install `ragg`. `configurar_entorno.R` already includes it, and `ggsave()` uses it automatically |
| Installing `systemfonts`, `textshaping` or `ragg` fails (e.g., `fontconfig.h` missing) | Missing system libraries (Linux only) | Install the libraries listed under "Requirements" |
| A package download is interrupted | Unstable connection | Run `configurar_entorno.R` again. If the first source fails, the script tries another one (CRAN) |
| The check "agnu: unvotes 0.3.0" fails | A different version of `unvotes` | Install version 0.3.0. The voting data depend on the version |
