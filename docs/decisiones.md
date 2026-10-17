# Registro de decisiones

Este registro acompaña la preparación del repositorio de datos de la tesis. Cada entrada indica la decisión, quién la tomó, en qué fecha y qué implica para el repositorio. Se incorporará al repositorio como `docs/decisiones.md`.

## 13/10/2026 — Respuestas al diagnóstico de la Etapa 1 (autor)

**D1. Versión definitiva de la base de reuniones.**
La versión definitiva es `Reuniones-Completas-R.xls` (1.321 reuniones, 2006–2022).

- Implicación: `Reuniones-Completas-R.ods` y `Reuniones-Completas-R-combinada-economia.xls` son versiones de trabajo anteriores.
- Ambas se conservarán sólo en la copia inalterada de los materiales.
- No se publicarán como datos del repositorio. *(Pendiente de confirmación por el autor.)*

**D2. Material económico (PIB, Gini, INB).**
Queda fuera del alcance de esta primera versión. Se reserva para un uso posterior.

- Interpretación: no se publica ahora como cuarto conjunto. Se conserva en la copia inalterada para retomarlo en una versión futura.
- Al retomarlo, habrá que resolver un problema ya detectado: `03_grafico_linea.R` usa la columna `año`, que sólo existe en el `.ods`.

**D3. Indicadores militares relativos a EEUU (Fig. 3.13).**
Se publican **dos versiones**, claramente identificadas:

- **(a) Versión de la tesis:** reproduce los valores publicados.
  - Incluye el CINC de EEUU de 1980 transcripto con el valor de 1981.
  - Incluye Alemania 1980–1985 = 0.
- **(b) Versión corregida:** se recalcula desde NMC v6.0.
  - Usa el CINC de EEUU de 1980 correcto (0,133115).
  - El tratamiento de Alemania (GFR/GMY) queda pendiente (ver P2).

Cada archivo y cada figura llevarán en el nombre y en los metadatos cuál se usó en la tesis.

**D4. Fuentes de las reuniones 2020–2022.**
El autor completó la base para 2020–2022 sin actualizar el documento de fuentes. No existe un registro de fuentes por reunión para ese período.

- Implicación: se documentará como limitación conocida.
- Las 530 reuniones de 2020–2022 no son trazables a su fuente individual dentro del repositorio.

**D5. Versiones de software.**
El autor usó las últimas versiones disponibles en 2023 de R, RStudio y `unvotes`, sin registro exacto. Evidencia reunida:

- **`unvotes`:** el archivo de CRAN sólo conserva las versiones 0.1.0 (2016) y 0.2.0 (2017). La 0.3.0 (publicada el 09/03/2021) es la que acompaña los materiales de la tesis y la que CRAN sigue ofreciendo.
  - Conclusión: en 2023 la última versión disponible era la **0.3.0**.
  - Estado: alta confianza; se verificará al ejecutar.
- **R:** la última versión de 2023 pertenece a la serie **4.3.x**. R 4.3.2 se publicó el 31/10/2023.
  - La versión exacta depende del momento del año en que se generaron las figuras.
  - Se usará R 4.3.x para la reproducción y se documentará como aproximación.
- **RStudio:** no afecta los resultados. Se mencionará sin fijar versión.

**D6. Numeración de carpetas.**
La numeración (02, 04, 08, 09) refleja la organización personal del autor y no indica materiales faltantes.

- Implicación: el material recibido se considera completo.
- La estructura del repositorio no necesita respetar esa numeración.

## Aclaraciones

**A1. `areas_economicas.png`.**
La figura es correcta y coincide con los datos. El problema se limita al orden de las líneas de `04_graficos_areas.R`: el filtro por "economy" se aplica después de traducir esa categoría a "economía".

- Propuesta para la Etapa 4: filtrar antes de traducir.
- Este cambio no altera el resultado.

## 13/10/2026 — Cierre de pendientes de la Etapa 1 (autor)

