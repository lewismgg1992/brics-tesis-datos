# Datos y código de la tesis *Cooperando entre emergentes: el BRICS como caso de estudio*

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23428803.svg)](https://doi.org/10.5281/zenodo.23428803)

**Español** · [English version](README.en.md)

Este repositorio reúne los datos, el código y la documentación de los análisis empíricos de la tesis doctoral de **Mario Guillermo Guerrero** (Doctorado en Ciencia Política, Escuela de Política y Gobierno, Universidad Nacional de San Martín). Permite:

- recuperar los datos usados en la tesis;
- entender cómo se construyeron;
- regenerar sus figuras;
- reutilizar los materiales citando su fuente.

> **English summary.** Data and R code supporting the doctoral thesis *Cooperando entre emergentes: el BRICS como caso de estudio* (Universidad Nacional de San Martín, Argentina). It contains three datasets:
>
> 1. An original, meeting-level database of 1,321 BRICS meetings (2006–2022), coded by level, formal/informal type, thematic area and sub-area, format and pro tempore presidency.
> 2. Military capability indicators (military expenditure and CINC) for the BRICS and G7 countries (1980–2015), from the Correlates of War National Material Capabilities v6.0.
> 3. Voting patterns of the BRICS countries in the UN General Assembly (1946–2019), from Voeten's data via the `unvotes` R package.
>
> All figures can be regenerated with `run_all.R`. **Full English documentation:** [README.en.md](README.en.md) and `docs/en/` (data dictionary, methodology, sources, reproducibility guide).

## La tesis

Guerrero, M. G. (2024). *Cooperando entre emergentes: el BRICS como caso de estudio* [Tesis de Doctorado en Ciencia Política, Universidad Nacional de San Martín]. Repositorio Institucional UNSAM. https://ri.unsam.edu.ar/handle/123456789/2535

La tesis estudia la institucionalización de las dinámicas cooperativas del BRICS entre 2001 y 2020. Mediante *process tracing*, reconstruye el mecanismo causal que vincula tres variables: actores, instituciones y cooperación. Los datos de este repositorio son parte de la evidencia empírica de los capítulos 3 y 5 y del Anexo metodológico (cap. 9).

## Los tres conjuntos de datos

| Conjunto | Qué contiene | Función en la tesis | Figuras |
|---|---|---|---|
| **1. Reuniones del BRICS** (datos propios) | 1.321 reuniones, 2006–2022, con nivel (1–4), tipo (formal/informal), organización marco, área y subárea temática, formato y presidencia pro tempore | Documenta la diversificación institucional del BRICS: sus espacios de deliberación | 5.2b, 5.3, 5.4, 5.5a-b, 7.1 y 2 complementarias |
| **2. Capacidades militares** | Gasto militar y CINC de los países del BRICS y del G7, 1980–2015 (NMC v6.0), e indicadores relativos a EEUU | Caracteriza las capacidades materiales de los miembros | 3.11, 3.12, 3.13a-b |
| **3. Votaciones en la AGNU** | Proporción de votos sí, no y abstención de los cinco países por año y tema, 1946–2019 | Muestra la convergencia de posiciones en la agenda internacional | 5.8a-c |

**Dos versiones de los indicadores militares.** Al reconstruir los cálculos se detectaron dos errores de transcripción en la planilla original: el CINC de EEUU de 1980 y la ausencia de Alemania Occidental en 1980–1989. Por eso se publican dos versiones:

- **`tesis`**: los valores publicados en la tesis, sin cambios;
- **`corregida`**: los valores recalculados desde la fuente.

Cada archivo y cada figura indica en su nombre a qué versión pertenece. Ver `docs/metodologia.md` (2.3).

## Estructura

```text
brics-tesis-datos/
├── README.md, README.en.md, CITATION.cff, LICENSE, LICENSE-data
├── brics-tesis-datos.Rproj      proyecto de RStudio
├── run_all.R                    ejecuta todo en orden
├── renv.lock                    versiones de R y de los paquetes
├── data/
│   ├── raw/                     insumos tal como se usaron (no se modifican)
│   │   ├── reuniones/           base original del autor (.xls) y tablas fuente (.odt y PDF)
│   │   └── militar/             extracto de NMC v6.0, planilla y CSV originales de la Fig. 3.13
│   └── processed/               generados por los scripts
│       ├── reuniones/           base en CSV y registro de cambios
│       ├── militar/             series por país e indicadores relativos a EEUU (tesis y corregida)
│       └── agnu/                tabla resumida de votaciones
├── scripts/
│   ├── 00_entorno/              configuración del entorno de R
│   ├── 01_reuniones/            preparación de la base y figuras
│   ├── 02_militar/              series, indicadores y figuras
│   ├── 03_agnu/                 votaciones y figuras
│   └── originales/              scripts originales del autor, sin modificar
├── outputs/figuras/
│   ├── tesis/                   figuras tal como se publicaron
│   └── regeneradas/             figuras producidas por los scripts
├── tests/verificar_reproduccion.R   comprobaciones automáticas
└── docs/                        documentación (versiones en inglés en docs/en/)
```

## Documentación

| Archivo | Contenido |
|---|---|
| [`docs/metodologia.md`](docs/metodologia.md) | Construcción y procesamiento de cada conjunto; limitaciones |
| [`docs/diccionario_datos.md`](docs/diccionario_datos.md) | Variables, valores y reglas de codificación |
| [`docs/correspondencia_areas.csv`](docs/correspondencia_areas.csv) | Equivalencia de áreas y subáreas entre la base y la tesis |
| [`docs/fuentes.md`](docs/fuentes.md) | Fuentes de los datos, condiciones de uso y citas |
| [`docs/figuras.md`](docs/figuras.md) | Figura de la tesis ↔ script ↔ archivo, y resultado de la comparación |
| [`docs/reproducibilidad.md`](docs/reproducibilidad.md) | Requisitos, pasos, resultado esperado y problemas conocidos |
| [`docs/cambios_tecnicos.md`](docs/cambios_tecnicos.md) | Diferencias entre los scripts originales y los adaptados |
| [`docs/decisiones.md`](docs/decisiones.md) | Registro de decisiones y discrepancias detectadas |

## Cómo reproducir los resultados

**Requisitos:**
- R 4.3 o posterior; probado con R 4.6.1.
- Conexión a internet para instalar paquetes.
- En Linux, algunas bibliotecas del sistema: ver `docs/reproducibilidad.md`.

**Pasos:**

```r
# 1. Abrir brics-tesis-datos.Rproj en RStudio (o iniciar R en esta carpeta)
# 2. Instalar los paquetes (una sola vez)
renv::restore()          # o bien: source("scripts/00_entorno/configurar_entorno.R")
# 3. Ejecutar todo
source("run_all.R")
```

El proceso termina con 28 comprobaciones automáticas. El resultado esperado es `Todas las comprobaciones (28) se cumplen.`

**Grado de reproducción:**
- **Datos procesados:** se reproducen exactamente.
- **Figuras:** se reproducen con los mismos datos, colores y rótulos. Pueden diferir la tipografía y algunos detalles de estilo según el sistema y la versión de los paquetes (`docs/figuras.md`).

## Fuentes y condiciones de acceso

- **Reuniones:** datos propios del autor, construidos a partir de documentos oficiales del BRICS, de sus miembros, de prensa y de bibliografía. Ver `docs/fuentes.md`.
- **Capacidades militares:** Correlates of War, National Material Capabilities v6.0 (Singer, Bremer y Stuckey, 1972; Singer, 1987). Se incluye sólo el extracto usado.
- **Votaciones:** Voeten, Strezhnev y Bailey, *United Nations General Assembly Voting Data* (Harvard Dataverse), a través del paquete de R `unvotes` 0.3.0. La base no se redistribuye: se instala desde CRAN.

Quien use los datos de terceros debe citar también sus fuentes originales.

## Limitaciones principales

- Las reuniones de 2020–2022 no tienen registrada su fuente individual.
- La tesis se procesó con versiones de R y paquetes de 2023 sin registro exacto; la reproducción usa versiones actuales.
- Las figuras de votaciones dependen de la versión de `unvotes`. Con la 0.3.0, los datos cubren hasta 2019, aunque el epígrafe de la tesis dice 2020.

La lista completa está en `docs/metodologia.md`.

## Cómo citar

Si usás estos datos o este código, citá el repositorio (versión archivada en Zenodo) y la tesis. Los metadatos de citación están en `CITATION.cff`; GitHub los muestra en el botón "Cite this repository".

> Guerrero, M. G. (2026). *Datos y código de la tesis "Cooperando entre emergentes: el BRICS como caso de estudio"* [Conjunto de datos y software]. Zenodo. https://doi.org/10.5281/zenodo.23428803
>
> Guerrero, M. G. (2024). *Cooperando entre emergentes: el BRICS como caso de estudio* [Tesis de doctorado, Universidad Nacional de San Martín]. https://ri.unsam.edu.ar/handle/123456789/2535

Zenodo asigna dos DOI:

- **10.5281/zenodo.23428803** reúne todas las versiones y siempre lleva a la más reciente.
- Cada versión tiene además su propio DOI, que figura en Zenodo. Conviene citarlo cuando se quiere remitir exactamente a los archivos usados; por ejemplo, el de la versión 1.0.0 es **10.5281/zenodo.23428804**.

## Licencias

- **Código** (`scripts/`, `tests/`, `run_all.R`): MIT. Ver `LICENSE`.
- **Datos y documentación propios** (base de reuniones, datos procesados, `docs/`): Creative Commons Atribución 4.0 Internacional (CC BY 4.0). Ver `LICENSE-data`.
- **Datos de terceros:** el extracto de NMC v6.0 conserva las condiciones del Correlates of War Project. Los datos de votaciones no se redistribuyen.
- **Tesis:** se rige por su propia licencia (CC BY-NC-ND 4.0) en el Repositorio Institucional UNSAM.

## Autor y contacto

**Mario Guillermo Guerrero** — CONICET-UNSL-CERI/UNCUYO
ORCID: [0000-0002-2821-6351](https://orcid.org/0000-0002-2821-6351)
Contacto: marioguillermo.guerrero@fulbrightmail.org
