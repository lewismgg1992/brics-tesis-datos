# Data dictionary

[Versión en español](../diccionario_datos.md) · **English**

This document describes the data files published in the repository.

- Variable names are kept exactly as in the author's original files. Many are Spanish words; their meaning is given below.
- Values recorded in Spanish (for example, months, countries or the pro tempore presidency) are kept in Spanish, and their meaning is explained here. Translating them would change the data relative to the thesis.
- Categories coded in English are kept in English. Their correspondence with the Spanish categories of the thesis is in `docs/correspondencia_areas.csv`.

**Contents**

1. [BRICS meetings, 2006–2022](#1-brics-meetings-20062022)
2. [Military capabilities, 1980–2015](#2-military-capabilities-19802015)
3. [UN General Assembly votes](#3-un-general-assembly-votes)

---

## 1. BRICS meetings, 2006–2022

**Main file:** `data/processed/reuniones/reuniones_brics_2006_2022.csv`. Produced by `scripts/01_reuniones/01_preparar_base.R` from `data/raw/reuniones/Reuniones-Completas-R.xls`.

**Unit of analysis:** a meeting (encounter, forum, working group, summit or other body) between actors from the BRICS countries, governmental or not, recorded between 2006 and 2022.

**Size:** 1,321 rows × 16 variables. UTF-8 encoding, comma-separated. Empty cells are missing data.

| Variable | Type | Description | Values / rules |
|---|---|---|---|
| `id_reunion` | integer | Meeting identifier: row position in the author's original file | 1–1321. Added during preparation; links to `registro_cambios.csv` |
| `orgYear` | text | Auxiliary variable of the author | Always `"BRICS"` + year (e.g., `BRICS2015`). Redundant with `year` |
| `nivel` | integer | Level of deliberation, according to the participating actors | `1` summits of heads of state and government (24); `2` ministerial meetings (230); `3` technical-bureaucratic meetings (746); `4` people-to-people meetings (321). Level 1 includes 10 informal leaders' meetings on the sidelines of the G8/G20 |
| `mes` | text | Month in which the meeting started, in Spanish | `enero` (January) … `diciembre` (December). Missing for 109 meetings |
| `dia` | integer | Day on which the meeting started | 1–31. Missing for 223 meetings. For multi-day meetings, the first day |
| `year` | integer | Year of the meeting | 2006–2022 |
| `ciudad` | text | Host city | 130 cities. Missing for 528 meetings, almost all virtual or hybrid meetings of 2020–2022 |
| `pais` | text | Host country, in Spanish | 27 countries (e.g., `Sudáfrica` = South Africa, `Rusia` = Russia, `EEUU` = United States). Missing for 523 meetings. See the corrections at the end of this section |
| `nombre` | text | Name of the meeting as it appears in the source (usually in English) | Free text |
| `tipo` | text | Type of meeting | `formal` (1,168) or `informal` (153). Rule in note 1 |
| `margenOrg` | text | International organization or meeting within which the meeting took place | `BRICS` if held within the BRICS itself (1,169); otherwise, the acronym of the host organization (table A). Missing for 3 meetings |
| `area` | text | Thematic area | 18 values (table B) |
| `subarea` | text | Thematic sub-area within the area | 99 values (100 in the original file: preparation merges `agua` with `water`). See `docs/correspondencia_areas.csv`. `general` = cross-cutting meetings or meetings with a broad thematic scope |
| `subarea_economica` | text | Subdivision of meetings in the economic area | 29 values (table C). Only for `area == "economy"`: filled in for all 371 economic meetings and empty otherwise |
| `formato` | text | Meeting format | `presencial` (in person, 813), `virtual` (442), `hybrid` (34), `no data` (32: no information, all in 2022). Verified by the author meeting by meeting (D9) |
| `presidencia` | text | BRICS pro tempore presidency to which the meeting is attributed | `brasil` (Brazil), `rusia` (Russia), `india`, `china`, `sudafrica` (South Africa). Missing for the 8 meetings of 2006–2008, before the first summit. Rule in note 2 |

**Note 1. Formal / informal rule (Appendix 9.2 of the thesis).**
- **Informal:** a meeting held on the sidelines of, or within, another international meeting, organization or forum (G20, UN General Assembly, IMF/World Bank, etc.).
- **Formal:** a meeting coordinated and held within the BRICS itself, with no host organization.
- In the database, `tipo == "informal"` matches `margenOrg != "BRICS"` for every meeting except one exception confirmed by the author (D11): the first meeting of finance ministers (São Paulo, 7 November 2008). It is informal although it was not held on the sidelines of another organization.

**Note 2. Pro tempore presidency.**
- Each meeting is assigned the presidency of the country that hosted the summit of heads of state and government in the same calendar year, even if the meeting took place after that summit.
- In 2009–2022, 303 meetings took place after the summit of their year and keep the presidency of that summit's host.
- This is how it was recorded in the database and how it is used in Fig. 5.3 (D10, D18).

### Table A. Host organizations (`margenOrg`)

Number of meetings in the processed database in parentheses. Meanings come from the author's source tables (`.odt`); `AML/CFT`, `ISSEK` and `UNICEF` were confirmed by the author on 16 October 2026 (D25). Some acronyms are Spanish (`ONU` = UN, `OMS` = WHO).

| Acronym | Host organization or meeting |
|---|---|
| `G20` (49) | Group of Twenty (summits and meetings of finance ministers and central bank governors) |
| `IMF-WB` (25) | Annual and Spring Meetings of the IMF and the World Bank |
| `ONU` (21) | United Nations (mainly the General Assembly) |
| `OMS` (12) | World Health Organization (World Health Assembly, Executive Board) |
| `FATF` (8) | Financial Action Task Force |
| `UNESCO` (5) | UNESCO |
| `WCO` (4) | World Customs Organization (annual conference) |
| `ILO` (2) | International Labour Organization |
| `IPU` (2) | Inter-Parliamentary Union |
| `WTO` (2) | World Trade Organization (ministerial conferences) |
| `G8` (1) | Group of Eight (Hokkaido, 2008). Corrected from `G20` in the processed version (D11) |
| `AML/CFT` (1) | Anti-Money Laundering and Countering the Financing of Terrorism (Paris, 2015) |
| `CADE` (1) | Administrative Council for Economic Defense (Brazil's competition authority) |
| `ENES` (1) | International Forum on Energy Efficiency and Energy Saving (Moscow, 2015) |
| `GMMFIG` (1) | Global Multistakeholder Meeting on the Future of Internet Governance (São Paulo, 2014) |
| `ICN` (1) | International Competition Network (annual conference) |
| `ILC` (1) | International Labour Conference |
| `ILW` (1) | International Law Week (New York, 2015) |
| `IMSS` (1) | International Meeting of Senior Officials Responsible for Security Issues (Saint Petersburg, 2012) |
| `IPEEC` (1) | International Partnership for Energy Efficiency Cooperation |
| `ISSEK` (1) | Institute for Statistical Studies and Economics of Knowledge, Higher School of Economics (HSE, Moscow), 2020 |
| `NSS` (1) | Nuclear Security Summit (The Hague, 2014) |
| `RCWIE` (2) | Russian Competition Week International Event: annual forum of the Federal Antimonopoly Service of Russia (Moscow, 2015; Sochi, 2018). The 2018 meeting appeared as `RSW` in the original database; it was unified (D26) |
| `UCLH` (1) | 50th Union World Conference on Lung Health (2019) |
| `UNAIDS` (1) | Joint United Nations Programme on HIV/AIDS |
| `UNCAC` (1) | Working Group on Asset Recovery of the UN Convention against Corruption |
| `UNICEF` (1) | United Nations Children's Fund. The source table links this meeting (workshop on human milk banks, 2019) to World Breastfeeding Week |
| `WIPO` (1) | World Intellectual Property Organization |

### Table B. Thematic areas (`area`)

For the full correspondence of sub-areas, see `docs/correspondencia_areas.csv`. Figure labels are in Spanish, as in the thesis.

| Value | Area in the thesis (Spanish / English) | Meetings | Label in the figures |
|---|---|---|---|
| `agriculture` | Agricultura / Agriculture | 35 | agricultura |
| `communication` | Comunicación / Communication | 18 | comunicación |
| `culture` | Cultura / Culture | 52 | cultura |
| `disaster management` | Manejo de desastres / Disaster management | 13 | manejo de desastres |
| `economy` | Economía (finanzas y comercio) / Economy (finance and trade) | 371 | economía |
| `education` | Educación / Education | 67 | educación |
| `energy` | Energía / Energy | 41 | energía |
| `environment` | Ambiente / Environment | 33 | ambiente |
| `foreign` | Exterior / Foreign affairs | 51 | cancilleres |
| `government` | Gobierno / Government | 103 | gobierno |
| `health` | Salud / Health | 72 | salud |
| `industry` | Industria / Industry | 40 | industria |
| `infrastructure` | Infraestructura / Infrastructure | 20 | infraestructura |
| `labour` | Trabajo y Empleo / Labour and employment | 26 | trabajo |
| `organizational` | Organización / Organization | 78 | organización |
| `security-defense` | Seguridad y Defensa / Security and defense | 63 | seguridad-defensa |
| `social` | Social | 78 | social |
| `sti` | Ciencia, tecnología e innovación / Science, technology and innovation | 160 | cyt |

> **Note on Table 9.1 of the thesis (D13).** In Table 9.1 (Appendix 9.2), the "Industria" (industry) row actually lists the sub-areas of Infrastructure (transport, investment, research and cooperation, railways). The "Infraestructura" row and the sub-areas of Industry itself (cooperatives, incubators, SMEs, start-ups, Internet, innovation, industrial safety) are missing. "Propiedad intelectual" (intellectual property; 16 meetings in the STI area) is also missing. The database and the version of the appendix kept by the author (`01_Anexo.odt`) are correct. This dictionary and `docs/correspondencia_areas.csv` follow the database. The thesis is not modified.

### Table C. Economic subdivision (`subarea_economica`)

Grouped by the `subarea` in which it appears in the database (Table 9.2 of the thesis):

- **`subarea == "general"`:** `general`, `digital-economy`, `economic-cooperation`, `economic-research`, `soe` (state-owned enterprises).
- **`subarea == "finance"`:** `general`, `asset` (bonds and assets), `bank`, `cra` (Contingent Reserve Arrangement), `digital-financial-inclusion`, `economic-information`, `international-development-assistance`, `investment`, `ndb` (New Development Bank), `tax`, `trade-exchange`.
- **`subarea == "trade"`:** `general`, `business`, `capacity-building`, `competence` (competition policy), `cooperation`, `customs`, `digital-market`, `e-commerce`, `export-credit`, `fair`, `promotion-agencies`, `quality-standarization`, `service`, `statistics`, `trade-promotion`.

Differences with Table 9.2 of the thesis:
- `export-credit` appears under Finance in the table, but in the database it is under `trade` (7 meetings).
- `tax` (23 meetings) does not appear in Table 9.2, but it does appear in the author's version of the appendix as "Impuestos".

**Reclassification of the CGETI (D27).** The 29 meetings of the Contact Group on Economic and Trade Issues (CGETI) have `subarea == "general"` and `subarea_economica == "general"` in the database:
- In the author's source tables (`.odt`, 2006–2019), almost all of them appear under the sub-area "Finanzas" (finance). The first two (Beijing, December 2011, and New Delhi, March 2012) appear under "Comercio" (trade).
- When building the database, the author reclassified them as `general`. The database is kept as it is, by decision of the author.
- They account for 29 of the 42 economic meetings with `subarea == "general"`. This classification determines the panels of the supplementary figure `areas_economicas.png`.

### Change log

**File:** `data/processed/reuniones/registro_cambios.csv`. One row per cell modified when preparing the database (230 cells). Column names and reasons are in Spanish.

| Variable | Description |
|---|---|
| `id_reunion` | Affected meeting |
| `variable` | Modified variable |
| `valor_original` | Value in the original `.xls` |
| `valor_nuevo` | Value in the processed database |
| `motivo` | Reason for the change |

Recorded reasons:
- 211 leading or trailing spaces;
- 3 months written in English;
- 3 sub-areas spelled inconsistently and unified;
- 1 correction by the author (Hokkaido 2008, G20 → G8);
- 11 corrections by the author to `pais` (D24, D26; see below);
- 1 correction by the author to `margenOrg`: `RSW` → `RCWIE` (D26).

### Corrections to `pais` (D24, D26)

Errors inherited from the source tables, corrected in the processed version by decision of the author. The original database (`data/raw/`) keeps them. They do not affect any figure, because `pais` is not plotted.

| Meetings (`id_reunion`) | City | Country in the original database | Country in the processed version |
|---|---|---|---|
| 310, 324, 327, 328, 329, 330, 331 | East London | Gran Bretaña (Great Britain) | Sudáfrica (South Africa) |
| 204 | Hyderabad | Pakistán (Pakistan) | India |
| 321 | Gauteng | China | Sudáfrica (South Africa) |
| 95 | La Haya (The Hague) | "Píses Bajos" (typo) | Países Bajos (Netherlands) |
| 262 | Singapore | Singapore (in English) | Singapur (Spanish spelling, D26) |

---

## 2. Military capabilities, 1980–2015

**Source:** National Material Capabilities (NMC), version 6.0, of the Correlates of War project (see `docs/en/sources.md`).

**Unit of analysis:** country-year.

### 2.1 NMC extract

**File:** `data/raw/militar/NMC-60-abridged_extracto_G7_BRICS_1980-2015.csv`.

- Rows of the original NMC v6.0 (abridged) file, copied unmodified, for 13 country codes and 1980–2015 (433 rows).
- Codes included: `USA`, `CAN`, `UKG`, `FRN`, `JPN`, `ITA`, `GMY` (Germany, from 1990), `GFR` (West Germany, 1955–1990), `BRA`, `RUS`, `IND`, `CHN`, `SAF`.
- Variables as defined in the NMC v6.0 codebook (`NMC_Documentation_v6_0`). Missing values are coded `-9`; there are none in the extract.

| Variable | Description (NMC v6.0) | Unit |
|---|---|---|
| `stateabb` | Country abbreviation (COW) | — |
| `ccode` | Numeric country code (COW) | — |
| `year` | Year | — |
| `milex` | Military expenditure | Thousands of current US dollars (from 1914) |
| `milper` | Military personnel | Thousands of people |
| `irst` | Iron and steel production | Thousands of tons |
| `pec` | Primary energy consumption | Thousands of coal-ton equivalents |
| `tpop` | Total population | Thousands of people |
| `upop` | Urban population | Thousands of people |
| `cinc` | Composite Index of National Capability: average of the country's share of the world total of the six indicators above | Proportion, between 0 and 1 |
| `version` | Dataset version | `2021` |

### 2.2 Country series

**Files:**
- `data/processed/militar/series_paises_1980_2015_tesis.csv` (422 rows): same countries as the thesis; Germany only from 1990.
- `data/processed/militar/series_paises_1980_2015_corregida.csv` (432 rows): includes West Germany 1980–1989 (D8).

Variables:
- `stateabb`: in the corrected version, West Germany appears as `GMY` to form a continuous series.
- `stateabb_nmc`: corrected version only; keeps the original NMC code (`GFR` or `GMY`).
- `ccode`, `year`, `milex`, `cinc`: as in 2.1.

### 2.3 Indicators relative to the United States (US = 100), every 5 years

| Version | Military expenditure | CINC |
|---|---|---|
| **Thesis** (used in Fig. 3.13) | `data/raw/militar/gasto_militar_comparado.csv` | `data/raw/militar/cinc_index_comparado.csv` |
| **Corrected** (D3, D8) | `data/processed/militar/gasto_militar_comparado_corregida.csv` | `data/processed/militar/cinc_index_comparado_corregida.csv` |

| Variable | Description |
|---|---|
| `paises` | Countries: `EEUU` (United States); the 6 G7 countries other than the US (`GMY`, `UKG`, `FRN`, `CAN`, `ITA`, `JPN`); the 5 BRICS (`BRA`, `RUS`, `IND`, `CHN`, `SAF`); and the aggregates `G7 (sin EEUU)` (G7 excluding the US) and `BRICS` |
| `year` | 1980, 1985, …, 2015 |
| `gastoMilitar` / `cinc` | Military expenditure / CINC index = value of the country (or sum of the group's values) ÷ US value × 100. By definition, US = 100 |

Differences between versions (details in `docs/decisiones.md`, Spanish, D3 and D8):

- **Thesis version:**
  - the 1980 US CINC was transcribed with the 1981 value;
  - Germany = 0 in 1980 and 1985;
  - the CINC is truncated and the expenditure rounded to 2 decimals;
  - 3 expenditure cells differ from the calculation because of transcription errors.
- **Corrected version:** correct 1980 US CINC, West Germany included in 1980 and 1985, values rounded to 2 decimals.

**Verification file:** `data/processed/militar/verificacion_version_tesis.csv` compares the thesis version cell by cell with the calculation from NMC.

| Variable | Description |
|---|---|
| `indicador` | Indicator: `gasto_militar` (military expenditure) or `cinc` |
| `paises`, `year` | Unit and year |
| `csv_tesis` | Value in the original thesis CSV |
| `reconstruido` | Value calculated from NMC with the rules of the thesis version |
| `corregido` | Value in the corrected version |
| `coincide_tesis` | `TRUE` if `csv_tesis` equals `reconstruido` |
| `dif_corregida` | `corregido` − `csv_tesis` |

---

## 3. UN General Assembly votes

**Source:** data by Voeten, Strezhnev and Bailey distributed in the R package `unvotes` (version 0.3.0). See `docs/en/sources.md`.

**File:** `data/processed/agnu/votos_brics_pais_anio_tema.csv`. Produced by `scripts/03_agnu/01_votaciones.R`.

**Unit of analysis:** country × year × issue. Includes only combinations with more than 5 roll-call votes.

| Variable | Type | Description |
|---|---|---|
| `country` | text | Country, as named in `unvotes`: `Brazil`, `China`, `India`, `Russia`, `South Africa`. For "Russia", see `docs/en/methodology.md` |
| `year` | integer | Year of the vote. Coverage 1946–2019 with `unvotes` 0.3.0 |
| `issue` | text | Issue assigned to the roll call in `unvotes` (6 issues): Arms control and disarmament; Colonialism; Economic development; Human rights; Nuclear weapons and nuclear material; Palestinian conflict |
| `votes` | integer | Number of roll-call votes cast by the country in that year and issue (always > 5) |
| `percent_yes` | decimal | Share of "yes" votes over votes cast |
| `percent_no` | decimal | Share of "no" votes |
| `percent_abstain` | decimal | Share of abstentions |

The three shares add up to 1. `unvotes` does not record absences or non-participation: only yes, no and abstention votes. A roll call with several issues counts in each of them.

---

Codes such as D11 or D24 refer to entries in the decision log, `docs/decisiones.md` (Spanish).
