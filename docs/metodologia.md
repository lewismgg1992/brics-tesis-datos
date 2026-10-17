# Metodología

Este documento explica cómo se construyó y procesó cada conjunto de datos. Se basa en tres fuentes, que se indican en cada caso:

- **Tesis:** el Anexo metodológico de la tesis (cap. 9) y sus capítulos 3 y 5.
- **Reconstruido:** lo que se reconstruyó al examinar los datos y el código originales (etapas 1, 2 y 4 de la preparación de este repositorio).
- **Repositorio:** los cambios técnicos introducidos para publicar.

Las decisiones y discrepancias se registran en `docs/decisiones.md` (identificadas como D*n*, A*n* o P*n*).

## Contexto

Los datos sostienen el estudio de caso de la tesis doctoral *Cooperando entre emergentes: el BRICS como caso de estudio* (Guerrero, 2024). La tesis reconstruye, mediante *process tracing*, el mecanismo causal que vincula actores, instituciones y cooperación en la institucionalización de las dinámicas cooperativas del BRICS (2001–2020). Los tres conjuntos aportan evidencia sobre tres aspectos:

1. **La diversificación institucional del BRICS** (reuniones). Es evidencia central sobre los espacios de deliberación.
2. **Las capacidades materiales de sus miembros** (capacidades militares). Aportan evidencia sobre los factores endógenos del caso.
3. **La convergencia de sus posiciones en la Asamblea General de la ONU** (votaciones). Es evidencia sobre la cooperación en la agenda internacional.

---

## 1. Reuniones del BRICS (2006–2022)

### 1.1 Relevamiento (tesis, Anexo 9.2)

Las sistematizaciones previas (BRICS Parma, BRICS Information Centre, Stuenkel 2015, Fontenele Reis 2012) omitían reuniones, sobre todo de los niveles 3 y 4. Por eso el autor construyó un registro propio, reunión por reunión, a partir de las siguientes fuentes.

**Fuentes primarias:**
- noticias, documentos y comunicados de las cancillerías de los cinco países;
- comunicados de prensa de reuniones informales realizadas al margen de otras reuniones internacionales (G20, FMI/BM, etc.);
- comunicados y documentos conjuntos de reuniones formales, en especial los Planes de Acción de las cumbres anuales;
- prensa (The BRICS Post, BRICS Information Portal y otros).

**Fuentes secundarias:**
- BRICS Parma (Università di Parma), 2006–2019;
- BRICS Information Centre (University of Toronto), 2006–2020;
- Stuenkel (2015), 2006–2014;
- Fontenele Reis (2012), 2006–2011.

**Recuperación de fuentes caídas.** Las fuentes que ya no estaban en línea se recuperaron con Wayback Machine (Internet Archive) o mediante copias en otros sitios oficiales. Ejemplos: el sitio de la cumbre de Xiamen 2017 y el sitio de Itamaraty anterior a 2016. Para 2015 fue clave el *BRICS Handover Report* de la presidencia rusa.

**Registro de fuentes.** Para 2006–2019, cada reunión tiene su fuente (enlace o referencia bibliográfica) en las tablas por nivel del autor. Para 2020–2022, la base se completó sin actualizar ese registro (D4). Ver "Limitaciones".

### 1.2 Codificación (tesis, Anexo 9.2; reconstruido)

**Nivel.** Cuatro niveles según los actores participantes (cap. 5):
1. cumbres de jefes de Estado y de Gobierno;
2. reuniones ministeriales;
3. reuniones técnico-burocráticas;
4. reuniones *people-to-people* (actores sociales y no gubernamentales).

El nivel 1 incluye también los encuentros informales de líderes al margen del G8/G20.

**Tipo.**
- *Informal:* reunión realizada al margen o en el marco de otra reunión, organización o foro internacional. La organización marco se registra en `margenOrg`.
- *Formal:* reunión coordinada y realizada en el seno del BRICS.
- Hay una excepción confirmada por el autor: São Paulo, 2008 (D11).

