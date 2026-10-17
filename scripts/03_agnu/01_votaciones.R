# =============================================================================
# Conjunto 3 · Votaciones del BRICS en la Asamblea General de la ONU
# 01_votaciones.R
#
# Adaptación de votaciones_comparadas.R (Fig. 5.8 a-c).
# Datos: paquete 'unvotes' (Voeten), versión 0.3.0. No se redistribuyen los
# datos de votos; se publica la tabla resumida que sostiene las figuras.
#
# Procedimiento original (sin cambios):
#   - países: Brasil, Rusia, India, China y Sudáfrica (nombres de unvotes);
#   - une votos, votaciones (roll calls) y temas por 'rcid' (inner_join): sólo
#     entran las votaciones con tema asignado, y una votación con varios temas
#     cuenta una vez en cada tema;
#   - proporción de votos Sí / No / Abstención por país, año y tema, sobre los
#     votos emitidos (un_votes no registra ausencias);
#   - se conservan las combinaciones con más de 5 votaciones;
#   - curvas LOESS con los parámetros por defecto de geom_smooth().
#
# Salidas: data/processed/agnu/votos_brics_pais_anio_tema.csv
#          outputs/figuras/regeneradas/votaciones_{comparadas,NEGATIVAS_comparadas,ABSTENCIONES_comparadas}.png
# =============================================================================

# [CAMBIO] Se cargan sólo los paquetes usados en lugar de library(tidyverse) (D19).
library(ggplot2)
library(dplyr)
library(readr)
library(unvotes)
library(lubridate)
library(ggthemes)

stopifnot("Ejecutar desde la raíz del repositorio" = file.exists("brics-tesis-datos.Rproj"))

if (packageVersion("unvotes") != "0.3.0") {
  warning("Se esperaba unvotes 0.3.0 (versión de 2023). Con otra versión los datos ",
          "y las figuras pueden diferir. Versión instalada: ", packageVersion("unvotes"))
}

salida_fig  <- "outputs/figuras/regeneradas"
salida_dato <- "data/processed/agnu"
dir.create(salida_fig,  recursive = TRUE, showWarnings = FALSE)
dir.create(salida_dato, recursive = TRUE, showWarnings = FALSE)

# [CAMBIO] Se eliminan las llamadas interactivas view(un_votes), view(un_roll_calls)
# y view(un_roll_call_issues).

# Nota: la línea mutate(issue = if_else(issue == "Nuclear weapons", ...)) del
# original no modifica ningún valor (reemplaza "Nuclear weapons" por sí mismo; en
# unvotes 0.3.0 el tema se llama "Nuclear weapons and nuclear material"). Se conserva
# para mantener el código idéntico.

# [CAMBIO] En los tres inner_join con un_roll_call_issues se declara
# relationship = "many-to-many". Las versiones actuales de dplyr emiten un aviso
# porque una votación puede tener varios temas (y cuenta en cada uno), igual que
# en el script original. Declararlo explícitamente no cambia el resultado.

# --- Votos por el SÍ (Fig. 5.8a) -------------------------------------------------
p_votos_brics <- un_votes %>%
  filter(country %in% c("China", "Brazil", "India", "South Africa", "Russia")) %>%
  inner_join(un_roll_calls, by = "rcid") %>%
  inner_join(un_roll_call_issues, by = "rcid", relationship = "many-to-many") %>%
  mutate(issue = if_else(issue == "Nuclear weapons",
                         "Nuclear weapons", issue)) %>%
  group_by(country, year = year(date), issue) %>%
  summarize(votes = n(),
            percent_yes = mean(vote == "yes")) %>%
  filter(votes > 5)

p <- ggplot(p_votos_brics,
       mapping = aes(x = year, y = percent_yes, color = country)) +
  geom_point(size = 0) +
  geom_smooth(method = "loess", se = F, linetype = "solid") +
  facet_wrap(~ issue, ncol = 2) +
  labs(x = "Año", y = "% Sí", color = "País")

p <- p + theme_economist()

ggsave(filename = file.path(salida_fig, "votaciones_comparadas.png"), plot = p, device = "png", width = 10, height = 6)

# --- Votos por el NO (Fig. 5.8b) -------------------------------------------------
p_votosNO_brics <- un_votes %>%
  filter(country %in% c("China", "Brazil", "India", "South Africa", "Russia")) %>%
  inner_join(un_roll_calls, by = "rcid") %>%
  inner_join(un_roll_call_issues, by = "rcid", relationship = "many-to-many") %>%
  mutate(issue = if_else(issue == "Nuclear weapons",
                         "Nuclear weapons", issue)) %>%
  group_by(country, year = year(date), issue) %>%
  summarize(votes = n(),
            percent_no = mean(vote == "no")) %>%
  filter(votes > 5)

p2 <- ggplot(p_votosNO_brics,
            mapping = aes(x = year, y = percent_no, color = country)) +
  geom_point(size = 0) +
  geom_smooth(method = "loess", se = F, linetype = "solid") +
  facet_wrap(~ issue, ncol = 2) +
  labs(x = "Año", y = "% No", color = "País")

p2 <- p2 + theme_economist()

ggsave(filename = file.path(salida_fig, "votaciones_NEGATIVAS_comparadas.png"), plot = p2, device = "png", width = 10, height = 6)

# --- Votos por la ABSTENCIÓN (Fig. 5.8c) -----------------------------------------
p_votosABSTENCION_brics <- un_votes %>%
  filter(country %in% c("China", "Brazil", "India", "South Africa", "Russia")) %>%
  inner_join(un_roll_calls, by = "rcid") %>%
  inner_join(un_roll_call_issues, by = "rcid", relationship = "many-to-many") %>%
  mutate(issue = if_else(issue == "Nuclear weapons",
                         "Nuclear weapons", issue)) %>%
  group_by(country, year = year(date), issue) %>%
  summarize(votes = n(),
            percent_abstain = mean(vote == "abstain")) %>%
  filter(votes > 5)

p3 <- ggplot(p_votosABSTENCION_brics,
             mapping = aes(x = year, y = percent_abstain, color = country)) +
  geom_point(size = 0) +
  geom_smooth(method = "loess", se = F, linetype = "solid") +
  facet_wrap(~ issue, ncol = 2) +
  labs(x = "Año", y = "% Abstención", color = "País")

p3 <- p3 + theme_economist()

ggsave(filename = file.path(salida_fig, "votaciones_ABSTENCIONES_comparadas.png"), plot = p3, device = "png", width = 10, height = 6)

# --- [CAMBIO] Tabla resumida publicada (nueva; no existía en el original) ----------
# Une las tres tablas anteriores. 'votes' es el mismo en las tres porque se calcula
# sobre el mismo agrupamiento.
resumen <- p_votos_brics %>%
  inner_join(p_votosNO_brics,          by = c("country", "year", "issue", "votes")) %>%
  inner_join(p_votosABSTENCION_brics,  by = c("country", "year", "issue", "votes")) %>%
  ungroup() %>%
  arrange(country, issue, year)

stopifnot(nrow(resumen) == nrow(p_votos_brics),
          all(abs(resumen$percent_yes + resumen$percent_no + resumen$percent_abstain - 1) < 1e-9))

write_csv(resumen, file.path(salida_dato, "votos_brics_pais_anio_tema.csv"))

message("Figuras 5.8a-c y tabla resumida generadas. Años cubiertos: ",
        min(resumen$year), "-", max(resumen$year))
