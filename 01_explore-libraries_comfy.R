#' Which libraries does R search for packages?

# try .libPaths(), .Library


#' Installed packages

## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View() or similar to inspect
library(tidyverse)
data <- installed.packages()

## how many packages?
data.tb <- data %>% as.tibble()
data.tb
View(data.tb)
#' Exploring the packages
names(data.tb)
data.tb

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
data.tb %>% 
  count(LibPath, Priority) # base 14; recommended 15; 262 NA

##   * what proportion need compilation?
data.tb %>% 
  count(NeedsCompilation) %>% 
  mutate(prop = n/sum(n))#42%

##   * how break down re: version of R they were built on
data.tb %>% 
  group_by(Built) %>%
  count(LibPath, Priority) 

data.tb %>% group_by(Built) %>%
  count(NeedsCompilation) %>% mutate(prop = n/sum(n))


## for tidyverts, here are some useful patterns
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))
data.tb %>% count(Built)
#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?


#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!
?installed.packages

