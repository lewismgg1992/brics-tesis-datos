# Methodology

[Versión en español](../metodologia.md) · **English**

This document explains how each dataset was built and processed. It draws on three sources, indicated in each case:

- **Thesis:** the methodological appendix of the thesis (ch. 9) and its chapters 3 and 5.
- **Reconstructed:** what was reconstructed by examining the original data and code (stages 1, 2 and 4 of the preparation of this repository).
- **Repository:** the technical changes introduced for publication.

Decisions and discrepancies are recorded in `docs/decisiones.md` (Spanish), identified as D*n*, A*n* or P*n*.

## Context

The data support the case study of the doctoral thesis *Cooperando entre emergentes: el BRICS como caso de estudio* (Guerrero, 2024). Using process tracing, the thesis reconstructs the causal mechanism linking actors, institutions and cooperation in the institutionalization of BRICS cooperative dynamics (2001–2020). The three datasets provide evidence on three aspects:

1. **The institutional diversification of the BRICS** (meetings). This is central evidence on its deliberation spaces.
2. **The material capabilities of its members** (military capabilities). They provide evidence on the endogenous factors of the case.
3. **The convergence of their positions in the UN General Assembly** (votes). This is evidence of cooperation on the international agenda.

---

## 1. BRICS meetings (2006–2022)

### 1.1 Data collection (thesis, Appendix 9.2)

Earlier systematizations (BRICS Parma, BRICS Information Centre, Stuenkel 2015, Fontenele Reis 2012) missed meetings, especially at levels 3 and 4. The author therefore built his own record, meeting by meeting, from the following sources.

**Primary sources:**
- news, documents and statements from the foreign ministries of the five countries;
- press releases on informal meetings held on the sidelines of other international meetings (G20, IMF/World Bank, etc.);
- joint statements and documents from formal meetings, especially the Action Plans of the annual summits;
- the press (The BRICS Post, BRICS Information Portal and others).

**Secondary sources:**
- BRICS Parma (Università di Parma), 2006–2019;
- BRICS Information Centre (University of Toronto), 2006–2020;
- Stuenkel (2015), 2006–2014;
- Fontenele Reis (2012), 2006–2011.

