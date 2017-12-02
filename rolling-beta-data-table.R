library(data.table)

n <- 250 * 20
data <- data.table(date = 1:n, ret = rnorm(n), mret = rnorm(n))

output <- data[, rbindlist(lapply(250:n, function(i) {
  selector <- (i - 249):i
  coef <- coef(lm.fit(cbind(1, mret[selector]), ret[selector]))
  list(date = date[[i]], alpha = coef[[1]], beta = coef[[2]])
}))]