**D7 (cierra P1).** `Reuniones-Completas-R.ods` y `Reuniones-Completas-R-combinada-economia.xls` no se publican como datos. Se conservan sólo en la copia inalterada.

**D8 (cierra P2).** La versión corregida de los indicadores militares usa Alemania Occidental (`GFR`, código COW 260) para 1980–1989 y Alemania unificada (`GMY`, 255) desde 1990. En 1990 coinciden ambos registros y se usa `GMY`, igual que en la tesis.

- La versión de la tesis conserva el tratamiento original: Alemania ausente antes de 1990 en las series anuales y 0 en los agregados de 1980 y 1985.
- Interpretación: el criterio se aplica también a las series anuales corregidas (Figs. 3.11 y 3.12), no sólo a la Fig. 3.13.

## 13/10/2026 — Respuestas a las consultas de la Etapa 2 (autor)

**D9. `formato`.** El autor verificó el formato (presencial, virtual o híbrido) reunión por reunión, también antes de 2020. Se documenta como dato verificado, no como supuesto.

**D10. `presidencia`.** Según el autor, la presidencia pro tempore no se asignó por año calendario, sino siguiendo la alternancia que se produce al terminar cada cumbre anual de jefes de Estado y de Gobierno.

- Ver P5: los datos no coinciden con esa descripción.

**D11. Dos codificaciones de 2008.**
- **Hokkaido (nivel 1):** fue una reunión al margen del **G8**.
  - En la versión procesada se corrige `margenOrg`: G20 → G8.
  - El `.xls` original no se modifica y el cambio queda registrado.
  - No afecta ninguna figura.
- **São Paulo (1st BRICS meeting, finanzas):** se confirma como **informal**, aunque no se realizó al margen de ninguna otra organización.
  - Se documenta como única excepción a la regla formal/informal.
  - No se modifican los datos.

**D12. Fig. 5.2b.** Corresponde a todas las reuniones del BRICS, con cada barra anual dividida en formales e informales (2006–2022). El archivo es `reuniones_totales_tipo.png`.

- La Fig. 5.2a (PIB) pertenece al material económico excluido por D2.

**D13. Diccionario de datos.** Se construye a partir de la base y del Anexo `.odt`. Incluirá una nota sobre el error de la Tabla 9.1 de la tesis (fila "Industria" con las subáreas de Infraestructura; falta "Propiedad intelectual"). La tesis no se modifica.

## 13/10/2026 — Respuestas a las consultas de la Etapa 3 (autor)

**D14. Nombre e idioma.**
- El repositorio se llamará `brics-tesis-datos`.
- La documentación va en español, con un resumen en inglés en el README y en los metadatos de Zenodo.

**D15. Datos de terceros (cierra P4).**
- **NMC:** se incluye sólo el extracto usado (países del G7 y del BRICS, 1980–2015), con la cita requerida por el COW.
  - También se incluye Alemania Occidental (`GFR`), necesaria para la versión corregida (D8).
- **AGNU:** no se copia la base de votos. Se publica la tabla resumida derivada (país × año × tema) y los datos se obtienen del paquete `unvotes`.

**D16. Tesis.** Se cita con su registro en el Repositorio Institucional UNSAM: https://ri.unsam.edu.ar/handle/123456789/2535. El PDF no se incluye.

Metadatos del registro (consultados el 13/10/2026):

| Campo | Valor |
|---|---|
| Autor | Guerrero, Mario Guillermo |
| Título | *Cooperando entre emergentes: el BRICS como caso de estudio* |
| Tipo | Tesis de Doctorado |
| Institución | Universidad Nacional de San Martín, Escuela de Política y Gobierno |
| Directores | Battaglino, Jorge; Aguirre, Julio Leonidas; Trocello, Gloria |
| Año de publicación | 2024 (`dc.date.issued`; la portada dice 2023) |
| Licencia de la tesis | CC BY-NC-ND 4.0 |

