# Liying

library(tidyverse)

View(starwars)
str(starwars)
names(starwars)

# talk about %>% 
# talk filter
# talk select

# historgram
starwars %>% 
  filter(species == "Human") %>% 
  ggplot(aes(height)) +
  geom_histogram() +
  theme_minimal()

# scatter plot
starwars %>% 
  select(height, mass, eye_color) %>% 
  ggplot(aes(height, mass, color = eye_color)) +
  geom_point() +
  scale_y_log10() +
  theme_minimal()

# Gayoung

# boxplot
# facet_wrap
