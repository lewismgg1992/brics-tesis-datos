# Cambios técnicos respecto de los scripts originales

Los scripts originales se conservan sin modificar en `scripts/originales/`. Este documento enumera cada diferencia entre ellos y los scripts adaptados (`scripts/01_reuniones`, `02_militar`, `03_agnu`) e indica si puede alterar un resultado.

En los scripts adaptados, cada cambio está marcado en el código con `[CAMBIO]`.

**Principio:** el código que construye cada gráfico se conserva tal como estaba (datos, variables, colores, etiquetas, tamaños y parámetros de `ggsave`). Los cambios son técnicos: rutas, orden de ejecución, llamadas interactivas y paquetes sin uso.

## Cambios comunes a todos los scripts

| Cambio | Motivo | ¿Altera resultados? |
|---|---|---|
| Rutas relativas a la raíz del repositorio. Todos los scripts comprueban que se ejecutan desde allí | Los originales suponían tres proyectos de RStudio distintos | No |
| Se eliminan `View()` / `view()` | Llamadas interactivas; detienen la ejecución por lotes | No |
| Las figuras se guardan en `outputs/figuras/regeneradas/` | Ubicación previsible y separada de las figuras de la tesis | No |
| Se instala `ragg`; `ggsave()` lo usa automáticamente para los PNG (D20) | En la computadora de prueba, el dispositivo Cairo no encontraba las fuentes y el texto salía como recuadros | No: cambia sólo cómo se dibujan el texto y las líneas |
| Se cargan sólo los paquetes usados (`ggplot2`, `dplyr`, `tidyr`, `readr`, `forcats`, `tibble`, más los específicos de cada script) en lugar de `library(tidyverse)` (D19) | `tidyverse` instala unos 80 paquetes. Una descarga fallida de uno sin uso (`dbplyr`) impedía configurar el entorno | No: son las mismas funciones |

## Conjunto 1 — Reuniones

**`01_preparar_base.R` (nuevo).** Convierte el `.xls` en CSV y registra cada celda modificada en `data/processed/reuniones/registro_cambios.csv` (230 celdas, verificado con un cálculo independiente):

- 211 espacios sobrantes al inicio o al final de un texto, en las variables `nombre`, `mes` y `subarea_economica`.
  - **No altera resultados.** `read_excel()` ya los eliminaba en silencio en los scripts originales (`trim_ws = TRUE` por defecto). Ahora la limpieza queda registrada.
- 3 meses escritos `june` → `junio`.
  - **No altera resultados.** La variable no se grafica.
- 3 subáreas: `agua` → `water`, `International-organizations` → `international-organizations` e `International-security` → `international-security`.
  - **No altera resultados.** `subarea` no se grafica.
- Hokkaido 2008: `margenOrg` G20 → G8 (decisión D11).
  - **No altera resultados.** La variable no se grafica.
- 10 países mal asignados o mal escritos (decisión D24): East London ×7 y Gauteng 2018 (`id_reunion` 321) → Sudáfrica; Hyderabad 2019 → India; "Píses Bajos" → Países Bajos.
  - **No altera resultados.** `pais` no se grafica.
- Reunión 262: país `Singapore` → `Singapur` (D26). **No altera resultados.**
- Reunión 287 (Sochi, 2018): `margenOrg` `RSW` → `RCWIE`, la sigla usada para el mismo foro en 2015 (D26). **No altera resultados:** `margenOrg` no se grafica.
- Se agrega `id_reunion`, que identifica cada reunión por su posición en el archivo original.

**`02_figuras.R` (reúne `01_grafico_barras.R`, `02_Grafico_ministerios.R` y `04_graficos_areas.R`)**

| Cambio | Motivo | ¿Altera resultados? |
|---|---|---|
| Lee la base procesada en lugar del `.xls` | Una sola fuente de datos para todas las figuras | No: las variables graficadas son idénticas |
| Se omite `reuniones_totales_niveles.png` | Decisión D17: imagen repetida, no usada en la tesis | No genera esa figura |
| Se omiten dos gráficos exploratorios de `02_Grafico_ministerios.R` que no se guardaban | No producían salidas | No |
| En `04_graficos_areas.R`, el subconjunto `area == "economy"` se toma **antes** de traducir `area` al español | En el original el filtro se aplicaba después y dejaba el subconjunto vacío al ejecutarlo de corrido (aclaración A1) | No: reproduce `areas_economicas.png`, verificada contra los conteos de la base |
| Se omiten `library(plyr)`, `library(car)` y la variable `formalidad` | No intervenían en ningún gráfico. Cargar `plyr` después de `dplyr` enmascara `summarize()` y, al reunir los tres scripts en uno, alteraría los conteos | No (evita un riesgo) |