**Área y subárea temática.**
- Las áreas toman como guía las quince áreas de las reuniones ministeriales. Finanzas y comercio se agrupan en un área "economía".
- Se agregan cuatro áreas: social, gobierno, infraestructura y organización. Responden a reuniones que no encajaban en las anteriores pero compartían rasgos comunes.
- Cada área tiene subáreas. `general` identifica reuniones transversales o de alcance amplio.
- Por la diversificación del área económica, las reuniones económicas tienen además una subdivisión propia (`subarea_economica`, Tabla 9.2 de la tesis).
- Las categorías se registraron en inglés en la base. Su correspondencia con la tesis está en `docs/correspondencia_areas.csv`, y la nota sobre la Tabla 9.1 en `docs/diccionario_datos.md` (D13).

**Presidencia pro tempore (reconstruido).** Cada reunión lleva la presidencia del anfitrión de la cumbre anual de su mismo año calendario, también si se realizó después de esa cumbre (303 reuniones en 2009–2022). La regla se documenta tal como está en la base (D10, D18).

**Formato (reconstruido).** Presencial, virtual o híbrido. El autor lo verificó reunión por reunión, también antes de 2020 (D9). La tesis no describe esta variable; la nota 11 del cap. 5 menciona el efecto de la pandemia.

**Reclasificaciones (reconstruido).** Al menos 6 reuniones tienen en la base un nivel distinto del de las tablas fuente. Por ejemplo, las reuniones de ministros de juventud de 2015 pasaron del nivel 3 al 2. Prevalece la base, que es la versión definitiva del autor (D1).

### 1.3 Procesamiento (repositorio)

`scripts/01_reuniones/01_preparar_base.R` lee la base original sin modificarla, verifica su integridad (md5) y produce la base procesada en CSV. Los cambios se limitan a:

- espacios sobrantes en textos, que `read_excel()` ya eliminaba en el análisis original;
- 3 meses escritos en inglés;
- 3 subáreas con escritura inconsistente;
- una corrección aprobada por el autor en `margenOrg` (D11);
- 11 correcciones de país y una de sigla aprobadas por el autor (D24, D26).

Cada celda modificada queda en `registro_cambios.csv`. Ningún cambio altera los conteos de las figuras.

`scripts/01_reuniones/02_figuras.R` reproduce los gráficos originales con el mismo código. Los cambios técnicos están documentados en `docs/cambios_tecnicos.md`.

---

## 2. Capacidades militares (G7 y BRICS, 1980–2015)

### 2.1 Fuente e indicadores (tesis, Anexo 9.1)

Se usa la base National Material Capabilities (NMC) v6.0 del proyecto Correlates of War, por la extensión de sus series y por el índice CINC (*Composite Index of National Capability*).

El CINC promedia, con igual ponderación, la participación de un Estado en el total mundial de seis componentes: población total, población urbana, producción de hierro y acero, consumo de energía primaria, gasto militar y personal militar. Varía entre 0 y 1.

Se comparan los países del BRICS con los del G7 entre 1980 y 2015, tanto en gasto militar como en CINC.

### 2.2 Series por país (Figs. 3.11 y 3.12)

Son los valores anuales de `milex` y `cinc` de NMC para los 12 países, sin transformación.

**Reconstruido:**
- El filtro original usa el código `GMY`, que en NMC corresponde a la Alemania unificada desde 1990. Por eso Alemania (Occidental) no aparece en 1980–1989.
- `milex` está en miles de USD corrientes. El eje original rotula "M" sobre `milex` / 10⁶, de modo que los valores son en realidad miles de millones de USD corrientes, no millones de dólares de 2021, como dice el epígrafe de la Fig. 3.11.

**Repositorio:** se publican dos versiones.
- **Tesis:** idéntica al original.
- **Corregida:** agrega Alemania Occidental (`GFR`) para 1980–1989 (D8). En el gráfico de gasto, rotula el eje como "miles de millones de USD corrientes" (D22).

### 2.3 Indicadores relativos a EEUU (Fig. 3.13)

**Reconstruido:**
- Para cada año quinquenal (1980, 1985, …, 2015), el índice es el valor del país, o la suma de los valores del grupo, dividido por el valor de EEUU y multiplicado por 100.
- Los grupos son "G7 (sin EEUU)" (Alemania, Reino Unido, Francia, Canadá, Italia y Japón) y "BRICS".
- El cálculo se hizo a mano en una planilla (`data/raw/militar/00_capabilities_militares.ods`) y los resultados se copiaron a dos CSV.
- Al reconstruirlo desde NMC se identificaron:
  - el CINC de EEUU de 1980 transcripto con el valor de 1981;
  - Alemania 1980 y 1985 registrada como 0;
  - el CINC truncado y el gasto redondeado a 2 decimales;
  - 3 celdas de gasto con errores de transcripción.

