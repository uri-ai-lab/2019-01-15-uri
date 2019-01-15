library(tidyverse)
library(DBI)
crops <- read_csv("_episodes_rmd/data/crops.csv")
plots <- read_csv("_episodes_rmd/data/plots.csv")
farms <- read_csv("_episodes_rmd/data/surveys.csv")

# clean up and extract the columns we want to add to the db
cropsTbl <- crops %>% select(Id, plot_Id, crop_Id, D05_times, D_curr_crop)
plotsTbl <- plots %>% select(Id, plot_Id, D01_curr_plot, D02_total_plot, D03_unit_land)
farmsTbl <- farms %>% rename(Id = key_ID) %>% select(Id, village, interview_date, no_membrs, years_liv, respondent_wall_type, rooms, memb_assoc, affect_conflicts)


safi_db_file <- "_episodes_rmd/data/safi.sqlite"
safi <- DBI::dbConnect(RSQLite::SQLite(), safi_db_file)
dbWriteTable(safi, cropsTbl, name = "crops")
dbWriteTable(safi, plotsTbl, name = "plots")
dbWriteTable(safi, farmsTbl, name = "farms")
dbReadTable(safi, "plots")
