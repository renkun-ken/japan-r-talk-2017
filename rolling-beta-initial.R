output <- data.frame(date = integer(), alpha = numeric(), beta = numeric())
for (i in 250:n) {
  d <- data[(i - 249):i,]
  m <- lm(ret ~ mret, data = d)
  coef <- coef(m)
  new_row <- data.frame(date = data$date[[i]], alpha = coef[[1]], beta = coef[[2]])
  output <- rbind(output, new_row)
}
