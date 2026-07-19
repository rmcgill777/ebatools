#' Fagan Nomogram
#'
#' Plot pre-test and post-test probabilities using likelihood ratios.
#'
#' @param pretest_probability Numeric value between 0 and 1.
#' @param lr_positive Positive likelihood ratio.
#' @param lr_negative Negative likelihood ratio.
#'
#' @return Invisibly returns the calculated probabilities.
#'
#' @export
#' @importFrom graphics par axis abline lines points text legend
fagan_nomogram <- function(pretest_probability,
                           lr_positive,
                           lr_negative) {

  if (!is.numeric(pretest_probability) ||
      length(pretest_probability) != 1 ||
      pretest_probability <= 0 ||
      pretest_probability >= 1) {
    stop("pretest_probability must be between 0 and 1.")
  }

  prob_to_odds <- function(p) p / (1 - p)
  odds_to_prob <- function(o) o / (1 + o)

  pre_odds <- prob_to_odds(pretest_probability)

  post_positive <- odds_to_prob(pre_odds * lr_positive)
  post_negative <- odds_to_prob(pre_odds * lr_negative)

  oldpar <- par(no.readonly = TRUE)
  on.exit(par(oldpar))

  par(mar = c(5, 4, 4, 6))

  plot(
    c(1, 2),
    c(pretest_probability, post_positive),
    type = "n",
    xlim = c(0.9, 2.35),
    ylim = c(0, 1),
    xaxt = "n",
    xlab = "",
    ylab = "Probability",
    main = "Fagan Nomogram"
  )

  axis(
    1,
    at = c(1, 2),
    labels = c("Pre-test", "Post-test")
  )

  abline(h = seq(0, 1, 0.1),
         col = "grey90",
         lty = 3)

  lines(
    c(1, 2),
    c(pretest_probability, post_positive),
    col = "blue",
    lwd = 3
  )

  lines(
    c(1, 2),
    c(pretest_probability, post_negative),
    col = "red",
    lwd = 3,
    lty = 2
  )

  points(
    c(1, 2),
    c(pretest_probability, post_positive),
    pch = 16,
    col = "blue",
    cex = 1.3
  )

  points(
    c(1, 2),
    c(pretest_probability, post_negative),
    pch = 17,
    col = "red",
    cex = 1.3
  )

  text(
    2.08,
    post_positive,
    sprintf("%.1f%%", post_positive * 100),
    pos = 4,
    col = "blue",
    xpd = TRUE
  )

  text(
    2.08,
    post_negative,
    sprintf("%.1f%%", post_negative * 100),
    pos = 4,
    col = "red",
    xpd = TRUE
  )

  legend(
    "topleft",
    legend = c("Positive test", "Negative test"),
    col = c("blue", "red"),
    lwd = 3,
    lty = c(1, 2),
    pch = c(16, 17),
    bty = "n"
  )

  invisible(list(
    pretest_probability = pretest_probability,
    post_positive = post_positive,
    post_negative = post_negative
  ))
}
