# Compare code structure between editions, allowing translated string literals/comments.
# Runtime QA and review must still establish that translated strings preserve contracts.
blocks <- function(path) {
  lines <- readLines(path, encoding = "UTF-8", warn = FALSE)
  lapply(which(lines == "```r"), function(start) {
    finish <- which(seq_along(lines) > start & lines == "```")[1]
    paste(lines[seq.int(start + 1L, finish - 1L)], collapse = "\n")
  })
}
signature <- function(code) {
  data <- getParseData(parse(text = code, keep.source = TRUE))
  if (is.null(data)) return(character())
  data <- data[data$terminal & !data$token %in% c("COMMENT", "STR_CONST"), ]
  paste(data$token, data$text)
}
results <- data.frame(file = character(), block = integer(), structure_equal = logical())
for (source in list.files("book/chapters", pattern = "[.]qmd$", full.names = TRUE)) {
  target <- file.path("book-en/chapters", basename(source))
  zh <- blocks(source)
  en <- blocks(target)
  stopifnot(length(zh) == length(en))
  for (i in seq_along(zh)) {
    results <- rbind(results, data.frame(file = basename(source), block = i,
      structure_equal = identical(signature(zh[[i]]), signature(en[[i]]))))
  }
}
dir.create(".qa/en", recursive = TRUE, showWarnings = FALSE)
write.csv(results, ".qa/en/code-parity.csv", row.names = FALSE)
print(results[!results$structure_equal, ])
cat("Compared", nrow(results), "blocks; structural differences:", sum(!results$structure_equal), "\n")
if (any(!results$structure_equal)) quit(status = 1)
