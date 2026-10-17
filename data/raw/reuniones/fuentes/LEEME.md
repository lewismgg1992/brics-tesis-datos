# Tablas fuente de la base de reuniones

Tablas del autor en las que se registró cada reunión del BRICS de 2006–2019, con su fecha, lugar, tipo, organización marco, área, subárea y **fuente** (enlace web o referencia bibliográfica). La base `../Reuniones-Completas-R.xls` se construyó a partir de ellas y la amplía hasta 2022.

Las reuniones de 2020–2022 no tienen registro de fuente individual (ver `docs/metodologia.md`).

| Archivo | Contenido | Estado |
|---|---|---|
| `01_Anexo.odt` | Notas metodológicas sobre la sistematización de las reuniones (2006–2019) y clasificación por áreas temáticas | **Editado:** se quitó un comentario de trabajo ya resuelto en la tesis (D29). El texto no cambia. Ver la sección siguiente |
| `02_Nivel_1-2_2022.odt` | Nivel 1 (cumbres) y nivel 2 (reuniones ministeriales), por área | Original, sin cambios |
| `03_Nivel_3_BRICS_2023.odt` | Nivel 3 (reuniones técnico-burocráticas) | Original, sin cambios |
| `04_Nivel_4_BRICS_2023.odt` | Nivel 4 (actores sociales y no gubernamentales) | Original, sin cambios |
| `05_Referencia_fuentes.odt` | Lista de fuentes institucionales, de prensa y académicas | **Editado:** se quitó la sección inicial "Bibliografía a conseguir", una nota de trabajo del autor (decisión D28). El resto del contenido no cambia |

La carpeta `pdf/` tiene una copia en PDF de cada tabla, para consultarlas sin LibreOffice. Se generaron el 16/10/2026 con LibreOffice en modo de conversión automática: el contenido es el mismo, pero la paginación puede diferir levemente de la del documento original.

## `01_Anexo.odt` y el anexo de la tesis

`01_Anexo.odt` es una **versión anterior** del anexo metodológico. El texto de referencia es la sección 9.2 de la tesis ("Notas metodológicas sobre la sistematización de los espacios de deliberación del BRICS"). Se publica porque contiene dos elementos que la tesis no incluye:

- la explicación del **código de colores** (verde, rojo y amarillo) de las reuniones de ministros de finanzas, necesaria para leer `02_Nivel_1-2_2022.odt`;
- la **tabla de áreas y subáreas** (Tabla Anexo 1) sin el error de la Tabla 9.1 de la tesis (D13).

Diferencias con la sección 9.2 de la tesis:

| | `01_Anexo.odt` | Tesis, sección 9.2 |
|---|---|---|
| Período | 2006–2019 | 2006–2020 en el texto; 2006–2022 en las tablas |
| Referencias internas | "el libro", "capítulo 4" | "la tesis", "capítulo 5" |
| Áreas agregadas a las 15 de las reuniones ministeriales | Social y Gobierno | Social, Gobierno, Infraestructura y Organización |
| Significado de la subárea "general" | No se explica | Problemáticas transversales o de muy amplio alcance temático |
| Código de colores de las reuniones de ministros de finanzas | Incluido | No incluido |
| Párrafo sobre el *BRICS Handover Report* (2015) | Inconcluso (termina en "En relación a") | Completo |
| Tabla de áreas y subáreas | Correcta | Fila "Industria" con las subáreas de Infraestructura; falta "Propiedad intelectual" (D13) |
| Subárea financiera "Impuestos" | Incluida | No incluida |

## Errores conocidos

Las tablas se publican como estaban: no se corrigen. Los errores detectados están corregidos en la base procesada (`data/processed/reuniones/`) y registrados en `registro_cambios.csv`:

- `03_Nivel_3_BRICS_2023.odt` registra "East London (Gran Bretaña)", "Gauteng (China)" y "Hyderabad (Pakistán)". Las tres ciudades corresponden a Sudáfrica, Sudáfrica e India (D24).
- Las subáreas de las reuniones del CGETI difieren entre estas tablas ("Finanzas" o "Comercio") y la base (`general`). Es una reclasificación hecha al construir la base (D27; ver `docs/diccionario_datos.md`, Tabla C).

## Verificación

MD5 de los archivos:

```text
342ae893bf0fc0d70837f860d3321285  01_Anexo.odt
0a13ba34020ecf9b0ba5ac103716bbe2  02_Nivel_1-2_2022.odt
9b1dcf31a6f15a9b16c0624eda41f153  03_Nivel_3_BRICS_2023.odt
341ef68646c4ca4523b403c05755aebe  04_Nivel_4_BRICS_2023.odt
c40c9e6988029973be63adf1def25db0  05_Referencia_fuentes.odt
d68950b5725ef6bc392d065be0e4bd24  05_Referencia_fuentes.odt (versión completa, no publicada)
c7a725fed6449fd7b270af2305df651b  01_Anexo.odt (con el comentario, no publicada)
```
