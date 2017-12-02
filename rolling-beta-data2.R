library(data.table)
set.seed(123)
dt <- expand.grid(symbol = 1:100, date = 1:(250 * 20))
setDT(dt, key = c("symbol", "date"))
dt[, ret := rnorm(.N)]
dt[, mret := mean(ret), by = date]
