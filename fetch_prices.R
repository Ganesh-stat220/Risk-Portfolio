library(tidyverse)
library(tidyquant)
library(lubridate)
library(here)

tickers <- c("SPY", "QQQ", "IWM", "IEF", "GLD", "DBC")

start_date <- Sys.Date() - years(5)
end_date <- Sys.Date()

prices <- tq_get(
  tickers, 
  from = start_date,
  to = end_date,
  get = "stock_prices"
) %>%
  select(symbol, date, adjusted) %>%
  arrange(symbol, date)


stopifnot(nrow(prices)>0)
stopifnot(all(c("symbol", "date", "adjusted")%in%
                names(prices)))

dir.create(here("data", "raw"), recursive = TRUE, showWarnings = FALSE)
write.csv(prices, here("data", "raw", "prices_raw.csv"))
saveRDS(prices, here("data", "raw", "prices_raw.rds"))


