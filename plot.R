library(tidyverse)
library(here)

returns <- readRDS(here("data", "processed", "returns_long.rds"))

cum <- returns %>%
  group_by(symbol)%>%
  arrange(date) %>%
  mutate(cum_log = cumsum(ret))%>%
  ungroup()

plot <- ggplot(cum, aes(date, cum_log, color = symbol)) +
  geom_line()+
  labs(title = "Cumulative log returns (sanity check)", x = NULL, y = "Cumulative log return")

dir.create(here("outputs", "figures"), recursive = TRUE, showWarnings = FALSE)
ggsave(here("outputs", "figures", "cum_returns.png"), plot, width = 10, height = 5)

message("Saved: output/figures/cum_returns.png")
plot

