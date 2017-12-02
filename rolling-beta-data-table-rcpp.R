library(data.table)
Rcpp::sourceCpp("rolling-beta-data-table-rcpp.cpp")
Rcpp::sourceCpp("rolling-beta-data-table-rcpp-openmp.cpp")

system.time(output <- dt[, roll_lm(date, cbind(1, mret), ret, 250), by = symbol])
system.time(output <- dt[, par_roll_lm(date, cbind(1, mret), ret, 250, threads = 8), by = symbol])
