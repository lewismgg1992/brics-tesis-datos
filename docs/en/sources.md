# Sources

[Versión en español](../fuentes.md) · **English**

Data sources for each dataset, access conditions and how to cite them. Links were checked on 13 October 2026 unless another date is given.

## 1. BRICS meetings (the author's own data)

The author built the database from primary and secondary sources (see `docs/en/methodology.md`, 1.1).

**Source of each meeting, 2006–2019.** The author's tables by level record the source of each meeting: a web link or a bibliographic reference with page number. Meetings from 2020–2022 have no individual source recorded (D4).

The tables are in `data/raw/reuniones/fuentes/`, in `.odt` and PDF format (in Spanish). The `LEEME.md` file in that folder describes each table and states the only change made to the originals: a working note by the author was removed from the list of sources (D28).

### Main secondary sources (according to the thesis)

- BRICS Information Centre, University of Toronto. http://www.brics.utoronto.ca/ — Period consulted: 2006–2020.
- BRICS Parma, Università di Parma (2023). http://www.brics.unipr.it/ — Period consulted: 2006–2019.
- Stuenkel, O. (2015). *The BRICS and the Future of Global Order*. New York: Lexington Books. — Period consulted: 2006–2014.
- Fontenele Reis, M. (2012). BRICS: surgimiento y evolución. In *Mesa Redonda: o Brasil, os BRICS e a Agenda Internacional*. Brasília: FUNAG. — Period consulted: 2006–2011.

### Frequent primary sources (according to the author's list of sources)

**Official BRICS documents.**
- Summit Action Plans: Ufa 2015, Goa 2016, Xiamen 2017, Johannesburg 2018, Brasília 2019 and Moscow 2020. Available at the BRICS Information Centre.
- *BRICS Handover Report 2015–2016* (Russian presidency). http://www.brics.unipr.it/wordpress/wp-content/uploads/2014/10/The-BRICS-Handover-Report-2015-2016.pdf

**Websites of the pro tempore presidencies.**
- Brazil 2014, retrieved through the Internet Archive.
- Russia 2015 (en.brics2015.ru).
- India 2016 (brics2016.gov.in).
- Brazil 2019 (brics2019.itamaraty.gov.br).

**Foreign ministries and governments.**
- Ministry of External Affairs of India (mea.gov.in) and Press Information Bureau.
- Ministry of Foreign Affairs of China (fmprc.gov.cn).
- Government of South Africa (gov.za).
- Other national agencies.

**BRICS and related institutions.**
- New Development Bank.
- BRICS Trade Union Forum.
- BRICS Network University.
- BRICS Astronomy Working Group.
- National Committee on BRICS Research (Russia).

**Press.**
- The BRICS Post.
- BRICS Information Portal (infobrics.org).
- Xinhua, IOL and others.

**Academic literature.**
- Cutrera (2020).
- Sharma (2018).
- Kornegay and Bohler-Muller (2013).

Many official websites are no longer online. The author retrieved part of the information through the Internet Archive (Wayback Machine) or from copies on other official websites.

**Terms of use:** the author's own data, published under CC BY 4.0 (`LICENSE-data`).

## 2. Military capabilities — National Material Capabilities (NMC) v6.0

- **Producer:** Correlates of War Project.
- **Access:** https://correlatesofwar.org/data-sets/national-material-capabilities
  - Version 6.0 remains available for download (`NMC_Documentation 6.0.zip`).
  - File used: `NMC-60-abridged.csv` (version 6.0, variable `version = 2021`).
- **Documentation:** Greig, J. M. and Enterline, A. J. (2021). *National Material Capabilities (NMC) Data Documentation, Version 6.0*. Correlates of War Project.
- **Terms of use:** the project page does not state a license. It asks users to indicate the version used and to cite the reference works:
  - Singer, J. D., Bremer, S. and Stuckey, J. (1972). Capability Distribution, Uncertainty, and Major Power War, 1820–1965. In B. Russett (ed.), *Peace, War, and Numbers* (pp. 19–48). Beverly Hills: Sage.
  - Singer, J. D. (1987). Reconstructing the Correlates of War Dataset on Material Capabilities of States, 1816–1985. *International Interactions*, 14(1), 115–132.
- **In this repository:** only the extract used is redistributed (13 country codes, 1980–2015), unmodified and with the required citation (D15).

## 3. UN General Assembly votes

- **Data:**
  - Voeten, E., Strezhnev, A. and Bailey, M. *United Nations General Assembly Voting Data*. Harvard Dataverse. https://doi.org/10.7910/DVN/LEJUQZ
  - Voeten, E. (2013). Data and Analyses of Voting in the UN General Assembly. In B. Reinalda (ed.), *Routledge Handbook of International Organization* (ch. 4, pp. 54–66). Routledge.
- **R package used:** Robinson, D. (2021). *unvotes: United Nations General Assembly Voting Data* (version 0.3.0) [R package]. CRAN. https://cran.r-project.org/package=unvotes
  - The thesis cites it as "Voeten (2023). Paquete unvotes".
  - The package maintainer is David Robinson; the data are by Voeten and colleagues.
- **Terms of use:** the package is distributed under the MIT license.
- **In this repository:** the vote-level data are not redistributed. They are obtained by installing `unvotes` 0.3.0 from CRAN. Only the derived summary table (country × year × issue) is published (D15).

## 4. Software

- R Core Team. *R: A Language and Environment for Statistical Computing*. R Foundation for Statistical Computing, Vienna. https://www.R-project.org/
- Main packages: `ggplot2`, `dplyr`, `tidyr`, `readr`, `forcats`, `tibble`, `readxl`, `scales`, `lubridate`, `ggthemes`, `unvotes`, `ragg` and `renv`. The exact versions used for the reproduction are in `renv.lock`.

---

Codes such as D4 or D15 refer to entries in the decision log, `docs/decisiones.md` (Spanish).
