# Some ggplot2 graphs using Stars Wars data 

#install.packages('tidyverse')
library(tidyverse)

data("starwars")
d <- starwars

# peek at the data 
head(d)

#### Ordered and themed bar graph ####

# basic bar graph 
bg <- d %>% ggplot(aes(x=reorder(eye_color, eye_color, length))) + 
    geom_bar(fill="grey10") + 
    labs(x="eye color")

# use minimal theme
bg + theme_minimal() 

# add to a default theme
bg + theme_minimal() + 
    theme(panel.background = element_rect(color='black'))

# make a custom theme 
bg + theme(
    panel.background = element_rect(fill=rethinking::col.alpha('cornsilk1')), 
    panel.grid.major = element_line(color='cornsilk2'), 
    panel.grid.minor = element_line(color='cornsilk2', linetype = 2))

# save custom theme 
my_theme <-theme(
    panel.background = element_rect(fill=adjustcolor('cornsilk1', alpha.f = 0.5)), 
    panel.grid.major = element_line(color='cornsilk2'), 
    panel.grid.minor = element_line(color='cornsilk2', linetype = 2)
    )

#### Graphing distributions ####

# histogram of height
h <- d %>% ggplot(aes(height)) + my_theme + 
    geom_histogram(binwidth = 10,
                   fill="#3b55ff", color="cornsilk2") 

# the minor ticks on the x axis should match the binwidth 
h + scale_x_continuous(breaks=seq(0,300,20))

# geom area 
d %>% 
    ggplot(aes(mass)) + my_theme + 
    geom_area(stat='bin') 


# fill by factor 
a <- d %>% 
    # remove jabba, he's so big 
    filter(!grepl('Jabba', name)) %>% 
    ggplot(aes(mass, fill=gender)) + my_theme + 
    geom_area(stat='bin', binwidth=10, alpha=0.9) + 
    scale_x_continuous(breaks=seq(0,300,20))

# manually change the fill colors 
a + scale_fill_manual(values = c('tomato','#3b55ff'))


#### Plot two discrete variables #### 

# tile plot, kind of like two histograms making a raster
dv <- d %>% ggplot(aes(eye_color, skin_color)) + 
    geom_bin2d() +
    theme_minimal() 

# change the gradient colors to make break more obvious 
dv + scale_fill_continuous(breaks = seq(0,10,2), low="#3b55ff", high="tomato")

### Trend line and scatter plots #### 

# height and mass
hx <- d %>% 
    filter(!grepl('Jabba', name)) %>% 
    ggplot( aes(height, mass)) + 
    geom_smooth(color='black', alpha=0.2) + 
    theme_minimal() + 
    theme(panel.background = element_rect(color="black")); hx
 
# overlay points
hx + geom_point(pch=21)

#### Use contours to visualize continuous variables with outliers ####
d %>% ggplot( aes(mass, height )) + 
    geom_point() + 
    theme_minimal() + 
    scale_x_continuous(breaks = seq(0,150,25))

# density_2d
d %>% ggplot( aes(mass, height )) +
    stat_density_2d(aes(fill = ..level..), geom = "polygon") + 
    theme_minimal() 

# some aesthetic changes
d %>% ggplot( aes(mass, height )) +
    stat_density_2d(aes(fill = ..level..), geom = "polygon") + # fill mapped to density 
    theme_minimal() + 
    scale_x_continuous(breaks = seq(0,150,25)) + 
    scale_fill_gradient(low="#3b55ff", high="tomato") +  # gradient colors
    scale_y_continuous(breaks = seq(0,250,25)) + 
    theme(
        panel.background = element_rect(color="black",fill="#121a4d"),
        panel.grid = element_line(color="#001a4d")  # some custom colors
    )
    
