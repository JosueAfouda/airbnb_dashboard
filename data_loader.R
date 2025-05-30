newyork <- read.csv("data/new_york.csv")
# View(head(newyork))
# glimpse(newyork)

newyork <- newyork %>% 
  mutate(price = as.numeric(str_replace_all(price, ",", "")))

sanfrancisco <- read.csv("data/san_francisco.csv")
# View(head(sanfrancisco))
# glimpse(sanfrancisco)

amsterdam <- read.csv("data/amsterdam.csv")
# View(head(amsterdam))
# glimpse(amsterdam)
