setwd("~/Documents/DataScience/walking")

library(tidyverse)
library(sf)
library(rgdal)



df <- lapply(list.files("data"), function(f) {
  pth <- str_c("data/", f)
  
  st_read(pth, 
          quiet = TRUE,
          layer = "tracks") %>% 
    st_coordinates() %>%
    as_tibble() %>%
    select(X, Y) %>%
    mutate(src = pth) 
}) %>%
  reduce(rbind) %>%
  mutate(src = as.numeric(as.factor(src)))



df %>%
  ggplot(aes(X, Y, group = src)) +
  coord_quickmap() +
  geom_path(size  = .5,
             alpha = .1,
             color = "white")  +
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_rect(fill = "#242424"),
        plot.background = element_rect(fill = "#242424")) 
