01\_explore-libraries\_comfy.R
================
jbedics
Wed Jan 31 14:05:53 2018

Which libraries does R search for packages?

``` r
# try .libPaths(), .Library
```

Installed packages

``` r
## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View() or similar to inspect
library(tidyverse)
```

    ## ── Attaching packages ─────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.7.2     ✔ stringr 1.2.0
    ## ✔ readr   1.1.1     ✔ forcats 0.2.0

    ## ── Conflicts ────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
data <- installed.packages()

## how many packages?
data.tb <- data %>% as.tibble()
data.tb
```

    ## # A tibble: 292 x 16
    ##    Package  LibPath  Version Priority Depends  Imports LinkingTo Suggests 
    ##    <chr>    <chr>    <chr>   <chr>    <chr>    <chr>   <chr>     <chr>    
    ##  1 abind    /Librar… 1.4-5   <NA>     R (>= 1… method… <NA>      <NA>     
    ##  2 acepack  /Librar… 1.4.1   <NA>     <NA>     <NA>    <NA>      testthat 
    ##  3 arm      /Librar… 1.9-3   <NA>     R (>= 3… abind,… <NA>      <NA>     
    ##  4 assertt… /Librar… 0.2.0   <NA>     <NA>     tools   <NA>      testthat 
    ##  5 babynam… /Librar… 0.3.0   <NA>     R (>= 2… tibble  <NA>      <NA>     
    ##  6 backpor… /Librar… 1.1.2   <NA>     R (>= 3… utils   <NA>      <NA>     
    ##  7 base     /Librar… 3.4.3   base     <NA>     <NA>    <NA>      methods  
    ##  8 base64e… /Librar… 0.1-3   <NA>     R (>= 2… <NA>    <NA>      <NA>     
    ##  9 bayespl… /Librar… 1.4.0   <NA>     R (>= 3… "dplyr… <NA>      "arm, gr…
    ## 10 betareg  /Librar… 3.1-0   <NA>     R (>= 3… "graph… <NA>      car, lat…
    ## # ... with 282 more rows, and 8 more variables: Enhances <chr>,
    ## #   License <chr>, License_is_FOSS <chr>, License_restricts_use <chr>,
    ## #   OS_type <chr>, MD5sum <chr>, NeedsCompilation <chr>, Built <chr>

``` r
View(data.tb)
```

Exploring the packages

``` r
names(data.tb)
```

    ##  [1] "Package"               "LibPath"              
    ##  [3] "Version"               "Priority"             
    ##  [5] "Depends"               "Imports"              
    ##  [7] "LinkingTo"             "Suggests"             
    ##  [9] "Enhances"              "License"              
    ## [11] "License_is_FOSS"       "License_restricts_use"
    ## [13] "OS_type"               "MD5sum"               
    ## [15] "NeedsCompilation"      "Built"

``` r
data.tb
```

    ## # A tibble: 292 x 16
    ##    Package  LibPath  Version Priority Depends  Imports LinkingTo Suggests 
    ##    <chr>    <chr>    <chr>   <chr>    <chr>    <chr>   <chr>     <chr>    
    ##  1 abind    /Librar… 1.4-5   <NA>     R (>= 1… method… <NA>      <NA>     
    ##  2 acepack  /Librar… 1.4.1   <NA>     <NA>     <NA>    <NA>      testthat 
    ##  3 arm      /Librar… 1.9-3   <NA>     R (>= 3… abind,… <NA>      <NA>     
    ##  4 assertt… /Librar… 0.2.0   <NA>     <NA>     tools   <NA>      testthat 
    ##  5 babynam… /Librar… 0.3.0   <NA>     R (>= 2… tibble  <NA>      <NA>     
    ##  6 backpor… /Librar… 1.1.2   <NA>     R (>= 3… utils   <NA>      <NA>     
    ##  7 base     /Librar… 3.4.3   base     <NA>     <NA>    <NA>      methods  
    ##  8 base64e… /Librar… 0.1-3   <NA>     R (>= 2… <NA>    <NA>      <NA>     
    ##  9 bayespl… /Librar… 1.4.0   <NA>     R (>= 3… "dplyr… <NA>      "arm, gr…
    ## 10 betareg  /Librar… 3.1-0   <NA>     R (>= 3… "graph… <NA>      car, lat…
    ## # ... with 282 more rows, and 8 more variables: Enhances <chr>,
    ## #   License <chr>, License_is_FOSS <chr>, License_restricts_use <chr>,
    ## #   OS_type <chr>, MD5sum <chr>, NeedsCompilation <chr>, Built <chr>

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
data.tb %>% 
  count(LibPath, Priority) # base 14; recommended 15; 262 NA
```

    ## # A tibble: 3 x 3
    ##   LibPath                                                 Priority       n
    ##   <chr>                                                   <chr>      <int>
    ## 1 /Library/Frameworks/R.framework/Versions/3.4/Resources… base          14
    ## 2 /Library/Frameworks/R.framework/Versions/3.4/Resources… recommend…    15
    ## 3 /Library/Frameworks/R.framework/Versions/3.4/Resources… <NA>         263