**Recovering sources that went offline.** Sources no longer online were retrieved through the Wayback Machine (Internet Archive) or from copies on other official websites. Examples: the website of the 2017 Xiamen summit and the pre-2016 website of Itamaraty (Brazil's foreign ministry). For 2015, the *BRICS Handover Report* of the Russian presidency was key.

**Source record.** For 2006–2019, each meeting has its source (link or bibliographic reference) in the author's tables by level. For 2020–2022, the database was completed without updating that record (D4). See "Limitations".

### 1.2 Coding (thesis, Appendix 9.2; reconstructed)

**Level.** Four levels according to the participating actors (ch. 5):
1. summits of heads of state and government;
2. ministerial meetings;
3. technical-bureaucratic meetings;
4. people-to-people meetings (social and non-governmental actors).

Level 1 also includes informal meetings of leaders on the sidelines of the G8/G20.

**Type.**
- *Informal:* a meeting held on the sidelines of, or within, another international meeting, organization or forum. The host organization is recorded in `margenOrg`.
- *Formal:* a meeting coordinated and held within the BRICS itself.
- There is one exception confirmed by the author: São Paulo, 2008 (D11).

**Thematic area and sub-area.**
- The areas follow the fifteen areas of the ministerial meetings. Finance and trade are grouped into a single "economy" area.
- Four areas are added: social, government, infrastructure and organization. They cover meetings that did not fit the previous areas but shared common features.
- Each area has sub-areas. `general` identifies cross-cutting meetings or meetings with a broad scope.
- Because the economic area is so diversified, economic meetings have an additional subdivision (`subarea_economica`, Table 9.2 of the thesis).
- The categories were recorded in English in the database. Their correspondence with the (Spanish) thesis categories is in `docs/correspondencia_areas.csv`, and the note on Table 9.1 is in `docs/en/data_dictionary.md` (D13).

**Pro tempore presidency (reconstructed).** Each meeting is assigned the presidency of the host of the annual summit of the same calendar year, even if the meeting took place after that summit (303 meetings in 2009–2022). The rule is documented as it stands in the database (D10, D18).

**Format (reconstructed).** In person, virtual or hybrid. The author verified it meeting by meeting, including before 2020 (D9). The thesis does not describe this variable; note 11 of chapter 5 mentions the effect of the pandemic.

**Reclassifications (reconstructed).** At least 6 meetings have a different level in the database than in the source tables. For example, the 2015 meetings of youth ministers were moved from level 3 to level 2. The database prevails, as it is the author's definitive version (D1).

### 1.3 Processing (repository)

`scripts/01_reuniones/01_preparar_base.R` reads the original database without modifying it, checks its integrity (md5) and produces the processed database as CSV. The changes are limited to:

- leading or trailing spaces in text, which `read_excel()` already removed in the original analysis;
- 3 months written in English;
- 3 sub-areas with inconsistent spelling;
- one correction to `margenOrg` approved by the author (D11);
- 11 country corrections and one acronym correction approved by the author (D24, D26).

Every modified cell is listed in `registro_cambios.csv`. None of the changes alters the counts shown in the figures.

`scripts/01_reuniones/02_figuras.R` reproduces the original charts with the same code. Technical changes are documented in `docs/cambios_tecnicos.md` (Spanish).

---

## 2. Military capabilities (G7 and BRICS, 1980–2015)

### 2.1 Source and indicators (thesis, Appendix 9.1)

The thesis uses the National Material Capabilities (NMC) v6.0 dataset of the Correlates of War project, because of the length of its series and its CINC index (Composite Index of National Capability).

The CINC averages, with equal weights, a state's share of the world total of six components: total population, urban population, iron and steel production, primary energy consumption, military expenditure and military personnel. It ranges from 0 to 1.

The BRICS and G7 countries are compared between 1980 and 2015, on both military expenditure and CINC.

### 2.2 Country series (Figs. 3.11 and 3.12)

These are the annual NMC values of `milex` and `cinc` for the 12 countries, untransformed.

**Reconstructed:**
- The original filter uses the code `GMY`, which in NMC refers to unified Germany from 1990 onwards. That is why (West) Germany does not appear in 1980–1989.
- `milex` is measured in thousands of current US dollars. The original axis labels `milex` / 10⁶ with an "M", so the values are in fact billions of current US dollars, not millions of 2021 dollars as the caption of Fig. 3.11 states.

**Repository:** two versions are published.
- **Thesis:** identical to the original.
- **Corrected:** adds West Germany (`GFR`) for 1980–1989 (D8). In the expenditure chart, the axis is labeled "miles de millones de USD corrientes" (billions of current US dollars) (D22).

### 2.3 Indicators relative to the United States (Fig. 3.13)

**Reconstructed:**
- For each five-year point (1980, 1985, …, 2015), the index is the value of the country, or the sum of the values of the group, divided by the value of the United States and multiplied by 100.
- The groups are "G7 (sin EEUU)" (G7 excluding the US: Germany, the United Kingdom, France, Canada, Italy and Japan) and "BRICS".
- The calculation was done by hand in a spreadsheet (`data/raw/militar/00_capabilities_militares.ods`) and the results were copied into two CSV files.
- Reconstructing it from NMC revealed:
  - the 1980 US CINC transcribed with the 1981 value;
  - Germany recorded as 0 in 1980 and 1985;
  - the CINC truncated and the expenditure rounded to 2 decimals;
  - 3 expenditure cells with transcription errors.

**Repository:**
- **Thesis version:** the original CSV files, unchanged. `scripts/02_militar/02_relativo_eeuu.R` checks them cell by cell against NMC (221 of 224 cells match).
- **Corrected version:** calculated from NMC by script (D3, D8).
- **Effect of the correction:** in 1980, the CINC of the G7 excluding the US rises from 97.60 to 125.58, and that of the BRICS from 268.50 to 278.37. In 1980 and 1985, the expenditure of the G7 excluding the US rises once West Germany is included: from 53.09 to 71.63 in 1980.

---

## 3. UN General Assembly votes

### 3.1 Source (thesis, Appendix 9.1)

The thesis uses Voeten's roll-call voting data for the General Assembly, distributed in the R package `unvotes`. According to the caption of Fig. 5.8, the procedure follows the "methodology of Voeten (2013)". See the clarification in 3.2.

### 3.2 Procedure (reconstructed from the code)

1. Brazil, Russia, India, China and South Africa are selected (names as in `unvotes`).
2. Votes are joined with the data on each roll call (date) and with its issue classification (6 issues). Only roll calls with an assigned issue are included. A roll call with several issues counts once in each.
3. For each country, year and issue, the share of yes, no and abstention votes over votes cast is computed. `unvotes` does not record absences or non-participation.
4. Only combinations with **more than 5 roll calls** are kept.
5. The annual points and a LOESS curve per country are plotted, with the default parameters of `geom_smooth()`.

**Clarifications:**
- The procedure consists of simple proportions by issue. It does not compute ideal points or agreement indices, which are other analyses developed by Voeten. The reference to Voeten (2013) refers to the source of the data.
- The threshold of more than 5 roll calls and the LOESS smoothing are not described in the thesis.
- With `unvotes` 0.3.0, the data cover 1946–2019; the caption of Fig. 5.8 says 1946–2020.
- In `unvotes`, the "Russia" series includes the votes of the Soviet Union before 1991.

### 3.3 Repository

`scripts/03_agnu/01_votaciones.R` reproduces the original code and exports the summary table behind the figures (`votos_brics_pais_anio_tema.csv`). The vote-level data are not redistributed (D15). Results depend on the `unvotes` version; the version used in 2023 and in the reproduction is 0.3.0 (D5).

---

## Limitations

1. **Sources for 2020–2022.** The 530 meetings of this period have no individual source recorded (D4).
2. **Online sources.** Some of the 2006–2019 sources are links that may stop working. Some were already broken when the author collected the data and were retrieved by other means.
3. **Uncertainty marks.** The source tables mark with "?" information that could not be verified. In the database those cells were left empty, so the distinction between "missing" and "unverified" is preserved only in the source tables (2006–2019).
4. **Differences with the text of the thesis.** The database has 1,313 meetings in 2009–2022; chapter 5 mentions 1,314. Table 9.1 has a shifted row (D13).
5. **Software environment.** The thesis was processed with the 2023 versions of R and packages, which were not recorded exactly (D5). The reproduction uses current versions (D19). The data are reproduced exactly; the figures, approximately in their appearance (see `docs/figuras.md`, Spanish).
6. **Style of the military figures.** The four military figures in the thesis have a white background, a style not present in the preserved code. The gray background produced by the code is kept (A3, D21).
7. **Economic material.** The GDP, Gini and GNI data (ch. 3, Fig. 5.2a) are not included in this version (D2).
