output <- dt[, {
  rbindlist(lapply(250:.N, function(i) {
    selector <- (i - 249):i
    coef <- coef(lm.fit(cbind(1, mret[selector]), ret[selector]))
    list(date = date[[i]], alpha = coef[[1]], beta = coef[[2]])
  }))
}, by = symbol]

