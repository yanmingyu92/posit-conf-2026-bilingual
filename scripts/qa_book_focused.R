# Run from repository root; QA_R_LIB overrides the dedicated test library.
lib <- Sys.getenv("QA_R_LIB", file.path(Sys.getenv("TEMP"), "book-qa-r-library"))
.libPaths(c(lib, .libPaths()))
repo <- normalizePath(".", winslash = "/")
out <- file.path(repo, ".qa")
dir.create(out, showWarnings = FALSE)
sandbox <- file.path(out, "focused-artifacts")
dir.create(sandbox, showWarnings = FALSE)
blocks <- function(prefix) {
  path <- list.files(file.path(repo, "book/chapters"), pattern = paste0("^", prefix, "-"), full.names = TRUE)
  lines <- readLines(path, encoding = "UTF-8", warn = FALSE)
  starts <- which(grepl("^```r[[:space:]]*$", lines))
  lapply(starts, function(start) {
    end <- which(seq_along(lines) > start & grepl("^```[[:space:]]*$", lines))[1]
    paste(lines[seq.int(start + 1L, end - 1L)], collapse = "\n")
  })
}
results <- list()
check <- function(id, action) {
  warning_text <- character()
  error <- tryCatch(withCallingHandlers({action(); NULL}, warning = function(w) {
    warning_text <<- c(warning_text, conditionMessage(w)); invokeRestart("muffleWarning")
  }), error = conditionMessage)
  results[[length(results) + 1L]] <<- data.frame(
    id = id, status = if (is.null(error)) "PASS" else "FAIL",
    detail = if (is.null(error)) "" else error,
    warnings = paste(unique(warning_text), collapse = " | "))
}
setwd(sandbox)
check("01-all-blocks", function() {
  env <- new.env(parent = globalenv())
  for (code in blocks("01")) eval(parse(text = code), env)
  stopifnot(env$mean_bill(env$pg) == 38.8,
            env$mean_bill(env$pg, species = "Gentoo") == 47.5)
})
check("27-iris-module-output", function() {
  env <- new.env(parent = globalenv())
  code <- blocks("27")
  eval(parse(text = code[[1]]), env)
  eval(parse(text = sub("shinyApp(ui, server)", "app <- shinyApp(ui, server)",
                        code[[4]], fixed = TRUE)), env)
  shiny::testServer(env$hist_server, args = list(data = env$iris_num), {
    session$setInputs(col = "Sepal.Length")
    stopifnot(is.list(output$hist))
  })
})
check("22-seven-animation-variants-20-frames", function() {
  env <- new.env(parent = globalenv())
  code <- blocks("22")
  eval(parse(text = code[[1]]), env)
  eval(parse(text = code[[2]]), env)
  reveal <- eval(parse(text = code[[3]]), env)
  variants <- list(env$anim, env$p_states, reveal,
    env$p_states + gganimate::ease_aes("sine-in-out"),
    env$p_states + gganimate::ease_aes("bounce-out"),
    env$anim + gganimate::shadow_mark(),
    env$anim + gganimate::shadow_trail(distance = 0.05))
  # At least 20 frames: shadow_trail rounds distance * nframes to an integer.
  for (p in variants) {
    gif <- gganimate::animate(p, nframes = 20, fps = 3,
      width = 320, height = 240, renderer = gganimate::gifski_renderer())
    stopifnot(inherits(gif, "gif_image"))
  }
})
setwd(repo)
results <- do.call(rbind, results)
write.csv(results, file.path(out, "focused-results.csv"), row.names = FALSE, fileEncoding = "UTF-8")
jsonlite::write_json(results, file.path(out, "focused-results.json"), pretty = TRUE, auto_unbox = TRUE)
print(results[c("id", "status", "detail")])
if (any(results$status == "FAIL")) quit(status = 1)
