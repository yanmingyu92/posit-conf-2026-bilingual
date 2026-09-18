# Original training material by Jaime Yan. Synthetic operational quality data only.
script_path <- function() {
  arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
  if (!length(arg)) stop("Run this script with Rscript, or supply paths to functions.")
  normalizePath(sub("^--file=", "", arg[[1]]), winslash = "/")
}

read_observations <- function(path) {
  x <- read.csv(path, colClasses = "character", na.strings = "", check.names = FALSE)
  required <- c("record_id", "site", "observed_on", "quality_score")
  if (!identical(names(x), required)) stop("Unexpected schema: require record_id, site, observed_on, quality_score")
  if (anyNA(x$record_id) || any(!nzchar(trimws(x$record_id)))) stop("Missing record_id")
  if (anyNA(x$site) || any(!x$site %in% c("North", "Central", "South"))) stop("Unknown site")
  dates <- as.Date(x$observed_on, format = "%Y-%m-%d")
  if (anyNA(dates) || any(format(dates, "%Y-%m-%d") != x$observed_on)) stop("Invalid observed_on")
  score <- suppressWarnings(as.numeric(x$quality_score))
  if (any(!is.na(x$quality_score) & (is.na(score) | !is.finite(score)))) stop("Non-numeric quality_score")
  x$observed_on <- dates
  x$quality_score <- score
  x
}

clean_observations <- function(x) {
  # Conflicting repeated IDs require an explicit decision; never silently choose a row.
  repeated <- unique(x$record_id[duplicated(x$record_id)])
  for (id in repeated) {
    if (nrow(unique(x[x$record_id == id, , drop = FALSE])) > 1L) {
      stop("Conflicting duplicate record_id: ", id)
    }
  }
  duplicate <- duplicated(x$record_id)
  invalid <- !is.na(x$quality_score) & (x$quality_score < 0 | x$quality_score > 100)
  reason <- ifelse(duplicate, "exact_duplicate", ifelse(invalid, "out_of_range", "retained"))
  audit <- data.frame(source_row = seq_len(nrow(x)), x,
                      disposition = reason, row.names = NULL)
  list(data = x[reason == "retained", , drop = FALSE], audit = audit)
}

summarise_sites <- function(x) {
  sites <- c("North", "Central", "South")
  do.call(rbind, lapply(sites, function(site) {
    score <- x$quality_score[x$site == site]
    observed <- score[!is.na(score)]
    data.frame(site = site, n_records = length(score),
      n_observed = length(observed), n_missing = sum(is.na(score)),
      mean_score = if (length(observed)) mean(observed) else NA_real_,
      median_score = if (length(observed)) median(observed) else NA_real_)
  }))
}

run_handoff <- function(input, output_dir) {
  cleaned <- clean_observations(read_observations(input))
  summary <- summarise_sites(cleaned$data)
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  write.csv(summary, file.path(output_dir, "site-summary.csv"), row.names = FALSE, na = "")
  write.csv(cleaned$audit, file.path(output_dir, "row-audit.csv"), row.names = FALSE, na = "")
  grDevices::png(file.path(output_dir, "site-quality.png"), width = 1000, height = 650, res = 120)
  on.exit(grDevices::dev.off(), add = TRUE)
  means <- summary$mean_score
  positions <- barplot(replace(means, is.na(means), 0), names.arg = summary$site,
    ylim = c(0, 110), col = "#2266B1", border = NA,
    ylab = "Mean operational quality score (0-100)",
    main = "Synthetic multi-site data: descriptive summary")
  labels <- ifelse(is.na(means), "No observations",
    paste0("n=", summary$n_observed, "; missing=", summary$n_missing))
  text(positions, ifelse(is.na(means), 5, means + 5), labels, cex = 0.8)
  mtext("SIMULATED DATA - not patients, clinical outcomes, or treatment effects", side = 1, line = 3.5, cex = 0.7)
  invisible(list(summary = summary, audit = cleaned$audit))
}

if (sys.nframe() == 0L) {
  args <- commandArgs(TRUE)
  output <- if (length(args)) args[[1]] else file.path(".qa", "analysis-handoff")
  run_handoff(file.path(dirname(script_path()), "synthetic-observations.csv"), output)
  cat("Wrote site-summary.csv, row-audit.csv and site-quality.png to", output, "\n")
}
