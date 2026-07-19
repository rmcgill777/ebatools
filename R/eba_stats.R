#' Evidence-Based Assessment Statistics
#'
#' Calculate evidence-based assessment statistics from a 2 × 2 contingency table.
#'
#' @param tp Number of true positives.
#' @param fp Number of false positives.
#' @param fn Number of false negatives.
#' @param tn Number of true negatives.
#'
#' @return An object of class `"eba_stats"`.
#'
#' @examples
#' eba_stats(
#'   tp = 50,
#'   fp = 10,
#'   fn = 5,
#'   tn = 100
#' )
#'
#' @export

eba_stats <- function(tp, fp, fn, tn) {

  #-----------------------------
  # Basic input validation
  #-----------------------------

  counts <- c(tp, fp, fn, tn)

  if (any(is.na(counts)))
    stop("Counts cannot contain NA values.")

  if (any(counts < 0))
    stop("Counts must be non-negative.")

  if (any(counts != floor(counts)))
    stop("Counts must be whole numbers.")

  eps <- .Machine$double.eps

  #-----------------------------
  # Core statistics
  #-----------------------------

  sensitivity <- tp / (tp + fn + eps)

  specificity <- tn / (tn + fp + eps)

  ppv <- tp / (tp + fp + eps)

  npv <- tn / (tn + fn + eps)

  lr_positive <- sensitivity /
    (1 - specificity + eps)

  lr_negative <- (1 - sensitivity + eps) /
    specificity

  log_lr_positive <- log(lr_positive)

  log_lr_negative <- log(lr_negative)

  dor <- lr_positive / lr_negative

  prevalence <- (tp + fn) /
    (tp + fp + fn + tn + eps)

  auc <- (sensitivity + specificity) / 2

  results <- list(

    table = matrix(
      c(tp, fp,
        fn, tn),
      nrow = 2,
      byrow = TRUE,
      dimnames = list(
        Test = c("Positive", "Negative"),
        Condition = c("Positive", "Negative")
      )
    ),

    sensitivity = sensitivity,
    specificity = specificity,

    ppv = ppv,
    npv = npv,

    lr_positive = lr_positive,
    lr_negative = lr_negative,

    log_lr_positive = log_lr_positive,
    log_lr_negative = log_lr_negative,

    dor = dor,

    prevalence = prevalence,

    auc = auc

  )

  class(results) <- "eba_stats"

  results

}
