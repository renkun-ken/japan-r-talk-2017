library(parallel)
system.time({
  symbols <- dt[, sort(unique(symbol))]
  output <- mclapply(symbols, function(sym) {
    dt[symbol == sym, {
      rbindlist(lapply(250:.N, function(i) {
        selector <- (i - 249):i
        coef <- coef(lm.fit(cbind(1, mret[selector]), ret[selector]))
        list(date = date[[i]], alpha = coef[[1]], beta = coef[[2]])
      }))
    }, by = symbol]
  }, mc.cores = 8)
  output <- rbindlist(output)
  setkey(output, symbol, date)
})
