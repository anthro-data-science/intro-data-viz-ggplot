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
#############################################
# boxplot: simple
box_simple <- starwars %>% 
  select(height, mass, eye_color) %>% 
  ggplot(aes(height, mass, color = eye_color)) +
  geom_boxplot() + #boxplot
  scale_y_log10()

# boxplot: theme setup
box_simple +
  theme_dark() 

#using different pkg to try other themes. 
#https://ggplot2-book.org/polishing.html
install.packages('ggthemes', dependencies = TRUE)
library(ggthemes)
box_simple +
  theme_solarized()

# put title and annotation
box_simple +
  theme_solarized() +
  ggtitle("Boxplot for height and mass") +
  labs (x= "Mass (kg)",
        y= "Height (cm)") +
  annotate(geom ="text", 
           x = 175,
           y = 1000,
           label = "one \n outlier", 
           size= 3)

# flip the coord
box_simple +
  theme_solarized() +
  ggtitle("Boxplot for height and mass") +
  labs (x= "Mass (kg)",
        y= "Height (cm)") +
  coord_flip()

#########################################

# facet_wrap
starwars %>% 
  select(height, mass, eye_color) %>% 
  drop_na() %>% #drop NA 
  ggplot(aes(height, mass)) +
  geom_point() +
  facet_wrap(~eye_color)

# facet : setting y scale to free
starwars %>% 
  select(height, mass, eye_color) %>% 
  drop_na() %>% #drop NA 
  ggplot(aes(height, mass)) +
  geom_point() +
  facet_wrap(~eye_color, scales = "free_y")

# get rid of outlier
facet_simple <-
  starwars %>% 
  select(height, mass, eye_color) %>% 
  filter(mass < 1000) %>% # drop outlier
  drop_na() %>% 
  ggplot(aes(height, mass)) +
  geom_point(color = "blue") + #change the point color to blue
  facet_wrap(~eye_color)

#add theme and labels 
facet_simple + 
  theme_solarized() +
  ggtitle("Boxplot for height and mass") +
  labs (x= "Height (cm)",
        y= "Mass (kg)")

