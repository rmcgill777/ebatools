#' Evidence-Based Assessment Interpretation
#'
#' Interpret a post-test probability using evidence-based assessment
#' decision thresholds.
#'
#' @param post_probability Numeric value between 0 and 1.
#' @param wait_threshold Threshold below which the condition is considered
#'   unlikely. Default = 0.10.
#' @param treat_threshold Threshold above which the condition is considered
#'   likely. Default = 0.70.
#'
#' @return An object of class "eba_interpretation".
#'
#' @export
eba_interpretation <- function(post_probability,
                               wait_threshold = 0.10,
                               treat_threshold = 0.70) {

  if (!is.numeric(post_probability) ||
      length(post_probability) != 1 ||
      post_probability < 0 ||
      post_probability > 1) {
    stop("post_probability must be between 0 and 1.")
  }

  interpretation <-
    if (post_probability < wait_threshold) {
      "Low probability: Condition likely ruled out. No further assessment recommended unless new information emerges."
    } else if (post_probability < treat_threshold) {
      "Intermediate probability: Additional assessment is recommended before making a treatment decision."
    } else {
      "High probability: Condition likely present. Consider initiating treatment."
    }

  result <- list(
    post_probability = post_probability,
    wait_threshold = wait_threshold,
    treat_threshold = treat_threshold,
    interpretation = interpretation
  )

  class(result) <- "eba_interpretation"

  result
}