**D17. Figuras complementarias.**
- `reuniones_totales_formato.png` y `areas_economicas.png` no se usaron en la tesis. Se publican como **complementarias**.
- `reuniones_totales_niveles.png` (idéntica a `reuniones_totales.png`) no se publica.
  - Su bloque de código se omite en el script adaptado.
  - Se conserva en `scripts/originales/`.

**D18. Presidencia (cierra P5).** Todo queda como está en la base.

- Regla documentada: cada reunión lleva la presidencia del país anfitrión de la cumbre de su mismo año calendario, aunque se haya realizado después de esa cumbre.
- No se agrega ninguna variable alternativa.

## 13/10/2026 — Hallazgo de la Etapa 4 sobre los CSV de la Fig. 3.13

Los dos CSV originales (`gasto_militar_comparado.csv` y `cinc_index_comparado.csv`) se transcribieron a mano desde la planilla, con criterios distintos:

- **CINC:** los valores están **truncados** a 2 decimales. Con los dos errores ya conocidos (CINC de EEUU 1980 = valor de 1981; Alemania 1980–85 = 0), el cálculo desde NMC reproduce las 112 celdas.
- **Gasto militar:** los valores están **redondeados** a 2 decimales. Tres celdas no coinciden con ese criterio:

| País | Año | CSV original | Cálculo desde NMC |
|---|---|---|---|
| Japón | 2015 | 6,84 | 6,86 |
| Italia | 1985 | 3,55 | 3,50 |
| China | 2000 | 13,85 | 13,86 |

Consecuencia para el repositorio:

- La **versión tesis** son los CSV originales tal cual, publicados en `data/raw` y usados sin cambios por las figuras.
- Un script verifica esos CSV contra el cálculo desde NMC y reporta las diferencias.
- La **versión corregida** se calcula desde NMC, con redondeo a 2 decimales.

## 15/10/2026 — Entorno de ejecución (Etapa 4)

**D19. Entorno de R para la reproducción.**

El primer intento de configuración falló en la computadora del autor (R 4.6.1, Ubuntu 24.04):

- Se interrumpió la descarga de `dbplyr`, un paquete que no se usa y que se instalaba como parte de `tidyverse`.
- Además, los paquetes de 2023 deben compilarse en R 4.6 y algunos no compilan en versiones de R tan posteriores.

Decisión técnica:

- La reproducción usa la versión de R instalada y los **paquetes actuales**. `renv.lock` registra las versiones exactas utilizadas.
- El entorno de 2023 (D5) queda documentado como el original, no reconstruible con exactitud.
- Se instalan y cargan sólo los 10 paquetes que usan los scripts, en lugar de `tidyverse` completo.
- Ninguno de los dos cambios altera los datos procesados, porque las funciones usadas son las mismas.
- Pueden variar detalles gráficos de las figuras: tipografía, márgenes o el tema por defecto de ggplot2.
- Se comprobará que `unvotes` siga en la versión 0.3.0, que es la que determina los datos de la AGNU.

## 16/10/2026 — Primera ejecución completa (computadora del autor)

Entorno: R 4.6.1, Ubuntu 24.04, `unvotes` 0.3.0. `run_all.R` se ejecutó completo y las **26 comprobaciones** de `tests/verificar_reproduccion.R` se cumplen:

- Archivos brutos íntegros (md5).
- Base de reuniones: 1.321 filas y totales por nivel, año y tipo.
- Indicadores militares: 221 de 224 celdas de la versión tesis reconstruidas, más los valores esperados de la versión corregida.
- AGNU: 5 países, 6 temas, cobertura 1946–2019.
- 19 figuras generadas.

Problemas detectados:

**R1. Texto ilegible en las figuras regeneradas.** Todos los caracteres aparecen como recuadros con códigos hexadecimales. Es un problema de fuentes del dispositivo gráfico en esa computadora, no de los datos ni del código. Pendiente de diagnóstico (P6).

