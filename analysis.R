library(dplyr)
library(brms)

data <- read.csv("jay_data.csv")

data$response <- as.integer(data$response)

model <- brm(
  response ~ trees + roads + grass,
  family = bernoulli(link = "logit"),
  data = data,
  prior = c(
    set_prior("normal(0, 5)", class = "b"),   
    set_prior("normal(0, 5)", class = "Intercept")
  ),
  chains = 4,
  iter = 2000,
  warmup = 1000
)

summary(model)