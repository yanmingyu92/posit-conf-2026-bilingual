.libPaths(c(Sys.getenv('QA_R_LIB'), .libPaths()))
options(timeout = 30, warn = 1, browser = function(...) invisible(NULL))
set.seed(20260917)
manifest <- jsonlite::fromJSON('manifest.json', simplifyVector = FALSE)
chapter <- manifest[[1]]$chapter
output_file <- file('results.jsonl', 'w', encoding = 'UTF-8')
pdf('plots.pdf')
env <- new.env(parent = globalenv())
if (chapter == '32') {
  library(testthat)
  options(testthat.edition=3)
  src <- readLines('../../../book/chapters/31-pkg-structure.qmd', encoding='UTF-8')
  starts <- which(src == '```r')
  start <- starts[2] + 1
  end <- which(seq_along(src) > start & src == '```')[1] - 1
  eval(parse(text=src[start:end]), env)
}
if (chapter == '34') env$files <- list.files('data/survey', full.names=TRUE)
for (block in manifest) {
  result <- list(id=block$id, category=block$category, status='', detail=block$reason,
                 line=block$line, file=block$file, warnings=character())
  cat('\nBLOCK ', block$id, '\n')
  parsed <- tryCatch(parse(text=block$code, keep.source=TRUE), error=identity)
  if (inherits(parsed, 'error')) {
    result$status <- 'FAIL-PARSE'; result$detail <- conditionMessage(parsed)
  } else if (isTRUE(block$skip)) {
    result$status <- if(block$category == 'NEEDS-API') 'SKIPPED-API' else 'SKIPPED-CONTEXT'
  } else {
    errors <- character()
    warnings <- character()
    started <- proc.time()[['elapsed']]
    tryCatch({
      setTimeLimit(elapsed=if (chapter=='22') 240 else 60, transient=TRUE)
      for (expr in parsed) {
        value <- withCallingHandlers(withVisible(eval(expr, env)), warning=function(w) {
          warnings <<- c(warnings, conditionMessage(w)); invokeRestart('muffleWarning')
        })
        # Force ordinary ggplot construction; avoid launching Shiny, HTML viewers,
        # profvis viewers, or implicit 100-frame animation via print methods.
        if (value$visible && inherits(value$value, 'ggplot') && !inherits(value$value, 'gganim')) {
          print(value$value)
        }
      }
      if (chapter == '12' && block$id == '12:01') stopifnot(identical(env$data_2012$year, env$data_2013$year), identical(env$data_2012$score, env$data_2013$score))
    }, error=function(e) errors <<- c(errors, conditionMessage(e)), finally=setTimeLimit(cpu=Inf,elapsed=Inf,transient=FALSE))
    result$seconds <- unname(proc.time()[['elapsed']] - started)
    result$warnings <- warnings
    if (any(grepl('Failed to plot frame|reached elapsed time limit', warnings))) errors <- c(errors, 'Animation frame rendering failed or timed out; see warnings.')
    if (length(errors)) {
      detail <- paste(errors, collapse='; ')
      expected <- block$category == 'INTENTIONALLY-BROKEN' &&
        ((chapter=='33' && grepl('column|bounds|past the end|exist', detail, ignore.case=TRUE)) ||
         (chapter=='26' && grepl('ggplot|layer|add', detail, ignore.case=TRUE)))
      result$status <- if (expected) 'EXPECTED-ERROR' else if (grepl('there is no package|package .*required|requires the .*package|not installed', detail)) 'SKIPPED-PKG' else if (block$category == 'NEEDS-NETWORK' && grepl('HTTP|resolve|connect|Timeout|timed out|SSL', detail)) 'SKIPPED-NETWORK' else 'FAIL'
      result$detail <- detail
    } else {
      result$status <- if (block$category == 'INTENTIONALLY-BROKEN' && chapter != '12') 'FAIL-EXPECTED-ERROR' else 'OK'
      if (chapter=='33' && block$id=='33:01') result$detail <- 'Function definition evaluated; interactive browser breakpoint not invoked.'
    }
  }
  writeLines(jsonlite::toJSON(result, auto_unbox=TRUE, null='null'), output_file)
  flush(output_file)
}
dev.off()
close(output_file)
