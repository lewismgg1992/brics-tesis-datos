#Paquetes
library(tidyverse)
library(unvotes)
library(lubridate)
library(ggthemes)

view(un_votes)
view(un_roll_calls)
view(un_roll_call_issues)

#Votos por el SÍ

p_votos_brics <- un_votes %>%
  filter(country %in% c("China", "Brazil", "India", "South Africa", "Russia")) %>%
  inner_join(un_roll_calls, by = "rcid") %>%
  inner_join(un_roll_call_issues, by = "rcid") %>%
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

#Guardar el gráfico como PNG
ggsave(filename = "votaciones_comparadas.png", plot = p, device = "png", width = 10, height = 6)

#Votos por el NO
p_votosNO_brics <- un_votes %>%
  filter(country %in% c("China", "Brazil", "India", "South Africa", "Russia")) %>%
  inner_join(un_roll_calls, by = "rcid") %>%
  inner_join(un_roll_call_issues, by = "rcid") %>%
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

#Guardar el gráfico como PNG
ggsave(filename = "votaciones_NEGATIVAS_comparadas.png", plot = p2, device = "png", width = 10, height = 6)

#Votos por la abstención
p_votosABSTENCION_brics <- un_votes %>%
  filter(country %in% c("China", "Brazil", "India", "South Africa", "Russia")) %>%
  inner_join(un_roll_calls, by = "rcid") %>%
  inner_join(un_roll_call_issues, by = "rcid") %>%
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

#Guardar el gráfico como PNG
ggsave(filename = "votaciones_ABSTENCIONES_comparadas.png", plot = p3, device = "png", width = 10, height = 6)
