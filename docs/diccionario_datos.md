# Diccionario de datos

Este documento describe los archivos de datos publicados en el repositorio.

- Los nombres de las variables se conservan tal como estaban en los archivos originales del autor.
- Las categorías codificadas en inglés se conservan en inglés. Su equivalencia con las categorías en español de la tesis está en `docs/correspondencia_areas.csv`.

**Índice**

1. [Reuniones del BRICS, 2006–2022](#1-reuniones-del-brics-20062022)
2. [Capacidades militares, 1980–2015](#2-capacidades-militares-19802015)
3. [Votaciones en la Asamblea General de la ONU](#3-votaciones-en-la-asamblea-general-de-la-onu)

---

## 1. Reuniones del BRICS, 2006–2022

**Archivo principal:** `data/processed/reuniones/reuniones_brics_2006_2022.csv`. Lo genera `scripts/01_reuniones/01_preparar_base.R` a partir de `data/raw/reuniones/Reuniones-Completas-R.xls`.

**Unidad de análisis:** una reunión (encuentro, foro, grupo de trabajo, cumbre u otra instancia) entre actores de los países del BRICS, gubernamentales o no, registrada entre 2006 y 2022.

**Tamaño:** 1.321 filas × 16 variables. Codificación UTF-8, separador coma. Las celdas vacías son datos faltantes.

| Variable | Tipo | Descripción | Valores / reglas |
|---|---|---|---|
| `id_reunion` | entero | Identificador de la reunión: posición de la fila en el archivo original del autor | 1–1321. Agregada en la preparación; permite cruzar con `registro_cambios.csv` |
| `orgYear` | texto | Variable auxiliar del autor | Siempre `"BRICS"` + año (p. ej. `BRICS2015`). Redundante con `year` |
| `nivel` | entero | Nivel de deliberación según los actores participantes | `1` cumbres de jefes de Estado y de Gobierno (24); `2` reuniones ministeriales (230); `3` reuniones técnico-burocráticas (746); `4` reuniones *people-to-people* (321). El nivel 1 incluye 10 encuentros informales de líderes al margen del G8/G20 |
| `mes` | texto | Mes de inicio de la reunión, en español | `enero` … `diciembre`. Faltante en 109 reuniones |
| `dia` | entero | Día de inicio | 1–31. Faltante en 223 reuniones. Para reuniones de varios días, el primero |
| `year` | entero | Año de la reunión | 2006–2022 |
| `ciudad` | texto | Ciudad sede | 130 ciudades. Faltante en 528 reuniones, casi todas virtuales o híbridas de 2020–2022 |
| `pais` | texto | País sede, en español | 27 países. Faltante en 523 reuniones. Ver errores conocidos al final de esta sección |
| `nombre` | texto | Nombre de la reunión, tal como figura en la fuente (generalmente en inglés) | Texto libre |
| `tipo` | texto | Tipo de reunión | `formal` (1.168) o `informal` (153). Regla en la nota 1 |
| `margenOrg` | texto | Organización o reunión internacional en cuyo marco se realizó la reunión | `BRICS` si se realizó en el marco propio del BRICS (1.169); si no, la sigla de la organización marco (tabla A). Faltante en 3 reuniones |
| `area` | texto | Área temática | 18 valores (tabla B) |
| `subarea` | texto | Subárea temática dentro del área | 99 valores (100 en el archivo original: la preparación unifica `agua` con `water`). Ver `docs/correspondencia_areas.csv`. `general` = reuniones transversales o de alcance temático amplio |
| `subarea_economica` | texto | Subdivisión de las reuniones del área económica | 29 valores (tabla C). Sólo para `area == "economy"`: completa en las 371 reuniones económicas y vacía en el resto |
| `formato` | texto | Modalidad de la reunión | `presencial` (813), `virtual` (442), `hybrid` (34), `no data` (32: sin información, todas de 2022). Verificado por el autor reunión por reunión (D9) |
| `presidencia` | texto | Presidencia pro tempore del BRICS a la que se atribuye la reunión | `brasil`, `rusia`, `india`, `china`, `sudafrica`. Faltante en las 8 reuniones de 2006–2008, anteriores a la primera cumbre. Regla en la nota 2 |

**Nota 1. Regla formal / informal (Anexo 9.2 de la tesis).**
- **Informal:** reunión realizada al margen o en el marco de otra reunión, organización o foro internacional (G20, Asamblea General de la ONU, FMI/BM, etc.).
- **Formal:** reunión coordinada y realizada en el seno del BRICS, sin una organización marco.
- En la base, `tipo == "informal"` coincide con `margenOrg != "BRICS"` en todas las reuniones salvo una excepción confirmada por el autor (D11): la primera reunión de ministros de finanzas (São Paulo, 7/11/2008). Es informal sin haberse realizado al margen de otra organización.

**Nota 2. Presidencia pro tempore.**
- Cada reunión lleva la presidencia del país que organizó la cumbre de jefes de Estado y de Gobierno de su mismo año calendario, aunque la reunión se haya realizado después de esa cumbre.
- En 2009–2022, 303 reuniones fueron posteriores a la cumbre de su año y conservan la presidencia del anfitrión de esa cumbre.
- Así quedó registrado en la base y así se usa en la Fig. 5.3 (D10, D18).

### Tabla A. Organizaciones marco (`margenOrg`)

Entre paréntesis, la cantidad de reuniones en la base procesada. Los significados provienen de las tablas fuente del autor (`.odt`); `AML/CFT`, `ISSEK` y `UNICEF` fueron confirmados por el autor el 16/10/2026 (D25).

| Sigla | Organización o reunión marco |
|---|---|
| `G20` (49) | Grupo de los 20 (cumbres y reuniones de ministros de finanzas y bancos centrales) |
| `IMF-WB` (25) | Reuniones anuales y de primavera del FMI y el Banco Mundial |
| `ONU` (21) | Naciones Unidas (principalmente la Asamblea General) |
| `OMS` (12) | Organización Mundial de la Salud (Asamblea Mundial de la Salud, Consejo Ejecutivo) |
| `FATF` (8) | Grupo de Acción Financiera Internacional (GAFI/FATF) |
| `UNESCO` (5) | UNESCO |
| `WCO` (4) | Organización Mundial de Aduanas (conferencia anual) |
| `ILO` (2) | Organización Internacional del Trabajo |
| `IPU` (2) | Unión Interparlamentaria |
| `WTO` (2) | Organización Mundial del Comercio (conferencias ministeriales) |
| `G8` (1) | Grupo de los 8 (Hokkaido, 2008). Corregido de `G20` en la versión procesada (D11) |
| `AML/CFT` (1) | Anti-Money Laundering and Countering the Financing of Terrorism: antilavado de dinero y lucha contra el financiamiento del terrorismo (París, 2015) |
| `CADE` (1) | Consejo Administrativo de Defensa Económica (Brasil) |
| `ENES` (1) | Foro Internacional sobre Eficiencia Energética y Ahorro de Energía (Moscú, 2015) |
| `GMMFIG` (1) | Reunión Global Multisectorial sobre el Futuro de la Gobernanza de Internet (São Paulo, 2014) |
| `ICN` (1) | International Competition Network (conferencia anual) |
| `ILC` (1) | Conferencia Internacional del Trabajo |
| `ILW` (1) | International Law Week (Nueva York, 2015) |
| `IMSS` (1) | Reunión Internacional de Altos Funcionarios Responsables de Asuntos de Seguridad (San Petersburgo, 2012) |
| `IPEEC` (1) | International Partnership for Energy Efficiency Cooperation |
| `ISSEK` (1) | Institute for Statistical Studies and Economics of Knowledge, Escuela Superior de Economía (HSE, Moscú), 2020 |
| `NSS` (1) | Cumbre de Seguridad Nuclear (La Haya, 2014) |
| `RCWIE` (2) | Russian Competition Week International Event: foro anual del Servicio Federal Antimonopolio de Rusia (Moscú, 2015; Sochi, 2018). La reunión de 2018 figuraba como `RSW` en la base original; se unificó (D26) |
| `UCLH` (1) | 50.ª Conferencia de la Unión sobre Salud Pulmonar (Union Conference on Lung Health, 2019) |
| `UNAIDS` (1) | ONUSIDA |
| `UNCAC` (1) | Grupo de trabajo sobre recuperación de activos de la Convención de la ONU contra la Corrupción |
| `UNICEF` (1) | United Nations Children's Fund (Fondo de las Naciones Unidas para la Infancia). La tabla fuente vincula esta reunión (taller sobre bancos de leche humana, 2019) con la Semana Mundial de la Lactancia Materna |
| `WIPO` (1) | Organización Mundial de la Propiedad Intelectual |

### Tabla B. Áreas temáticas (`area`)

Para la equivalencia completa de subáreas, ver `docs/correspondencia_areas.csv`.

| Valor | Área en la tesis | Reuniones | Rótulo en las figuras |
|---|---|---|---|
| `agriculture` | Agricultura | 35 | agricultura |
| `communication` | Comunicación | 18 | comunicación |
| `culture` | Cultura | 52 | cultura |
| `disaster management` | Manejo de desastres | 13 | manejo de desastres |
| `economy` | Economía (finanzas y comercio) | 371 | economía |
| `education` | Educación | 67 | educación |
| `energy` | Energía | 41 | energía |
| `environment` | Ambiente | 33 | ambiente |
| `foreign` | Exterior | 51 | cancilleres |
| `government` | Gobierno | 103 | gobierno |
| `health` | Salud | 72 | salud |
| `industry` | Industria | 40 | industria |
| `infrastructure` | Infraestructura | 20 | infraestructura |
| `labour` | Trabajo y Empleo | 26 | trabajo |
| `organizational` | Organización | 78 | organización |
| `security-defense` | Seguridad y Defensa | 63 | seguridad-defensa |
| `social` | Social | 78 | social |
| `sti` | Ciencia, tecnología e innovación | 160 | cyt |

> **Nota sobre la Tabla 9.1 de la tesis (D13).** En la Tabla 9.1 (Anexo 9.2), la fila "Industria" lista en realidad las subáreas de Infraestructura (Transporte, Inversiones, Investigación y Cooperación, Trenes). Faltan la fila "Infraestructura" y las subáreas propias de Industria (Cooperativas, Incubadoras, Pymes, Start up, Internet, Innovación, Seguridad Industrial). Tampoco figura "Propiedad intelectual" (16 reuniones del área CTI). La base de datos y la versión del anexo conservada por el autor (`01_Anexo.odt`) sí son correctas. Este diccionario y `docs/correspondencia_areas.csv` siguen la base. La tesis no se modifica.

### Tabla C. Subdivisión económica (`subarea_economica`)

Agrupada según la `subarea` en la que aparece en la base (Tabla 9.2 de la tesis):

- **`subarea == "general"`:** `general`, `digital-economy`, `economic-cooperation`, `economic-research`, `soe` (empresas estatales).
- **`subarea == "finance"`:** `general`, `asset` (bonos y activos), `bank`, `cra` (Acuerdo de Reservas de Contingencia), `digital-financial-inclusion`, `economic-information`, `international-development-assistance`, `investment`, `ndb` (Nuevo Banco de Desarrollo), `tax`, `trade-exchange`.
- **`subarea == "trade"`:** `general`, `business`, `capacity-building`, `competence` (defensa de la competencia), `cooperation`, `customs`, `digital-market`, `e-commerce`, `export-credit`, `fair`, `promotion-agencies`, `quality-standarization`, `service`, `statistics`, `trade-promotion`.

Diferencias con la Tabla 9.2 de la tesis:
- `export-credit` figura en Finanzas en la tabla, pero en la base está en `trade` (7 reuniones).
- `tax` (23 reuniones) no figura en la Tabla 9.2, pero sí en la versión del anexo del autor, como "Impuestos".

**Reclasificación del CGETI (D27).** Las 29 reuniones del Grupo de Contacto sobre Asuntos Económicos y Comerciales (Contact Group on Economic and Trade Issues, CGETI) tienen `subarea == "general"` y `subarea_economica == "general"` en la base:
- En las tablas fuente del autor (`.odt`, 2006–2019), casi todas figuran en la subárea "Finanzas". Las dos primeras (Beijing, diciembre de 2011, y Nueva Delhi, marzo de 2012) figuran en "Comercio".
- Al construir la base, el autor las reclasificó como `general`. La base se conserva así, por decisión del autor.
- Son 29 de las 42 reuniones económicas con `subarea == "general"`. Esta clasificación determina los paneles de la figura complementaria `areas_economicas.png`.

### Registro de cambios

**Archivo:** `data/processed/reuniones/registro_cambios.csv`. Contiene una fila por celda modificada al preparar la base (230 celdas).

| Variable | Descripción |
|---|---|
| `id_reunion` | Reunión afectada |
| `variable` | Variable modificada |
| `valor_original` | Valor en el `.xls` original |
| `valor_nuevo` | Valor en la base procesada |
| `motivo` | Motivo del cambio |

Motivos registrados:
- 211 espacios sobrantes;
- 3 meses escritos en inglés;
- 3 unificaciones de escritura de subáreas;
- 1 corrección del autor (Hokkaido 2008, G20 → G8);
- 11 correcciones del autor en `pais` (D24, D26; ver abajo);
- 1 corrección del autor en `margenOrg`: `RSW` → `RCWIE` (D26).

### Correcciones en `pais` (D24, D26)

Errores heredados de las tablas fuente, corregidos en la versión procesada por decisión del autor. La base original (`data/raw/`) los conserva. No afectan ninguna figura, porque `pais` no se grafica.

| Reuniones (`id_reunion`) | Ciudad | País en la base original | País en la versión procesada |
|---|---|---|---|
| 310, 324, 327, 328, 329, 330, 331 | East London | Gran Bretaña | Sudáfrica |
| 204 | Hyderabad | Pakistán | India |
| 321 | Gauteng | China | Sudáfrica |
| 95 | La Haya | "Píses Bajos" (errata) | Países Bajos |
| 262 | Singapore | Singapore (en inglés) | Singapur (D26) |

---

## 2. Capacidades militares, 1980–2015

**Fuente:** National Material Capabilities (NMC), versión 6.0, del proyecto Correlates of War (ver `docs/fuentes.md`).

**Unidad de análisis:** país-año.

### 2.1 Extracto de NMC

**Archivo:** `data/raw/militar/NMC-60-abridged_extracto_G7_BRICS_1980-2015.csv`.

- Filas del archivo original de NMC v6.0 (abridged), copiadas sin modificar, para 13 códigos de país y 1980–2015 (433 filas).
- Códigos incluidos: `USA`, `CAN`, `UKG`, `FRN`, `JPN`, `ITA`, `GMY` (Alemania, desde 1990), `GFR` (Alemania Occidental, 1955–1990), `BRA`, `RUS`, `IND`, `CHN`, `SAF`.
- Variables según el codebook de NMC v6.0 (`NMC_Documentation_v6_0`). Los faltantes se codifican `-9`; no hay ninguno en el extracto.

| Variable | Descripción (NMC v6.0) | Unidad |
|---|---|---|
| `stateabb` | Abreviatura del país (COW) | — |
| `ccode` | Código numérico del país (COW) | — |
| `year` | Año | — |
| `milex` | Gasto militar | Miles de USD corrientes (desde 1914) |
| `milper` | Personal militar | Miles de personas |
| `irst` | Producción de hierro y acero | Miles de toneladas |
| `pec` | Consumo de energía primaria | Miles de toneladas equivalentes de carbón |
| `tpop` | Población total | Miles de personas |
| `upop` | Población urbana | Miles de personas |
| `cinc` | Composite Index of National Capability: promedio de la participación del país en el total mundial de los seis indicadores anteriores | Proporción, entre 0 y 1 |
| `version` | Versión del conjunto de datos | `2021` |

### 2.2 Series por país

**Archivos:**
- `data/processed/militar/series_paises_1980_2015_tesis.csv` (422 filas): mismos países que la tesis; Alemania sólo desde 1990.
- `data/processed/militar/series_paises_1980_2015_corregida.csv` (432 filas): incluye Alemania Occidental 1980–1989 (D8).

Variables:
- `stateabb`: en la versión corregida, Alemania Occidental figura como `GMY` para formar una serie continua.
- `stateabb_nmc`: sólo en la versión corregida; conserva el código original de NMC (`GFR` o `GMY`).
- `ccode`, `year`, `milex`, `cinc`: como en 2.1.

### 2.3 Indicadores relativos a EEUU (EEUU = 100), cada 5 años

| Versión | Gasto militar | CINC |
|---|---|---|
| **Tesis** (usada en la Fig. 3.13) | `data/raw/militar/gasto_militar_comparado.csv` | `data/raw/militar/cinc_index_comparado.csv` |
| **Corregida** (D3, D8) | `data/processed/militar/gasto_militar_comparado_corregida.csv` | `data/processed/militar/cinc_index_comparado_corregida.csv` |

| Variable | Descripción |
|---|---|
| `paises` | `EEUU`; los 6 países del G7 sin EEUU (`GMY`, `UKG`, `FRN`, `CAN`, `ITA`, `JPN`); los 5 del BRICS (`BRA`, `RUS`, `IND`, `CHN`, `SAF`); y los agregados `G7 (sin EEUU)` y `BRICS` |
| `year` | 1980, 1985, …, 2015 |
| `gastoMilitar` / `cinc` | Índice = valor del país (o suma de los valores del grupo) ÷ valor de EEUU × 100. Por definición, EEUU = 100 |

Diferencias entre versiones (detalle en `docs/decisiones.md`, D3 y D8):

- **Versión tesis:**
  - el CINC de EEUU de 1980 se transcribió con el valor de 1981;
  - Alemania 1980 y 1985 = 0;
  - el CINC está truncado y el gasto redondeado a 2 decimales;
  - 3 celdas de gasto difieren del cálculo por errores de transcripción.
- **Versión corregida:** CINC de EEUU de 1980 correcto, Alemania Occidental en 1980 y 1985, valores redondeados a 2 decimales.

**Archivo de verificación:** `data/processed/militar/verificacion_version_tesis.csv` compara celda por celda la versión tesis con el cálculo desde NMC.

| Variable | Descripción |
|---|---|
| `indicador` | `gasto_militar` o `cinc` |
| `paises`, `year` | Unidad y año |
| `csv_tesis` | Valor en el CSV original de la tesis |
| `reconstruido` | Valor calculado desde NMC con las reglas de la versión tesis |
| `corregido` | Valor de la versión corregida |
| `coincide_tesis` | `TRUE` si `csv_tesis` es igual a `reconstruido` |
| `dif_corregida` | `corregido` − `csv_tesis` |

---

## 3. Votaciones en la Asamblea General de la ONU

**Fuente:** datos de Voeten, Strezhnev y Bailey distribuidos en el paquete de R `unvotes` (versión 0.3.0). Ver `docs/fuentes.md`.

**Archivo:** `data/processed/agnu/votos_brics_pais_anio_tema.csv`. Lo genera `scripts/03_agnu/01_votaciones.R`.

**Unidad de análisis:** país × año × tema. Incluye sólo las combinaciones con más de 5 votaciones nominales.

| Variable | Tipo | Descripción |
|---|---|---|
| `country` | texto | País, con el nombre de `unvotes`: `Brazil`, `China`, `India`, `Russia`, `South Africa`. Para "Russia", ver `docs/metodologia.md` |
| `year` | entero | Año de la votación. Cobertura 1946–2019 con `unvotes` 0.3.0 |
| `issue` | texto | Tema asignado a la votación en `unvotes` (6 temas): Arms control and disarmament; Colonialism; Economic development; Human rights; Nuclear weapons and nuclear material; Palestinian conflict |
| `votes` | entero | Cantidad de votaciones nominales del país en ese año y tema (siempre > 5) |
| `percent_yes` | decimal | Proporción de votos "sí" sobre los votos emitidos |
| `percent_no` | decimal | Proporción de votos "no" |
| `percent_abstain` | decimal | Proporción de abstenciones |

Las tres proporciones suman 1. `unvotes` no registra ausencias ni no participación: sólo votos sí, no y abstención. Una votación con varios temas cuenta en cada uno de ellos.