**Repositorio:**
- **Versión tesis:** los CSV originales, sin cambios. `scripts/02_militar/02_relativo_eeuu.R` los verifica celda por celda contra NMC (221 de 224 celdas coinciden).
- **Versión corregida:** calculada desde NMC por script (D3, D8).
- **Efecto de la corrección:** en 1980, el CINC del G7 sin EEUU pasa de 97,60 a 125,58 y el del BRICS de 268,50 a 278,37. En 1980 y 1985 el gasto del G7 sin EEUU sube al incorporar Alemania Occidental: de 53,09 a 71,63 en 1980.

---

## 3. Votaciones en la Asamblea General de la ONU

### 3.1 Fuente (tesis, Anexo 9.1)

Se usa la base de votaciones nominales de la Asamblea General de Voeten, distribuida en el paquete de R `unvotes`. Según el epígrafe de la Fig. 5.8, el procedimiento sigue la "metodología de Voeten (2013)". Ver la aclaración en 3.2.

### 3.2 Procedimiento (reconstruido del código)

1. Se seleccionan Brasil, Rusia, India, China y Sudáfrica (nombres de `unvotes`).
2. Se unen los votos con los datos de cada votación (fecha) y con su clasificación temática (6 temas). Sólo entran las votaciones con tema asignado. Una votación con varios temas cuenta una vez en cada uno.
3. Para cada país, año y tema se calcula la proporción de votos sí, no y abstención sobre los votos emitidos. `unvotes` no registra ausencias ni no participación.
4. Se conservan las combinaciones con **más de 5 votaciones**.
5. Se grafican los puntos anuales y una curva LOESS por país, con los parámetros por defecto de `geom_smooth()`.

**Aclaraciones:**
- El procedimiento consiste en proporciones simples por tema. No calcula puntos ideales ni índices de acuerdo, que son otros análisis desarrollados por Voeten. La referencia a Voeten (2013) corresponde a la fuente de los datos.
- El umbral de más de 5 votaciones y el suavizado LOESS no se describen en la tesis.
- Con `unvotes` 0.3.0, los datos cubren 1946–2019; el epígrafe de la Fig. 5.8 indica 1946–2020.
- En `unvotes`, la serie "Russia" incluye los votos de la Unión Soviética antes de 1991.

### 3.3 Repositorio

`scripts/03_agnu/01_votaciones.R` reproduce el código original y exporta la tabla resumida que sostiene las figuras (`votos_brics_pais_anio_tema.csv`). No se redistribuye la base de votos (D15). Los resultados dependen de la versión de `unvotes`; la usada en 2023 y en la reproducción es la 0.3.0 (D5).

---

## Limitaciones

1. **Fuentes de 2020–2022.** Las 530 reuniones de ese período no tienen registrada su fuente individual (D4).
2. **Fuentes en línea.** Parte de las fuentes de 2006–2019 son enlaces que pueden dejar de funcionar. Algunos ya no funcionaban cuando el autor hizo el relevamiento y se recuperaron por vías alternativas.
3. **Marcas de incertidumbre.** Las tablas fuente marcan con "?" la información que no pudo verificarse. En la base, esas celdas quedaron vacías, así que la distinción entre "dato faltante" y "dato no verificado" sólo se conserva en las tablas fuente (2006–2019).
4. **Diferencias con el texto de la tesis.** La base tiene 1.313 reuniones en 2009–2022; el cap. 5 menciona 1.314. La Tabla 9.1 tiene una fila desplazada (D13).
5. **Entorno de software.** La tesis se procesó con las versiones de R y paquetes de 2023, sin registro exacto (D5). La reproducción usa versiones actuales (D19). Los datos se reproducen de forma exacta; las figuras, de forma aproximada en su aspecto (ver `docs/figuras.md`).
6. **Estilo de las figuras militares.** Las cuatro figuras militares de la tesis tienen fondo blanco, un estilo que no está en el código conservado. Se mantiene el fondo gris que produce el código (A3, D21).
7. **Material económico.** Los datos de PIB, Gini e INB (cap. 3, Fig. 5.2a) no se incluyen en esta versión (D2).
