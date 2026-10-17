# Fuentes

Fuentes de los datos de cada conjunto, condiciones de acceso y forma de citarlas. Los enlaces se verificaron el 13/10/2026, salvo que se indique otra fecha.

## 1. Reuniones del BRICS (datos propios del autor)

La base fue construida por el autor a partir de fuentes primarias y secundarias (ver `docs/metodologia.md`, 1.1).

**Fuentes de cada reunión, 2006–2019.** Las tablas por nivel del autor registran la fuente de cada reunión: un enlace web o una referencia bibliográfica con página. Las reuniones de 2020–2022 no tienen registro de fuente individual (D4).

Las tablas están en `data/raw/reuniones/fuentes/`, en formato `.odt` y en PDF. El archivo `LEEME.md` de esa carpeta describe cada una e indica el único cambio respecto del original: en la lista de fuentes se quitó una nota de trabajo del autor (D28).

### Fuentes secundarias principales (según la tesis)

- BRICS Information Centre, University of Toronto. http://www.brics.utoronto.ca/ — Período consultado: 2006–2020.
- BRICS Parma, Università di Parma (2023). http://www.brics.unipr.it/ — Período consultado: 2006–2019.
- Stuenkel, O. (2015). *The BRICS and the Future of Global Order*. New York: Lexington Books. — Período consultado: 2006–2014.
- Fontenele Reis, M. (2012). BRICS: surgimiento y evolución. En *Mesa Redonda: o Brasil, os BRICS e a Agenda Internacional*. Brasília: FUNAG. — Período consultado: 2006–2011.

### Fuentes primarias frecuentes (según la lista de fuentes del autor)

**Documentos oficiales del BRICS.**
- Planes de Acción de las cumbres: Ufa 2015, Goa 2016, Xiamen 2017, Johannesburgo 2018, Brasilia 2019 y Moscú 2020. Disponibles en el BRICS Information Centre.
- *BRICS Handover Report 2015–2016* (presidencia rusa). http://www.brics.unipr.it/wordpress/wp-content/uploads/2014/10/The-BRICS-Handover-Report-2015-2016.pdf

**Sitios de las presidencias pro tempore.**
- Brasil 2014, recuperado mediante Internet Archive.
- Rusia 2015 (en.brics2015.ru).
- India 2016 (brics2016.gov.in).
- Brasil 2019 (brics2019.itamaraty.gov.br).

**Cancillerías y gobiernos.**
- Ministerio de Relaciones Exteriores de la India (mea.gov.in) y Press Information Bureau.
- Ministerio de Relaciones Exteriores de China (fmprc.gov.cn).
- Gobierno de Sudáfrica (gov.za).
- Otros organismos nacionales.

**Instituciones del BRICS y afines.**
- New Development Bank.
- BRICS Trade Union Forum.
- BRICS Network University.
- BRICS Astronomy Working Group.
- National Committee on BRICS Research (Rusia).

**Prensa.**
- The BRICS Post.
- BRICS Information Portal (infobrics.org).
- Xinhua, IOL y otros.

**Bibliografía académica.**
- Cutrera (2020).
- Sharma (2018).
- Kornegay y Bohler-Muller (2013).

Muchos sitios oficiales ya no están en línea. El autor recuperó parte de la información mediante Internet Archive (Wayback Machine) o copias en otros sitios oficiales.

**Condiciones de uso:** datos propios del autor, publicados bajo CC BY 4.0 (`LICENSE-data`).

## 2. Capacidades militares — National Material Capabilities (NMC) v6.0

- **Productor:** Correlates of War Project.
- **Acceso:** https://correlatesofwar.org/data-sets/national-material-capabilities
  - La versión 6.0 sigue disponible para descarga (`NMC_Documentation 6.0.zip`).
  - Archivo usado: `NMC-60-abridged.csv` (versión 6.0, variable `version = 2021`).
- **Documentación:** Greig, J. M. y Enterline, A. J. (2021). *National Material Capabilities (NMC) Data Documentation, Version 6.0*. Correlates of War Project.
- **Condiciones de uso:** la página del proyecto no declara una licencia. Pide indicar la versión usada y citar los artículos de referencia:
  - Singer, J. D., Bremer, S. y Stuckey, J. (1972). Capability Distribution, Uncertainty, and Major Power War, 1820–1965. En B. Russett (ed.), *Peace, War, and Numbers* (pp. 19–48). Beverly Hills: Sage.
  - Singer, J. D. (1987). Reconstructing the Correlates of War Dataset on Material Capabilities of States, 1816–1985. *International Interactions*, 14(1), 115–132.
- **En este repositorio:** se redistribuye sólo el extracto usado (13 códigos de país, 1980–2015), sin modificaciones y con la cita requerida (D15).

## 3. Votaciones en la Asamblea General de la ONU

- **Datos:**
  - Voeten, E., Strezhnev, A. y Bailey, M. *United Nations General Assembly Voting Data*. Harvard Dataverse. https://doi.org/10.7910/DVN/LEJUQZ
  - Voeten, E. (2013). Data and Analyses of Voting in the UN General Assembly. En B. Reinalda (ed.), *Routledge Handbook of International Organization* (cap. 4, pp. 54–66). Routledge.
- **Paquete de R usado:** Robinson, D. (2021). *unvotes: United Nations General Assembly Voting Data* (versión 0.3.0) [paquete de R]. CRAN. https://cran.r-project.org/package=unvotes
  - La tesis lo cita como "Voeten (2023). Paquete unvotes".
  - El mantenedor del paquete es David Robinson; los datos son de Voeten y colaboradores.
- **Condiciones de uso:** el paquete se distribuye bajo licencia MIT.
- **En este repositorio:** no se redistribuye la base de votos. Se obtiene instalando `unvotes` 0.3.0 desde CRAN. Se publica sólo la tabla resumida derivada (país × año × tema) (D15).

## 4. Software

- R Core Team. *R: A Language and Environment for Statistical Computing*. R Foundation for Statistical Computing, Viena. https://www.R-project.org/
- Paquetes principales: `ggplot2`, `dplyr`, `tidyr`, `readr`, `forcats`, `tibble`, `readxl`, `scales`, `lubridate`, `ggthemes`, `unvotes`, `ragg` y `renv`. Las versiones exactas de la reproducción están en `renv.lock`.