**A2. Las Figs. 3.13a y 3.13b de la tesis no salen del código conservado.**
- Comparación visual de los datos: las curvas regeneradas coinciden con las de la tesis (Figs. 5.2b y 3.13b, y Fig. 5.8a por forma).
- Las imágenes de la tesis usan fondo blanco (estilo `theme_minimal()`). `GM_comparado.R` y `cinc_index_comparado.R` no definen ningún tema, por lo que producen el fondo gris por defecto.
- 🔶 El tema se habría aplicado en la sesión (por ejemplo, con `theme_set()`) o en una versión del script que no se conservó.
- Pendiente de decisión del autor (P7).

**D20 (resuelve R1). Dispositivo gráfico `ragg`.**

- Diagnóstico en la computadora del autor: Cairo disponible y 810 fuentes instaladas (`fc-match sans` → Noto Sans). Aun así, el dispositivo Cairo no las encuentra a través de Pango.
- Solución: se instala `ragg`, que `ggsave()` usa automáticamente para los PNG cuando está disponible. No se modifica el código de ningún gráfico.
- Se agrega a `configurar_entorno.R` y a las comprobaciones.
- No altera los datos. Puede cambiar el suavizado del texto y de las líneas respecto de las figuras de 2023.

**Resultado de D20 (16/10/2026).**

- En Ubuntu, `ragg` necesitó bibliotecas de sistema para compilarse (`libfontconfig1-dev` y otras); quedaron documentadas en `docs/reproducibilidad.md`.
- Con `ragg` instalado, las 27 comprobaciones se cumplen y el texto de las figuras es legible.
- `reuniones_totales_tipo.png` (Fig. 5.2b) coincide con la figura de la tesis en datos, colores, rótulos y ejes. Sólo cambia la tipografía.

## 16/10/2026 — Etapa 6: comparación de las figuras con la tesis

Se compararon visualmente las 13 figuras de la tesis y las 2 complementarias con sus versiones regeneradas. El detalle está en `docs/figuras.md`.

- **Resultado:** en las 15 figuras coinciden los datos, las categorías, las escalas, los colores y los rótulos. Las diferencias son sólo de forma.
- **Formas de reproducción:**
  - Figuras de reuniones: sólo cambia la tipografía.
  - Figuras de votaciones: cambia el tema `theme_economist`, porque `ggthemes` se actualizó desde 2023.
- **Versiones corregidas:** las 4 figuras muestran a Alemania desde 1980 y los valores esperados.

**A3 (amplía A2).** En la tesis, las **cuatro** figuras militares (3.11, 3.12, 3.13a y 3.13b), no sólo las de la Fig. 3.13, tienen fondo blanco transparente. Ese estilo no está en los scripts conservados.

**D21 (cierra P7).** El autor decide mantener el fondo gris por defecto que produce el código conservado. No se agrega `theme_minimal()`. La diferencia queda documentada en `docs/figuras.md`.

## 16/10/2026 — Etapa 5: documentación (autor)

**D22 (cierra P3). Unidades del gasto militar.**
- **Versión tesis:** conserva el rótulo original ("M").
- **Versión corregida:** el eje se rotula "Gasto militar (miles de millones de USD corrientes)" y se elimina el sufijo "M".
- La discrepancia con el epígrafe de la Fig. 3.11 ("millones de dólares (2021)") se documenta en `docs/metodologia.md`.

**D23. Metadatos y licencias.**

| Campo | Valor |
|---|---|
| Autor | Guerrero, Mario Guillermo |
| ORCID | 0000-0002-2821-6351 |
| Filiación | CONICET-UNSL-CERI/UNCUYO |
| Contacto | marioguillermo.guerrero@fulbrightmail.org |
| Licencia del código | MIT (`LICENSE`) |
| Licencia de los datos y la documentación propios | CC BY 4.0 (`LICENSE-data`) |

- En `CITATION.cff` se declara sólo CC BY 4.0: CFF interpreta varias licencias como alternativas y Zenodo admite una sola por depósito.
- Los datos de terceros conservan sus condiciones de uso.

