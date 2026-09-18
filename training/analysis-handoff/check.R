# Original executable acceptance checks by Jaime Yan. Base R only.
arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
lab <- dirname(normalizePath(sub("^--file=", "", arg[[1]]), winslash = "/"))
args <- commandArgs(TRUE)
output <- if (length(args)) args[[1]] else file.path(".qa", "analysis-handoff-check")
# Optional second argument: your own implementation exposing the same four functions.
implementation <- if (length(args) > 1L) args[[2]] else file.path(lab, "solution.R")
source(implementation, encoding = "UTF-8")
fail_expected <- function(expr, pattern) {
  err <- tryCatch({force(expr); NULL}, error = conditionMessage)
  stopifnot(!is.null(err), grepl(pattern, err))
}
x <- read_observations(file.path(lab, "synthetic-observations.csv"))
stopifnot(nrow(x) == 31L)
cleaned <- clean_observations(x)
stopifnot(nrow(cleaned$data) == 28L, sum(cleaned$audit$disposition == "exact_duplicate") == 1L,
          sum(cleaned$audit$disposition == "out_of_range") == 2L,
          all(c(0, 100) %in% cleaned$data$quality_score))
s <- summarise_sites(cleaned$data)
stopifnot(identical(s$n_records, c(8L, 10L, 10L)),
          identical(s$n_observed, c(7L, 9L, 9L)),
          identical(s$n_missing, c(1L, 1L, 1L)),
          isTRUE(all.equal(s$mean_score, c(50, 530 / 9, 485 / 9))))
all_missing <- cleaned$data
all_missing$quality_score[all_missing$site == "North"] <- NA_real_
stopifnot(is.na(summarise_sites(all_missing)$mean_score[[1]]))
empty <- summarise_sites(cleaned$data[FALSE, ])
stopifnot(all(empty$n_records == 0L), all(is.na(empty$mean_score)))
conflict <- rbind(x, x[1, ])
conflict$quality_score[nrow(conflict)] <- 1
fail_expected(clean_observations(conflict), "Conflicting duplicate")
fixture <- tempfile(fileext = ".csv")
bad <- x[1, ]; bad$quality_score <- "not-a-number"
write.csv(bad, fixture, row.names = FALSE)
fail_expected(read_observations(fixture), "Non-numeric")
bad$quality_score <- "50"; bad$observed_on <- "2026-02-30"
write.csv(bad, fixture, row.names = FALSE)
fail_expected(read_observations(fixture), "Invalid observed_on")
bad$observed_on <- "2026-02-01"; bad$site <- "Unknown"
write.csv(bad, fixture, row.names = FALSE)
fail_expected(read_observations(fixture), "Unknown site")
bad$site <- "North"; bad$record_id <- NA_character_
write.csv(bad, fixture, row.names = FALSE, na = "")
fail_expected(read_observations(fixture), "Missing record_id")
write.csv(bad[, -1], fixture, row.names = FALSE)
fail_expected(read_observations(fixture), "Unexpected schema")
unlink(fixture)
run_handoff(file.path(lab, "synthetic-observations.csv"), output)
files <- file.path(output, c("site-summary.csv", "row-audit.csv", "site-quality.png"))
stopifnot(all(file.exists(files)), all(file.size(files) > 100))
roundtrip <- read.csv(files[[1]])
stopifnot(isTRUE(all.equal(roundtrip$mean_score, s$mean_score)))
cat("PASS: import, 31-row audit, boundaries, missingness, duplicates, empty groups, exports\n")
