library(googlesheets4)
library(dplyr)
library(clipr)

sheet_url <- "https://docs.google.com/spreadsheets/d/1oyCISuOAytk0kdEWm0J3BCTLoQoRcuCc8NtnkCtFmzw"

gs4_auth(email = "*@posit.co")

registrations <- read_sheet(sheet_url, sheet = "Registrations", skip = 5)

emails <- registrations |>
  filter(`Session name` == "Our Modern R Workflow (ft. Positron and AI)") |>
  pull(Email)
length(emails) #134 -> 137

bcc_string <- paste(emails, collapse = ",")

clipr::write_clip(bcc_string)
