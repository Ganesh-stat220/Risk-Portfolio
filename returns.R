library(tidyverse)
library(tidyquant)
library(lubridate)
library(here)

prices <- readRDS(here("data", "raw", "prices_raw.rds"))

returns <- prices %>%
  group_by(symbol)%>%
  arrange(date) %>%
  mutate(ret = log(adjusted/lag(adjusted))) %>%
  ungroup()%>%
  filter(!is.na(ret))

dir.create(here("data", "processed"), recursive = TRUE, showWarnings = FALSE)
saveRDS(returns, here("data", "processed", "returns_long.rds"))
write.csv(returns, here("data", "processed", "returns_long.csv"))

returns_wide <- returns %>%
  select(date, symbol, ret) %>%
  pivot_wider(names_from = symbol, values_from = ret)%>%
  arrange(date)

saveRDS(returns_wide, here("data", "processed", "returns_wide.rds"))
write.csv(returns_wide, here("data", "processed", "returns_wide.csv"))

message("Saved: data/processed returns (long + wide)")
