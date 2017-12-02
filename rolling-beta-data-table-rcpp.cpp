// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List roll_lm(const IntegerVector& date, const arma::mat& x, const arma::colvec& y, int n) {
  int size = date.size();
  IntegerVector _date(size - n + 1);
  NumericVector alpha(size - n + 1), beta(size - n + 1);
  for (int i = n - 1; i < size; i++) {
    const arma::mat& xi = x.rows(i - n + 1, i);
    const arma::colvec& yi = y.subvec(i - n + 1, i);
    const arma::colvec& coef = solve(xi, yi);
    _date[i - n + 1] = date[i];
    alpha[i - n + 1] = coef[0];
    beta[i - n + 1] = coef[1];
  }
  return List::create(_["date"] = _date, _["alpha"] = alpha, _["beta"] = beta);
}
