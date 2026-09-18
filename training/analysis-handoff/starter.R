# Jaime Yan | Original lab | Synthetic data only; no patient or efficacy data.
args <- grep("^--file=", commandArgs(FALSE), value = TRUE)
lab_dir <- dirname(normalizePath(sub("^--file=", "", args[[1]]), winslash = "/"))
raw <- read.csv(file.path(lab_dir, "synthetic-observations.csv"),
                colClasses = "character", na.strings = "")
str(raw)
cat("Rows:", nrow(raw), "\nExact duplicate rows:", sum(duplicated(raw)), "\n")

# COPY: inspect schema, duplicate IDs, and score text before converting types.
# ADAPT: implement these functions; review README.md's explicit data contract.
read_observations <- function(path) {
  stop("TODO: schema, IDs, known sites, strict dates and numeric conversion")
}
clean_observations <- function(x) {
  stop("TODO: exact duplicate audit, conflicting-ID error, range exclusions")
}
summarise_sites <- function(x) {
  stop("TODO: all three sites, observed denominator, NA for empty groups")
}
run_handoff <- function(input, output_dir) {
  stop("TODO: summary CSV, row audit, PNG, with explicit synthetic-data label")
}
# CREATE: run_handoff(...) from a clean R process and document your decisions.
# Do not source solution.R during the AI-off stage.
