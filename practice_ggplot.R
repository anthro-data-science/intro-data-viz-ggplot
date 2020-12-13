# Li-Ying
#############################################
# Demonstration 1: Inspecting data
library(tidyverse)

# take a look at the dataframe
View(starwars) 

# quick way to check variables we have
names(starwars)

# display the internal structure of data
str(starwars)

# get basic summary of data
summary(starwars)

#############################################
# Demonstration 2: Data manipulation
# use select, filter, and mutate
starwars_selected <-
  starwars %>% # the pipe takes everything before it to the next function call. Shift + command + M
  select(height, 
         mass, 
         eye_color, 
         species) %>% # simplify dataset
  filter(species == "Human") %>% # filter specific data points
  mutate(BMI = mass/(height/100)^2) # create a new variable

#############################################
# ggplot demonstration 1: Histogram
# histogram for BMI
starwars_selected %>% 
  ggplot(aes(BMI)) +
  geom_histogram() +
  theme_minimal()

# histogram for mass with sex group
starwars %>% 
  select(mass, 
         sex) %>% 
  ggplot(aes(mass, fill = sex)) +
  geom_histogram() +
  theme_minimal()

# only mass less than 500 and get rid of NA values
starwars %>% 
  select(mass, 
         sex) %>%
  drop_na() %>% 
  filter(mass < 500) %>% 
  ggplot(aes(mass, fill = sex)) +
  geom_histogram() +
  theme_minimal()

#############################################
# ggplot demonstration 2: Scatter plot
# scatter plot for height and mass
starwars %>% 
  select(height, mass, eye_color, sex) %>% 
  ggplot(aes(height, mass)) +
  geom_point() +
  theme_minimal()

# log value
starwars %>% 
  select(height, mass, eye_color, sex) %>% 
  ggplot(aes(height, mass)) +
  geom_point() +
  scale_y_log10() +
  theme_minimal()

# add two more variables represented by color and shape
starwars %>% 
  select(height, mass, eye_color, sex) %>% 
  ggplot(aes(height, mass, 
             color = eye_color, 
             shape = sex)) +
  geom_point() +
  scale_y_log10() +
  theme_minimal()

# increase point size and remove NA values
starwars %>% 
  select(height, mass, eye_color, sex) %>%
  drop_na() %>% 
  ggplot(aes(height, mass, 
             color = eye_color, 
             shape = sex)) +
  geom_point(size = 3, 
             alpha = 0.7) +
  scale_y_log10() +
  theme_minimal()

# update the labels of x and y axis
starwars %>% 
  select(height, mass, eye_color, sex) %>%
  drop_na() %>% 
  ggplot(aes(height, mass, 
             color = eye_color, 
             shape = sex)) +
  geom_point(size = 3, 
             alpha = 0.7) +
  scale_y_log10() +
  labs(x = "Height (cm)", 
       y = "Mass (kg)") +
  theme_minimal()

# Gayoung
#############################################
# ggplot demonstration 3: Boxplot
# boxplot: simple
box_simple <- starwars %>% 
  select(height, mass, eye_color) %>% 
  ggplot(aes(height, mass, color = eye_color)) +
  geom_boxplot() + #boxplot
  scale_y_log10()

# boxplot: theme setup
box_simple +
  theme_dark() 

# using different pkg to try other themes. 
# https://ggplot2-book.org/polishing.html
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
# ggplot demonstration 4: Facet plot
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

# add theme and labels 
facet_simple + 
  theme_solarized() +
  ggtitle("Boxplot for height and mass") +
  labs (x= "Height (cm)",
        y= "Mass (kg)")
