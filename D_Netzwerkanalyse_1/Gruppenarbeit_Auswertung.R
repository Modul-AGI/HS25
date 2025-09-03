

library(tidyverse)


points <- tribble(
 ~x, ~y, ~name,
 1, 2, "H",
 2, 2, "G",
 3, 2, "F",
 4, 2, "B",
 3.5, 1, "C",
 4.5, 1, "D",
 3, 3, "E",
 4, 3, "A"
)

lines <- list(
  c("H","G"), 
  c("G", "F"),
  c("F", "B"),
  c("F", "C"),
  c("F", "E"),
  c("E", "A"),
  c("A", "B"),
  c("B", "C"),
  c("B", "D"),
  c("D", "C")
  ) %>%
  map_dfr(function(z){
    tibble(
      x = points$x[points$name == z[1]],
      y = points$y[points$name == z[1]],
      xend = points$x[points$name == z[2]],
      yend = points$y[points$name == z[2]],
      
    )
    
      })



library(googlesheets4)

googlesheets4::gs4_deauth()


degree <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1B6F5q9GKeYWZ41OIBGTgd9Cj10sp0XdazlVTd6x3a9A/edit?usp=sharing",
                                    "'Degree Centrality'",
                          range = "'Degree Centrality'!A4:C12")


closeness <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1B6F5q9GKeYWZ41OIBGTgd9Cj10sp0XdazlVTd6x3a9A/edit?usp=sharing",
                                    "'Closeness Centrality'",
                                    range = "'Closeness Centrality'!A4:L12")


betweenness <- list(
  c("A","D"),
  c("F","I"),
  c("K", "N")
) %>% map_dfr(function(cols){
  googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1B6F5q9GKeYWZ41OIBGTgd9Cj10sp0XdazlVTd6x3a9A/edit?usp=sharing",
                            "'Closeness Centrality'",
                            range = paste0("'Betweenness Centrality'!",cols[1],"4:",cols[2],"4"),col_names = FALSE)
}) %>%
  mutate(
    name = str_remove(...1,"Betweenness centrality für "),
    wert = ...4
  ) %>%
  select(name,wert)



points_degree <- left_join(points,degree, by = c("name" = "Knoten"))
points_closeness <- left_join(points,closeness, by = c("name" = "...1"))
points_betweenness <- left_join(points,betweenness, by = c("name"))



ggplot(points_degree, aes(x,y, label = name)) +
  geom_segment(data = lines, aes(x, y, xend = xend, yend = yend),inherit.aes = FALSE) +
  geom_label(aes(fill = Rang),label.r = unit(1.1, "lines"), label.padding = unit(0.8, "lines")) +
  scale_fill_viridis_c() +
  coord_equal() +
  theme_void()
