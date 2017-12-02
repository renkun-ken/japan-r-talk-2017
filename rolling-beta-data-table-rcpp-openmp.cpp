// [[Rcpp::depends(RcppArmadillo)]]
// [[Rcpp::plugins(openmp)]]
#include <omp.h>
#include <RcppArmadillo.h>
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List par_roll_lm(const IntegerVector& date, const arma::mat& x, const arma::colvec& y, int n, int threads) {
  int size = y.size();
  IntegerVector _date(size - n + 1);
  NumericVector alpha(size - n + 1), beta(size - n + 1);
#pragma omp parallel for shared(date, x, y), num_threads(threads)
  for (int i = n - 1; i < size; i++) {
    const arma::mat& xi = x.rows(i - n + 1, i);
    const arma::colvec& yi = y.subvec(i - n + 1, i);
    const arma::colvec& coef = solve(xi, yi);
    INTEGER(_date)[i - n + 1] = date[i];
    REAL(alpha)[i - n + 1] = coef[0];
    REAL(beta)[i - n + 1] = coef[1];
  }
  return List::create(_["date"] = _date, _["alpha"] = alpha, _["beta"] = beta);
}