**Se conservan sin corregir, por fidelidad a la tesis:**

- La leyenda "Nivel reuniones" del gráfico de formato.
- Las etiquetas de los ejes en los gráficos con `coord_flip()`.

## Conjunto 2 — Capacidades militares

**`01_series_paises.R` (adapta `capabilities_militares.R` y `gastos_militares.R`)**

| Cambio | Motivo | ¿Altera resultados? |
|---|---|---|
| Lee el extracto publicado de NMC v6.0 (433 filas, copiadas sin modificar del archivo original) | Decisión D15: sólo se redistribuye el extracto usado | No: contiene todas las filas que usan los gráficos |
| El código de cada gráfico pasa a una función que se aplica a cada versión | Generar la versión tesis y la corregida con el mismo código | La versión **tesis** no cambia |
| Versión corregida: Alemania Occidental (`GFR`) 1980–1989 como serie `GMY` | Decisión D8 | Sólo en los archivos `_corregida` |

**`02_relativo_eeuu.R` (nuevo; reemplaza el cálculo manual de la planilla)**

- La **versión tesis** son los CSV originales, sin cambios. El script los compara celda por celda con un cálculo desde NMC que aplica las reglas de la planilla:
  - CINC de EEUU 1980 = valor de 1981;
  - Alemania 1980–85 = 0;
  - CINC truncado y gasto redondeado.
- Resultado esperado: 221 de 224 celdas coinciden. Las 3 restantes son valores de gasto militar transcriptos a mano con otro valor:
  - Japón 2015: 6,84 en lugar de 6,86;
  - Italia 1985: 3,55 en lugar de 3,50;
  - China 2000: 13,85 en lugar de 13,86.
- La **versión corregida** se calcula desde NMC, redondeada a 2 decimales (D3, D8).
  - Cambia sobre todo el agregado del G7 en 1980 y 1985, al incorporar Alemania Occidental.
  - Ejemplo: CINC del G7 sin EEUU en 1980 = 125,58, frente a 97,60 en la tesis.

**`03_figuras_relativo_eeuu.R` (adapta `GM_comparado.R` y `cinc_index_comparado.R`)**

- Mismo código de los originales, encapsulado en funciones y aplicado a cada versión.
- La versión tesis lee los CSV originales: no altera resultados.

**Rótulo del gasto militar (D22):** la versión tesis conserva el rótulo original "M". En `GastoMilitar_paises_corregida.png`, el eje se rotula "Gasto militar (miles de millones de USD corrientes)", sin el sufijo "M". Mismos valores; cambia sólo el rótulo.

## Conjunto 3 — AGNU

**`01_votaciones.R` (adapta `votaciones_comparadas.R`)**

| Cambio | Motivo | ¿Altera resultados? |
|---|---|---|
| Se eliminan las tres llamadas `view()` | Interactivas | No |
| Advertencia si `unvotes` no está en la versión 0.3.0 | La versión determina los datos (D5) | No |
| `relationship = "many-to-many"` en los tres `inner_join` con `un_roll_call_issues` | Las versiones actuales de `dplyr` avisan porque una votación puede tener varios temas. Es el mismo comportamiento del original: la votación cuenta en cada tema | No: sólo declara la relación y suprime el aviso |
| Se exporta `votos_brics_pais_anio_tema.csv`, la unión de las tres tablas que ya calculaba el script | Decisión D15: publicar la tabla resumida | No |

**Se conserva:** la línea `mutate(issue == "Nuclear weapons" …)`, que no tiene efecto. Está documentada en el script.

## Estado de la verificación

- **Réplica independiente.** Los valores esperados de las comprobaciones (`tests/verificar_reproduccion.R`) se calcularon primero con una réplica independiente en Python, sobre los mismos archivos brutos.
- **Ejecución en R.** El 16/10/2026, el autor ejecutó `run_all.R` completo en R 4.6.1 / Ubuntu 24.04, con el entorno registrado en `renv.lock`. Las 28 comprobaciones se cumplen (informado por el autor). Una segunda ejecución, con el código definitivo, produjo datos idénticos byte a byte.
- **Datos y figuras publicados.** Los archivos de `data/processed/` y `outputs/figuras/regeneradas/` son los de esa ejecución. La base procesada de reuniones se contrastó con el `.xls` original: cada celda coincide, salvo las 230 registradas en `registro_cambios.csv`.
- **Comparación con la tesis.** El resultado de comparar las figuras regeneradas con las de la tesis está en `docs/figuras.md`.
