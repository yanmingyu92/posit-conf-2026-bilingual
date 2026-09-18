# Isolated verification of package-development and renv chapter examples.
# Run from the repository root; writes evidence only under .qa/.
qa_lib <- Sys.getenv("QA_R_LIB", file.path(Sys.getenv("TEMP"), "book-qa-r-library"))
.libPaths(c(qa_lib, .libPaths()))
options(repos = c(CRAN = "https://cloud.r-project.org"),
        usethis.quiet = TRUE, usethis.overwrite = TRUE)
Sys.setenv(NOT_CRAN = "true")
repo <- normalizePath(getwd(), winslash = "/")
evidence <- file.path(repo, Sys.getenv("QA_EVIDENCE_DIR", ".qa"))
book_dir <- file.path(repo, Sys.getenv("QA_BOOK_DIR", "book"))
dir.create(evidence, showWarnings = FALSE, recursive = TRUE)
results <- data.frame(block = character(), status = character(), detail = character())
record <- function(block, expr) {
  tryCatch({
    force(expr)
    results <<- rbind(results, data.frame(block, status = "OK", detail = ""))
  }, error = function(e) {
    results <<- rbind(results, data.frame(block, status = "FAILED", detail = conditionMessage(e)))
  })
}
blocks <- function(prefix) {
  path <- list.files(file.path(book_dir, "chapters"),
                     pattern = paste0("^", prefix, "-.*[.]qmd$"), full.names = TRUE)
  lines <- readLines(path, encoding = "UTF-8", warn = FALSE)
  starts <- which(lines == "```r")
  lapply(starts, function(start) {
    finish <- which(seq_along(lines) > start & lines == "```")[1]
    paste(lines[seq.int(start + 1, finish - 1)], collapse = "\n")
  })
}
ch31 <- blocks("31")
ch32 <- blocks("32")
work <- tempfile("book-qa-projects-")
dir.create(work)
pkg <- file.path(work, "scorekit")
record("31:1", {
  usethis::create_package(pkg, open = FALSE)
  usethis::proj_set(pkg, force = TRUE)
  setwd(pkg)
  usethis::use_r("grade_letter", open = FALSE)
})
record("31:2", {
  writeLines(ch31[[2]], "R/grade_letter.R", useBytes = TRUE)
  devtools::load_all(quiet = TRUE)
  stopifnot(identical(as.character(grade_letter(c(95, 72, 58))), c("A", "C", "F")))
})
record("31:3", eval(parse(text = ch31[[3]])))
record("31:4", {
  writeLines(ch31[[4]], "R/grade_letter.R", useBytes = TRUE)
  devtools::document(quiet = TRUE)
  stopifnot(file.exists("man/grade_letter.Rd"))
  devtools::load_all(quiet = TRUE)
  stopifnot(identical(as.character(grade_letter(c(95, 72, 58))), c("A", "C", "F")))
})
record("32:1", {
  usethis::use_testthat(edition = 3)
  library(testthat)
  eval(parse(text = ch32[[1]]))
})
record("32:2", eval(parse(text = ch32[[2]])))
record("32:3 (non-IDE lines)", {
  usethis::use_test("grade_letter", open = FALSE)
  writeLines(ch32[[1]], "tests/testthat/test-grade_letter.R", useBytes = TRUE)
  devtools::test(stop_on_failure = TRUE)
})
record("32:4", {
  writeLines(paste(ch32[[1]], ch32[[4]], sep = "\n"),
             "tests/testthat/test-grade_letter.R", useBytes = TRUE)
  # First run establishes the snapshot; the second verifies it.
  devtools::test(stop_on_failure = TRUE)
  devtools::test(stop_on_failure = TRUE)
  stopifnot(file.exists("tests/testthat/_snaps/grade_letter.md"))
})
record("32:5 (non-IDE lines)", {
  pkgcov <- covr::package_coverage()
  covr::report(pkgcov, file = file.path(evidence, "scorekit-coverage.html"), browse = FALSE)
})
setwd(repo)
# A separate R process prevents renv from replacing the test harness library.
renv_project <- file.path(work, "renv-project")
dir.create(renv_project)
renv_script <- file.path(work, "renv-smoke.R")
writeLines(c(
  sprintf(".libPaths(c(%s, .libPaths()))", deparse(qa_lib)),
  sprintf("setwd(%s)", deparse(renv_project)),
  'options(repos = c(CRAN = "https://cloud.r-project.org"), renv.config.auto.snapshot = FALSE)',
  'Sys.setenv(RENV_CONFIG_CACHE_ENABLED = "FALSE", RENV_CONFIG_AUTOLOADER_ENABLED = "FALSE")',
  'renv::init(bare = TRUE, restart = FALSE)',
  'renv::snapshot(prompt = FALSE)',
  'stopifnot(file.exists("renv.lock"))',
  'renv::restore(prompt = FALSE)',
  'stopifnot(length(renv::status()$synchronized) == 1L, renv::status()$synchronized)'
), renv_script)
record("48:1", {
  status <- system2(file.path(R.home("bin"), "Rscript.exe"),
                    c("--vanilla", shQuote(renv_script)),
                    stdout = file.path(evidence, "renv-smoke.log"), stderr = "")
  stopifnot(status == 0L)
})
record("48:2", eval(parse(text = blocks("48")[[2]])))
write.csv(results, file.path(evidence, "project-results.csv"), row.names = FALSE)
print(results, row.names = FALSE)
cat("Isolated project path:", work, "\n")
if (any(results$status == "FAILED")) quit(status = 1)
