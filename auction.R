library(NCAAcalcutta)
library(dplyr)
library(tidyr)

Sys.setenv('http_proxy'='')
Sys.setenv('https_proxy'='')
invited <- get_tournament_scores('mens') %>% 
  filter(round==1) %>% 
  select(region, team1_seed, team2_seed, team1_id, team2_id) %>% 
  mutate(game = row_number()) %>% 
  pivot_longer(cols = team1_seed:team2_id, names_to = c('team','.value'), names_sep = '_' ) %>% 
  group_by(game) %>% 
  mutate(seed = ifelse(is.na(seed),17-sum(seed,na.rm = T),seed)) %>% 
  ungroup()

teams <- scrape_teams('mens')

teams_auction <- invited %>% left_join(teams) %>% select(rank=seed,region,team=name)
teams_auction[teams_auction$rank==16 & teams_auction$region=='East','team'] = "Mount St. Mary's/Texas Southern"
teams_auction[teams_auction$rank==11 & teams_auction$region=='East','team'] = 'Michigan St./UCLA'
teams_auction[teams_auction$rank==16 & teams_auction$region=='West','team'] = 'Norfolk St./Appalachian St.'
teams_auction[teams_auction$rank==11 & teams_auction$region=='West','team'] = 'Wichita St./Drake'

# opponent
opp <- teams_auction %>% 
  mutate(rank=(17-rank)) %>% 
  rename(opponent=team)

teams_auction <- teams_auction %>% 
  left_join(opp)

start_auction(teams_auction)
