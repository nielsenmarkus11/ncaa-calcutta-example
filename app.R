library(NCAAcalcutta)

auction_results <- read.csv("data/teams-out.csv")
auction_results$X <- NULL

results_app(auction_results, 800, year=2019)

