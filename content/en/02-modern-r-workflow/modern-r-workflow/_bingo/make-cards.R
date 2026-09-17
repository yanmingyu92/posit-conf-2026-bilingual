library(bingo)
library(here)
set.seed(5263)

card_names <- c(
  "positron-rules",
  "positron-rocks",
  "positron-power",
  "positron-vibes",
  "positron-magic",
  "positron-forever",
  "positron-fanclub",
  "positron-nation",
  "positron-energy",
  "positron-express"
)
n_cards <- length(card_names)

# Create bingo cards -----------------------------------------------------

positron <- scan(here("_bingo", "prompts.txt"), what = character(), sep = "\n")
bc <- bingo(n_cards = n_cards, words = positron)

# Plot each card to its own PDF, with a cute name, for participants to
# pick from on-screen ------------------------------------------------------

cards_dir <- here("_bingo", "cards")
plot(bc, dir = cards_dir, fontsize = 12, pdf_base = "card-")

generated <- sprintf("card-%02d.pdf", seq_len(n_cards))
file.rename(
  file.path(cards_dir, generated),
  file.path(cards_dir, paste0(card_names, ".pdf"))
)
