#' Bayesian Updating
#'
#' Calculate post-test probabilities from a pre-test probability and
#' positive/negative likelihood ratios.
#'
#' @param pretest_probability Numeric value between 0 and 1 representing
#'   the pre-test probability.
#' @param lr_positive Positive likelihood ratio.
#' @param lr_negative Negative likelihood ratio.
#'
#' @return An object of class "bayes_update" containing:
#' \describe{
#'   \item{pretest_probability}{Original pre-test probability.}
#'   \item{post_positive}{Post-test probability following a positive test.}
#'   \item{post_negative}{Post-test probability following a negative test.}
#' }
#'
#' @export
bayes_update <- function(pretest_probability,
                         lr_positive,
                         lr_negative) {

  if (!is.numeric(pretest_probability) ||
      length(pretest_probability) != 1 ||
      pretest_probability <= 0 ||
      pretest_probability >= 1) {
    stop("pretest_probability must be a single numeric value between 0 and 1.")
  }

  if (!is.numeric(lr_positive) || lr_positive <= 0) {
    stop("lr_positive must be greater than 0.")
  }

  if (!is.numeric(lr_negative) || lr_negative <= 0) {
    stop("lr_negative must be greater than 0.")
  }

  prob_to_odds <- function(p) p / (1 - p)
  odds_to_prob <- function(o) o / (1 + o)

  pretest_odds <- prob_to_odds(pretest_probability)

  post_positive <- odds_to_prob(pretest_odds * lr_positive)
  post_negative <- odds_to_prob(pretest_odds * lr_negative)

  result <- list(
    pretest_probability = pretest_probability,
    post_positive = post_positive,
    post_negative = post_negative
  )

  class(result) <- "bayes_update"

  result
}