``` r
##   * what proportion need compilation?
data.tb %>% 
  count(NeedsCompilation) %>% 
  mutate(prop = n/sum(n))#42%
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <chr>            <int>  <dbl>
    ## 1 no                 155 0.531 
    ## 2 yes                124 0.425 
    ## 3 <NA>                13 0.0445

``` r
##   * how break down re: version of R they were built on
data.tb %>% 
  group_by(Built) %>%
  count(LibPath, Priority) 
```

    ## # A tibble: 6 x 4
    ## # Groups:   Built [4]
    ##   Built LibPath                                           Priority       n
    ##   <chr> <chr>                                             <chr>      <int>
    ## 1 3.4.0 /Library/Frameworks/R.framework/Versions/3.4/Res… <NA>         121
    ## 2 3.4.1 /Library/Frameworks/R.framework/Versions/3.4/Res… <NA>          37
    ## 3 3.4.2 /Library/Frameworks/R.framework/Versions/3.4/Res… <NA>          36
    ## 4 3.4.3 /Library/Frameworks/R.framework/Versions/3.4/Res… base          14
    ## 5 3.4.3 /Library/Frameworks/R.framework/Versions/3.4/Res… recommend…    15
    ## 6 3.4.3 /Library/Frameworks/R.framework/Versions/3.4/Res… <NA>          69

``` r
data.tb %>% group_by(Built) %>%
  count(NeedsCompilation) %>% mutate(prop = n/sum(n))
```

    ## # A tibble: 11 x 4
    ## # Groups:   Built [4]
    ##    Built NeedsCompilation     n   prop
    ##    <chr> <chr>            <int>  <dbl>
    ##  1 3.4.0 no                  77 0.636 
    ##  2 3.4.0 yes                 39 0.322 
    ##  3 3.4.0 <NA>                 5 0.0413
    ##  4 3.4.1 no                  23 0.622 
    ##  5 3.4.1 yes                 10 0.270 
    ##  6 3.4.1 <NA>                 4 0.108 
    ##  7 3.4.2 no                  17 0.472 
    ##  8 3.4.2 yes                 19 0.528 
    ##  9 3.4.3 no                  38 0.388 
    ## 10 3.4.3 yes                 56 0.571 
    ## 11 3.4.3 <NA>                 4 0.0408

``` r
## for tidyverts, here are some useful patterns
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))
data.tb %>% count(Built)
```

    ## # A tibble: 4 x 2
    ##   Built     n
    ##   <chr> <int>
    ## 1 3.4.0   121
    ## 2 3.4.1    37
    ## 3 3.4.2    36
    ## 4 3.4.3    98

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
```

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!
?installed.packages
```
