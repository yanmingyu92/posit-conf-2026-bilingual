# Run with Rscript scripts/qa_book_ai.R; no provider requests are made.
script_arg <- grep("^--file=", commandArgs(), value = TRUE)
stopifnot(length(script_arg) == 1L)
script_path <- normalizePath(sub("^--file=", "", script_arg), mustWork = TRUE)
setwd(dirname(dirname(script_path)))
qa_temp <- Sys.getenv("TEMP", unset = tempdir())
.libPaths(c(Sys.getenv("QA_R_LIB", file.path(qa_temp, "book-qa-r-library")), .libPaths()))
cat("ellmer_installed=", requireNamespace("ellmer", quietly = TRUE), "\n")
cat("credential_present=", any(nzchar(Sys.getenv(c("ANTHROPIC_API_KEY", "OPENAI_API_KEY", "POSIT_AI_API_KEY", "POSIT_AI_KEY", "GOOGLE_API_KEY", "GEMINI_API_KEY")))), "\n")
x <- gregexpr("absent", "present", fixed = TRUE)[[1]]
stopifnot(!identical(x, -1L), x[[1]] == -1L)
cat("gregexpr_regression=PASS\n")
chapter_files <- Sys.glob("book/chapters/4[1-6]*.qmd")
stopifnot(length(chapter_files) == 6L)
for (f in chapter_files) {
  lines <- readLines(f, encoding = "UTF-8", warn = FALSE)
  starts <- which(lines == "```r")
  for (i in seq_along(starts)) {
    first <- starts[[i]] + 1L
    last <- first + which(lines[first:length(lines)] == "```")[[1]] - 2L
    parse(text = lines[first:last])
  }
  cat(basename(f), "parsed=", length(starts), "\n")
}
if (requireNamespace("ellmer", quietly = TRUE)) {
  library(ellmer)
  get_block <- function(pattern, id) {
    lines <- readLines(Sys.glob(pattern), encoding = "UTF-8", warn = FALSE)
    first <- which(lines == "```r")[[id]] + 1L
    last <- first + which(lines[first:length(lines)] == "```")[[1]] - 2L
    parse(text = lines[first:last])
  }
  eval(get_block("book/chapters/42*.qmd", 2))
  eval(get_block("book/chapters/43*.qmd", 1))
  cat("42:block2_schema=PASS;43:block1_tool_definition=PASS\n")
  project_dir <- tempfile("ai-code-fixture-")
  dir.create(project_dir)
  proj_path <- function(path) file.path(project_dir, path)
  expr <- get_block("book/chapters/43*.qmd", 3)
  eval(expr[1:4])
  brio::write_file("one target three", proj_path("sample.txt"))
  edit_file("sample.txt", "target", "changed")
  stopifnot(brio::read_file(proj_path("sample.txt")) == "one changed three")
  stopifnot(inherits(try(edit_file("sample.txt", "absent", "x"), silent = TRUE), "try-error"))
  brio::write_file("same same", proj_path("sample.txt"))
  stopifnot(inherits(try(edit_file("sample.txt", "same", "x"), silent = TRUE), "try-error"))
  cat("43:edit_file_unique_absent_duplicate=PASS\n")
  cat("ellmer_version=", as.character(packageVersion("ellmer")), "\n")
  stopifnot("chat_posit" %in% getNamespaceExports("ellmer"))
  cat("chat_posit_exported=TRUE\n")
  if ("Chat" %in% getNamespaceExports("ellmer")) {
    stopifnot(all(c("set_system_prompt", "chat_structured") %in% names(ellmer::Chat$public_methods)))
    cat("Chat_methods=", paste(names(ellmer::Chat$public_methods), collapse = ","), "\n")
  }
}
