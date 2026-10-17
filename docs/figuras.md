# Figuras: correspondencia con la tesis y verificación

Cada figura de la tesis con el script que la genera, el archivo que produce y el resultado de la comparación visual entre la figura publicada (`outputs/figuras/tesis/`) y la regenerada (`outputs/figuras/regeneradas/`).

- **Comparación:** 16/10/2026, regeneración en R 4.6.1 / Ubuntu 24.04, con `ggplot2`, `ggthemes` y `ragg` actuales y `unvotes` 0.3.0.
- **Criterio:** se compararon los datos representados (barras, curvas, categorías, escalas), los colores y los rótulos. No se exige identidad de píxeles: la tipografía y algunos detalles del tema dependen del sistema y de la versión de los paquetes (ver `docs/reproducibilidad.md`).

## Figuras de la tesis

| Fig. | Contenido | Script | Archivo | Datos | Diferencias de forma |
|---|---|---|---|---|---|
| 3.11 | Gasto militar por país, 1980–2015 | `02_militar/01_series_paises.R` | `GastoMilitar_paises.png` | ✅ Coinciden | Tema: la tesis usa fondo blanco transparente; el código conservado genera el fondo gris por defecto (A3). Eje en "M" sobre miles de USD (D22) |
| 3.12 | CINC por país, 1980–2015 | `02_militar/01_series_paises.R` | `CINCIndex_paises.png` | ✅ Coinciden | Tema (A3) |
| 3.13a | Gasto militar grupal relativo a EEUU | `02_militar/03_figuras_relativo_eeuu.R` | `gasto_militar_comparado.png` | ✅ Coinciden | Tema (A3) |
| 3.13b | CINC grupal relativo a EEUU | `02_militar/03_figuras_relativo_eeuu.R` | `cinc_comparado.png` | ✅ Coinciden | Tema (A3) |
| 5.2b | Reuniones por año, formales e informales | `01_reuniones/02_figuras.R` | `reuniones_totales_tipo.png` | ✅ Coinciden | Sólo tipografía |
| 5.3 | Áreas temáticas por presidencia pro tempore | `01_reuniones/02_figuras.R` | `area_presidencias.png` | ✅ Coinciden | Sólo tipografía |
| 5.4 | Reuniones ministeriales por área | `01_reuniones/02_figuras.R` | `reuniones_ministeriales.png` | ✅ Coinciden | Sólo tipografía |
| 5.5a | Reuniones por año, niveles 2–4, por tipo | `01_reuniones/02_figuras.R` | `reuniones_niveles.png` | ✅ Coinciden | Sólo tipografía |
| 5.5b | Áreas temáticas, niveles 2–4, por tipo | `01_reuniones/02_figuras.R` | `reuniones_tematicas_nivel.png` | ✅ Coinciden | Sólo tipografía |
| 5.8a | % de votos Sí en la AGNU, por tema | `03_agnu/01_votaciones.R` | `votaciones_comparadas.png` | ✅ Coinciden | `theme_economist` actualizado: fondo más claro, títulos en negrita, texto más chico |
| 5.8b | % de votos No | `03_agnu/01_votaciones.R` | `votaciones_NEGATIVAS_comparadas.png` | ✅ Coinciden | Ídem |
| 5.8c | % de abstenciones | `03_agnu/01_votaciones.R` | `votaciones_ABSTENCIONES_comparadas.png` | ✅ Coinciden | Ídem |
| 7.1 | Reuniones por área temática, por tipo | `01_reuniones/02_figuras.R` | `reuniones_areas.png` | ✅ Coinciden | Sólo tipografía |

La Fig. 5.2a (crecimiento del PIB) y las Figs. 3.1–3.10 pertenecen al material económico, que está fuera del alcance de esta versión (D2).

## Figuras complementarias (no publicadas en la tesis)

| Contenido | Script | Archivo | Datos |
|---|---|---|---|
| Reuniones por año según formato (presencial, virtual, híbrido) | `01_reuniones/02_figuras.R` | `reuniones_totales_formato.png` | ✅ Coinciden con la figura original del autor. Leyenda original "Nivel reuniones" conservada |
| Reuniones económicas por subárea y tipo | `01_reuniones/02_figuras.R` | `areas_economicas.png` | ✅ Coinciden con la figura original del autor |

## Versión corregida de los indicadores militares (D3, D8)

No tienen equivalente en la tesis. Incorporan el CINC de EEUU de 1980 correcto y Alemania Occidental (GFR) para 1980–1989.

| Contenido | Archivo | Verificación |
|---|---|---|
| Gasto militar por país | `GastoMilitar_paises_corregida.png` | Alemania presente desde 1980. Eje: "miles de millones de USD corrientes" (D22) |
| CINC por país | `CINCIndex_paises_corregida.png` | Alemania presente desde 1980 |
| Gasto militar grupal relativo a EEUU | `gasto_militar_comparado_corregida.png` | G7 (sin EEUU) 1980 = 71,63 (tesis: 53,09) |
| CINC grupal relativo a EEUU | `cinc_comparado_corregida.png` | G7 (sin EEUU) 1980 = 125,58 (tesis: 97,60); BRICS 1980 = 278,37 (tesis: 268,50) |
