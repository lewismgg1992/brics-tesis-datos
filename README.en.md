# Data and code for the thesis *Cooperando entre emergentes: el BRICS como caso de estudio*

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23428803.svg)](https://doi.org/10.5281/zenodo.23428803)

[Versión en español](README.md) · **English**

This repository contains the data, code and documentation behind the empirical analyses of the doctoral thesis by **Mario Guillermo Guerrero** (PhD in Political Science, Escuela de Política y Gobierno, Universidad Nacional de San Martín, Argentina). It allows users to:

- retrieve the data used in the thesis;
- understand how the data were built;
- regenerate the thesis figures;
- reuse the materials with attribution.

> **Language note.** The thesis, the original data and the figures are in Spanish, and Spanish is the primary language of the repository. The README, data dictionary, methodology, sources and reproducibility guide are also available in English. The other documents (technical changes, figure comparison and decision log) are in Spanish only.

## The thesis

Guerrero, M. G. (2024). *Cooperando entre emergentes: el BRICS como caso de estudio* [Doctoral thesis in Political Science, Universidad Nacional de San Martín]. Repositorio Institucional UNSAM. https://ri.unsam.edu.ar/handle/123456789/2535

The thesis studies the institutionalization of cooperative dynamics within the BRICS between 2001 and 2020. Using process tracing, it reconstructs the causal mechanism linking three variables: actors, institutions and cooperation. The data in this repository are part of the empirical evidence for chapters 3 and 5 and for the methodological appendix (chapter 9).

## The three datasets

| Dataset | Contents | Role in the thesis | Figures |
|---|---|---|---|
| **1. BRICS meetings** (original data) | 1,321 meetings, 2006–2022, coded by level (1–4), type (formal/informal), host organization, thematic area and sub-area, format and pro tempore presidency | Documents the institutional diversification of the BRICS: its deliberation spaces | 5.2b, 5.3, 5.4, 5.5a-b, 7.1 and 2 supplementary figures |
| **2. Military capabilities** | Military expenditure and CINC of the BRICS and G7 countries, 1980–2015 (NMC v6.0), plus indicators relative to the United States | Characterizes the material capabilities of the members | 3.11, 3.12, 3.13a-b |
| **3. UN General Assembly votes** | Share of yes, no and abstention votes of the five countries by year and issue, 1946–2019 | Shows the convergence of positions on the international agenda | 5.8a-c |

**Two versions of the military indicators.** Reconstructing the calculations revealed two transcription errors in the original spreadsheet: the 1980 CINC value for the United States, and the absence of West Germany in 1980–1989. Two versions are therefore published:

- **`tesis`**: the values published in the thesis, unchanged;
- **`corregida`** (corrected): the values recalculated from the source.

Every file and figure name indicates which version it belongs to. See `docs/en/methodology.md` (2.3).

## Structure

File and folder names are in Spanish.

```text
brics-tesis-datos/
├── README.md (Spanish), README.en.md (English), CITATION.cff, LICENSE, LICENSE-data
├── brics-tesis-datos.Rproj      RStudio project
├── run_all.R                    runs everything in order
├── renv.lock                    versions of R and packages
├── data/
│   ├── raw/                     inputs as used (never modified)
│   │   ├── reuniones/           author's original database (.xls) and source tables (.odt and PDF)
│   │   └── militar/             NMC v6.0 extract, original spreadsheet and CSVs of Fig. 3.13
│   └── processed/               produced by the scripts
│       ├── reuniones/           meetings database (CSV) and change log
│       ├── militar/             country series and US-relative indicators (thesis and corrected)
│       └── agnu/                summary table of UN General Assembly votes
├── scripts/
│   ├── 00_entorno/              R environment setup
│   ├── 01_reuniones/            database preparation and figures
│   ├── 02_militar/              series, indicators and figures
│   ├── 03_agnu/                 votes and figures
│   └── originales/              author's original scripts, unmodified
├── outputs/figuras/
│   ├── tesis/                   figures as published in the thesis
│   └── regeneradas/             figures produced by the scripts
├── tests/verificar_reproduccion.R   automated checks
└── docs/                        documentation (English versions in docs/en/)
```

## Documentation

| File | Contents |
|---|---|
| [`docs/en/methodology.md`](docs/en/methodology.md) | How each dataset was built and processed; limitations |
| [`docs/en/data_dictionary.md`](docs/en/data_dictionary.md) | Variables, values and coding rules |
| [`docs/en/sources.md`](docs/en/sources.md) | Data sources, terms of use and citations |
| [`docs/en/reproducibility.md`](docs/en/reproducibility.md) | Requirements, steps, expected result and known issues |
| [`docs/correspondencia_areas.csv`](docs/correspondencia_areas.csv) | Correspondence of areas and sub-areas between the database and the thesis |
| [`docs/figuras.md`](docs/figuras.md) (Spanish) | Thesis figure ↔ script ↔ file, and comparison result |
| [`docs/cambios_tecnicos.md`](docs/cambios_tecnicos.md) (Spanish) | Differences between the original and adapted scripts |
| [`docs/decisiones.md`](docs/decisiones.md) (Spanish) | Log of decisions and discrepancies found |

## How to reproduce the results

**Requirements:**
- R 4.3 or later; tested with R 4.6.1.
- An internet connection to install packages.
- On Linux, some system libraries: see `docs/en/reproducibility.md`.

**Steps:**

```r
# 1. Open brics-tesis-datos.Rproj in RStudio (or start R in this folder)
# 2. Install the packages (once)
renv::restore()          # or: source("scripts/00_entorno/configurar_entorno.R")
# 3. Run everything
source("run_all.R")
```

The process ends with 28 automated checks. The expected final message, in Spanish, is `Todas las comprobaciones (28) se cumplen.` ("All 28 checks pass").

**Degree of reproduction:**
- **Processed data:** reproduced exactly.
- **Figures:** reproduced with the same data, colors and labels. Fonts and some style details may differ depending on the system and package versions (`docs/figuras.md`).

## Sources and access conditions

- **Meetings:** the author's own data, built from official documents of the BRICS and its members, the press and the academic literature. See `docs/en/sources.md`.
- **Military capabilities:** Correlates of War, National Material Capabilities v6.0 (Singer, Bremer and Stuckey, 1972; Singer, 1987). Only the extract used is included.
- **Votes:** Voeten, Strezhnev and Bailey, *United Nations General Assembly Voting Data* (Harvard Dataverse), through the R package `unvotes` 0.3.0. The vote-level data are not redistributed; they are installed from CRAN.

Anyone using third-party data must also cite the original sources.

## Main limitations

- Meetings from 2020–2022 have no individual source recorded.
- The thesis was processed with 2023 versions of R and packages, which were not recorded exactly; the reproduction uses current versions.
- The voting figures depend on the `unvotes` version. With version 0.3.0 the data run until 2019, although the thesis caption says 2020.

The full list is in `docs/en/methodology.md`.

## How to cite

If you use these data or this code, please cite the repository (the version archived on Zenodo) and the thesis. The citation metadata are in `CITATION.cff`; GitHub displays them under "Cite this repository".

> Guerrero, M. G. (2026). *Datos y código de la tesis "Cooperando entre emergentes: el BRICS como caso de estudio"* [Data set and software]. Zenodo. https://doi.org/10.5281/zenodo.23428803
>
> Guerrero, M. G. (2024). *Cooperando entre emergentes: el BRICS como caso de estudio* [Doctoral thesis, Universidad Nacional de San Martín]. https://ri.unsam.edu.ar/handle/123456789/2535

Zenodo assigns two kinds of DOI:

- **10.5281/zenodo.23428803** covers all versions and always resolves to the latest one.
- Each version also has its own DOI, listed on Zenodo. To refer to the exact files you used, cite that one; for example, version 1.1.0 is **10.5281/zenodo.23461781** and version 1.0.0 is **10.5281/zenodo.23428804**. Both versions contain the same data and code; 1.1.0 adds the English documentation.

## Licenses

- **Code** (`scripts/`, `tests/`, `run_all.R`): MIT. See `LICENSE`.
- **Original data and documentation** (meetings database, processed data, `docs/`): Creative Commons Attribution 4.0 International (CC BY 4.0). See `LICENSE-data`.
- **Third-party data:** the NMC v6.0 extract keeps the conditions of the Correlates of War Project. The voting data are not redistributed.
- **Thesis:** governed by its own license (CC BY-NC-ND 4.0) in the UNSAM Institutional Repository.

## Author and contact

**Mario Guillermo Guerrero** — CONICET-UNSL-CERI/UNCUYO
ORCID: [0000-0002-2821-6351](https://orcid.org/0000-0002-2821-6351)
Contact: marioguillermo.guerrero@fulbrightmail.org