## 16/10/2026 — Países y siglas (autor)

- **D24. Corrección de países en la versión procesada.** El autor aprueba corregir los cuatro casos, con registro en `registro_cambios.csv` (10 celdas de `pais`). La base original no se modifica.
  - East London (`id_reunion` 310, 324, 327–331): Gran Bretaña → Sudáfrica.
  - Hyderabad 2019 (204): Pakistán → India.
  - Gauteng 2018 (321): China → Sudáfrica.
  - La Haya (95): "Píses Bajos" → Países Bajos.
  - El registro de cambios pasa de 218 a 228 celdas; las comprobaciones automáticas, de 27 a 28.
- **D25. Siglas de `margenOrg` confirmadas:**
  - `AML/CFT`: Anti-Money Laundering and Countering the Financing of Terrorism.
  - `ISSEK`: Institute for Statistical Studies and Economics of Knowledge.
  - `UNICEF`: United Nations Children's Fund.
  - `RSW`: resuelto en D26.
- Subárea de la reunión 324 (18th CGETI): la tabla fuente dice "Finanzas" y la base "general" (resuelto en D27).
- **D26. Más correcciones aprobadas (16/10/2026):**
  - Reunión 287 (Sochi, 2018): `margenOrg` `RSW` → `RCWIE`. Es el mismo foro (Russian Competition Week) que la reunión de 2015.
  - Reunión 262: país `Singapore` → `Singapur`.
  - El registro de cambios pasa a 230 celdas.
- **Hallazgo sobre la reunión 324:** la diferencia no es aislada. Las 29 reuniones del CGETI de la base tienen subárea `general`, mientras que en la tabla fuente casi todas figuran como "Finanzas". Resuelto en D27.
- **D27. CGETI (16/10/2026).** La base se deja como está (`general` en `subarea` y `subarea_economica` para las 29 reuniones del CGETI). La reclasificación respecto de las tablas fuente se documenta en el diccionario de datos (Tabla C).

## 16/10/2026 — Ejecución tras las correcciones D24–D27 (autor)

- El autor ejecutó `run_all.R` y `tests/verificar_reproduccion.R` en su computadora: todas las comprobaciones se cumplen (informado por el autor).
- Cuentas para la Etapa 7: el autor tiene cuenta de GitHub; no tiene cuenta de Zenodo.

## 16/10/2026 — Archivos del autor para la Etapa 7

- **`renv.lock`** generado en la computadora del autor después de instalar `ragg` (R 4.6.1, 53 paquetes, incluidos `ragg` 1.5.2, `systemfonts` 1.3.2, `textshaping` 1.0.5 y `unvotes` 0.3.0). Reemplaza la primera versión, que no incluía `ragg`.
- **D28. Tablas fuente.** Se publican en `data/raw/reuniones/fuentes/` los cinco `.odt` de `00_word_tablas_reuniones/`, con una copia en PDF de cada uno.
  - El archivo suelto `Nivel 4 - BRICS Reuniones actores sociales y no gubernamentales (2006 - 2019).odt` es una versión anterior de `04_Nivel_4_BRICS_2023.odt` y no se publica (confirmado por el autor).
  - En `05_Referencia_fuentes.odt` se quita la sección "Bibliografía a conseguir", que es una nota de trabajo del autor (autorizado por el autor).
  - Los metadatos de los `.odt` no contienen nombre de autor ni rutas personales.
- **Usuario de GitHub:** `lewismgg1992`. Dirección prevista del repositorio: https://github.com/lewismgg1992/brics-tesis-datos (todavía no creado).

- **D29. `01_Anexo.odt` (16/10/2026).** Es una versión anterior del anexo 9.2 de la tesis. Se quita el comentario "Sumar la temática: -infraestructura -organizativa", ya resuelto en la tesis. El resto se publica sin cambios. `LEEME.md` aclara que el texto de referencia es el anexo 9.2 y lista las diferencias (aprobado por el autor).

