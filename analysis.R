library(dplyr)

data(mtcars)
mtcars_summary <- mtcars %>%
  select(mpg, cyl, disp) %>%
  summarise_all(mean)

print(mtcars_summary)
