set.seed(123)
n <- 250 * 20
data <- data.frame(date = 1:n, ret = rnorm(n), mret = rnorm(n))
