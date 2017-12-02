date <- integer(n - 249)
alpha <- numeric(n - 249)
beta <- numeric(n - 249)

for (i in 250:n) {
  selector <- (i - 249):i
  m <- lm.fit(cbind(1, data$mret[selector]), data$ret[selector])
  coef <- coef(m)
  date[[i-249]] <- data$date[[i]]
  alpha[[i-249]] <- coef[[1]]
  beta[[i-249]] <- coef[[2]]
}

output <- data.frame(date, alpha, beta)
