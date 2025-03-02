library(dplyr)
library(tidyr)
library(brms)
library(here)

data_long <- read.csv(here("data", "jay_data.csv"), stringsAsFactors = FALSE)

str(data_long)

data_long <- data_long %>%
  mutate(nest_bin = ifelse(nest_type == "Jay", 1, 0)) %>%
  group_by(nest_type, category) %>%
  mutate(nest_id = row_number()) %>%
  ungroup()


data_wide <- data_long %>%
  pivot_wider(
    id_cols = c(nest_type, nest_bin, nest_id),
    names_from = category,
    values_from = percentage
  )

str(data_wide)

model <- brm(
  nest_bin ~ percentage * category,
  family = bernoulli(link = "logit"),
  data = data_wide,
  prior = c(
    set_prior("normal(0, 5)", class = "b"),   
    set_prior("normal(0, 5)", class = "Intercept")
  ),
  chains = 4,
  iter = 2000,
  warmup = 1000
)

summary(model)