## 16/10/2026 — Resultados definitivos (autor)

- El autor actualizó `scripts/`, `tests/` y `run_all.R` y volvió a ejecutar todo. Los 8 CSV procesados y 18 de las 19 figuras son idénticos byte a byte a los de la ejecución anterior. Sólo cambia `GastoMilitar_paises_corregida.png`, que ahora tiene el rótulo de D22.
- Esa ejecución se incorpora al repositorio: `data/processed/` y `outputs/figuras/regeneradas/`.

## 16/10/2026 — Publicación en GitHub (autorizada por el autor)

- Commit inicial `e936833` subido a https://github.com/lewismgg1992/brics-tesis-datos, en la rama `main` (92 archivos). Se verificó que la página es pública, que el README se muestra y que GitHub reconoce `CITATION.cff` y las licencias.
- El autor vinculó Zenodo y publicó el release `v1.0.0` (tag sobre `e936833`). El registro de Zenodo se verificó el 16/10/2026 y quedó con fecha 17/10/2026, que es la fecha UTC del release:
  - autor, ORCID, afiliación y licencia CC BY 4.0, correctos;
  - archivo `brics-tesis-datos-v1.0.0.zip` de 7,2 MB.
- **DOI de la versión 1.0.0:** 10.5281/zenodo.23428804.
- **DOI de todas las versiones:** 10.5281/zenodo.23428803. Se verificó que resuelve al registro anterior.
- **`CITATION.cff` y README actualizados** con la versión, la fecha, los DOI, la dirección del repositorio y la insignia.
  - En `references` se corrigió `type: dataset` → `type: data`, el valor válido en CFF 1.2.0.
  - El archivo se validó contra el esquema oficial, sin errores.
  - El archivo depositado en Zenodo para la v1.0.0 conserva la versión anterior de `CITATION.cff`. Es lo esperado: el DOI se asigna después de crear el release.
- **Observación:** Zenodo clasificó el depósito como "Software", porque es el valor por defecto de la integración con GitHub. El autor puede cambiarlo a "Dataset" desde Zenodo sin cambiar el DOI.

## Pendientes

- **P3 (cerrado por D22).** Unidades del gasto militar (miles de USD corrientes, frente al rótulo "M" y "millones (2021)"): documentar la discrepancia y decidir si la versión corregida de la figura cambia el rótulo.
- **P4 (cerrado por D15).** Condiciones de redistribución de NMC (COW) y de los datos de `unvotes`. Lo consultado el 13/10/2026:
  - **COW (NMC):**
    - La página de NMC no declara licencia ni términos de uso.
    - Sólo pide indicar la versión y citar un artículo de referencia (Singer, Bremer y Stuckey 1972; Singer 1987).
    - La versión 6.0 sigue descargable allí (`NMC_Documentation 6.0.zip`).
  - **`unvotes`:**
    - El paquete tiene licencia MIT. Los datos provienen de Voeten (Harvard Dataverse).
    - `un_votes` excluye ausencias y no-membresía: sólo registra Sí, No y Abstención.
    - La licencia de los datos de Voeten en Dataverse todavía no está verificada.
- **P8. Errores de país en la base de reuniones** (heredados de las tablas fuente; `pais` no se grafica).
  - East London (7 reuniones): figura "Gran Bretaña"; corresponde Sudáfrica.
  - Hyderabad 2019: figura "Pakistán"; corresponde India.
  - Gauteng 2018: figura "China"; corresponde Sudáfrica.
  - Errata "Píses Bajos".
  - **Cerrado por D24:** se corrigen en la versión procesada, con registro.
- **P9 (cerrado por D25 y D26).** Siglas de `margenOrg` confirmadas; `RSW` unificada en `RCWIE`.
- **P10. Archivos pendientes del autor:**
  - **Cerrado por D28:** tablas fuente y `renv.lock` incorporados.

