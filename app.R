library(NCAAcalcutta)

auction_results <- read.csv("data/teams-out-castell.csv")
auction_results$X <- NULL

results_app(auction_results, 825)

