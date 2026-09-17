# Dedicated test library; existing system packages remain untouched.
lib <- Sys.getenv("QA_R_LIB", file.path(Sys.getenv("TEMP"), "book-qa-r-library"))
dir.create(lib, recursive = TRUE, showWarnings = FALSE)
.libPaths(c(lib, .libPaths()))
options(repos = c(CRAN = "https://cloud.r-project.org"), timeout = 90)
pkgs <- c("tidyverse", "palmerpenguins", "gapminder", "gt", "ggridges", "ggrepel",
          "patchwork", "ggforce", "gghighlight", "plotly", "gganimate", "gifski",
          "av", "leaflet", "sf", "bench", "profvis", "testthat", "usethis",
          "roxygen2", "devtools", "httr2", "jsonlite", "rvest", "polite", "shiny",
          "bslib", "thematic", "gtsummary", "tfrmt", "cards", "admiral",
          "tidymodels", "reactlog", "nycflights13", "renv", "furrr", "webshot2")
missing <- setdiff(pkgs, rownames(installed.packages()))
if (length(missing)) install.packages(missing, lib = lib,
  type = if (.Platform$OS.type == "windows") "binary" else "source")
dir.create(".qa", showWarnings = FALSE)
write.csv(data.frame(package = pkgs,
  available = vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)),
  ".qa/packages.csv", row.names = FALSE)
