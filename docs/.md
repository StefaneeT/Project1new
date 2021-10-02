Project 1
================
Stefanee Tillman
9/25/2021

This is a vignette to show how to get data from an API. In this vignette
we will be exploring data from a COVID-19 API. To begin, I will create a
few functions to interact with two of the endpoints and explore some of
the data I can retrieve Globally and by Country.

Some of these functions return data at a Global level and some of the
APIs use the data by specified Country. A recommendation is to supply a
full Country name (e.g. “Afghanistan”).

``` r
rmarkdown::render("C:/Users/Stefa/OneDrive/Documents/GitHub/Project1new/README.rmd",
 output_format = "github_document",
 output_file = "docs",
 output_options = list(
 toc = FALSE,
 toc_depth = 3,
 number_sections = FALSE,
 df_print = "default",
keep_html = FALSE
))
```

# Required Packages

In this section shows the required packages needed to create this
project.

• `rmarkdown()` to convert rmarkdown using the render() function.

• `knitr()` produces flexible designs and finer control of graphics.

• `tidyverse()` to generate plots, use chaining/piping, and manipulate
data.

• `jsonlite()` to convert between JSON data and R objects.

• `vignette()` to view and display vignette.

# Data Exploration/Pulling Data

Here we will pull the data using the head function to begin modeling

``` r
#Get the data end points from the API
my_url<- GET("https://api.covid19api.com/summary")
my_result_text<- content(my_url, as = 'text')
my_result_json<- fromJSON(my_result_text, flatten = TRUE)
my_result_df<- as.data.frame(my_result_json)
my_result_df

#Pulling Country Data
data.by.Countries <-select(my_result_df, c('Countries.Country', 'Countries.CountryCode', 'Countries.NewConfirmed', 'Countries.TotalConfirmed', 'Countries.NewDeaths', 'Countries.TotalDeaths', 'Countries.NewRecovered', 'Countries.TotalRecovered', 'Countries.Date'))



#Pulling Global Data
data.by.Globe <-select(my_result_df, c('Global.NewConfirmed', 'Global.TotalConfirmed', 'Global.NewDeaths', 'Global.TotalDeaths', 'Global.NewRecovered', 'Global.TotalRecovered', 'Global.Date'))

#Pulling Day one Data
SouthAfrica<- function(type = "all", Country = "all"){
my_url2<- GET("https://api.covid19api.com/dayone/country/south-africa/status/confirmed")
my_result_text2<- content(my_url2, as = 'text')
my_result_json2<- fromJSON(my_result_text2, flatten = TRUE)
my_result_json2}
```

\# Two new added variables

Here two new variables are created to display the cumulative sum of the
variable “Countries.NewConfirmed” which displays the new confirmed
Covid-19 cases by country and the cumulative sum of the
“Countries.NewDeaths” which displays the new deaths from Covid-19 by
country.There is also the daily confirm South-Africa Cases.

``` r
require(tidyverse)
require(dplyr)

#Create two new variables 
data.by.Countries<- data.by.Countries %>%  mutate(cumsum1 = cumsum(data.by.Countries$Countries.NewConfirmed), cumsum2 = cumsum(data.by.Countries$Countries.NewDeaths))
data.by.Countries
```

# Contingency Tables

A contingency table is a way to redraw data and assemble it into a
table. A contingency table will show the original data in a manner that
allows the reader to gain an overall summary of the original data
provided.

The table `tab1` displays the number of new confirmed Covid-19 cases as
of the specified date.

The table `tab2` displays the number of new Covid-19 deaths as of the
specified date.

The table `tab3` displays the number of Total Covid-19 Deaths as of the
specified date.

``` r
tab1<- table(data.by.Countries$Countries.Date, data.by.Countries$Countries.NewConfirmed)
tab1
```

    ##                          
    ##                            0  1  2  3  6  7  8  9 10 14 19 21 23 25 33 34 35
    ##   2021-10-04T01:54:20.88Z 77  1  2  1  1  2  1  1  1  1  1  1  2  1  1  1  1
    ##                          
    ##                           42 45 48 49 60 61 62 71 72 74 79 89 91 113 119 132
    ##   2021-10-04T01:54:20.88Z  1  1  3  1  1  1  1  1  1  1  1  1  1   1   1   1
    ##                          
    ##                           159 184 186 199 224 284 301 309 336 340 356 386 388
    ##   2021-10-04T01:54:20.88Z   1   1   1   1   1   1   1   1   1   1   1   1   1
    ##                          
    ##                           449 467 504 513 529 530 556 560 573 574 617 629 658
    ##   2021-10-04T01:54:20.88Z   1   1   1   1   1   1   1   1   1   1   1   1   1
    ##                          
    ##                           697 712 748 768 802 809 813 872 907 944 1033 1037
    ##   2021-10-04T01:54:20.88Z   1   1   1   1   1   1   1   1   1   1    1    1
    ##                          
    ##                           1051 1090 1142 1164 1194 1252 1381 1497 1615 1638
    ##   2021-10-04T01:54:20.88Z    1    1    2    1    1    1    1    1    1    1
    ##                          
    ##                           1656 1658 1728 1872 1899 2057 2152 2270 2445 2451
    ##   2021-10-04T01:54:20.88Z    1    1    1    1    1    1    1    1    1    1
    ##                          
    ##                           3309 4097 4887 5334 5376 6482 7369 8682 10828 10915
    ##   2021-10-04T01:54:20.88Z    1    1    1    1    1    1    1    1     1     1
    ##                          
    ##                           12396 12428 13226 13466 22842 24632 27351 29520
    ##   2021-10-04T01:54:20.88Z     1     1     1     1     1     1     1     1
    ##                          
    ##                           39206
    ##   2021-10-04T01:54:20.88Z     1

``` r
tab2<- table(data.by.Countries$Countries.Date, data.by.Countries$Countries.NewDeaths)
tab2
```

    ##                          
    ##                            0  1  2  3  4  5  6  7  8  9 10 12 13 14 15 18 19
    ##   2021-10-04T01:54:20.88Z 99 10  9  6  1  4  4  3  1  1  2  3  1  3  1  2  1
    ##                          
    ##                           21 22 23 24 25 27 29 30 31 32 33 35 36 37 40 43 46
    ##   2021-10-04T01:54:20.88Z  2  3  1  1  3  1  1  1  1  1  1  1  1  1  1  2  1
    ##                          
    ##                           47 48 49 58 77 109 112 114 124 150 194 216 229 244
    ##   2021-10-04T01:54:20.88Z  1  1  1  1  1   1   1   1   1   1   1   1   1   1
    ##                          
    ##                           468 614 647 873
    ##   2021-10-04T01:54:20.88Z   1   1   1   1

``` r
tab3<- table(data.by.Countries$Countries.Date, data.by.Countries$Countries.TotalDeaths)
tab3
```

    ##                          
    ##                           0 1 3 13 22 27 28 33 38 42 43 52 60 79 84 91 100
    ##   2021-10-04T01:54:20.88Z 7 1 1  1  2  1  1  2  1  1  1  1  1  1  2  1   1
    ##                          
    ##                           112 113 118 121 125 130 135 147 154 159 169 174 187
    ##   2021-10-04T01:54:20.88Z   1   1   1   1   1   2   1   2   1   1   1   1   1
    ##                          
    ##                           190 197 203 204 207 231 233 234 286 338 342 379 418
    ##   2021-10-04T01:54:20.88Z   1   1   1   1   1   1   1   1   1   1   1   1   1
    ##                          
    ##                           459 533 549 552 606 611 633 634 640 719 778 799 835
    ##   2021-10-04T01:54:20.88Z   1   1   1   1   1   1   1   1   1   1   1   1   1
    ##                          
    ##                           843 861 901 958 1078 1084 1111 1156 1224 1247 1283
    ##   2021-10-04T01:54:20.88Z   1   1   1   1    1    1    1    1    1    1    1
    ##                          
    ##                           1333 1334 1363 1389 1459 1505 1577 1734 1860 1909
    ##   2021-10-04T01:54:20.88Z    1    1    1    1    1    1    1    1    1    1
    ##                          
    ##                           1918 1934 2102 2265 2284 2368 2383 2452 2507 2607
    ##   2021-10-04T01:54:20.88Z    1    1    1    1    1    1    1    1    1    1
    ##                          
    ##                           2665 2713 2724 2741 2906 2961 3160 3277 3516 3649
    ##   2021-10-04T01:54:20.88Z    1    1    1    1    1    1    1    1    1    1
    ##                          
    ##                           4055 4096 4144 4188 4495 4574 4627 4686 4849 5063
    ##   2021-10-04T01:54:20.88Z    1    1    1    1    1    1    1    1    1    1
    ##                          
    ##                           5140 5249 5372 5722 5822 6057 6413 6573 6704 6854
    ##   2021-10-04T01:54:20.88Z    1    1    1    1    1    1    1    1    1    1
    ##                          
    ##                           7206 7236 7580 7821 8348 8380 8678 8716 9038 9854
    ##   2021-10-04T01:54:20.88Z    1    1    1    1    1    1    1    1    1    1
    ##                          
    ##                           10635 10742 11026 11093 11164 12668 13059 13730
    ##   2021-10-04T01:54:20.88Z     1     1     1     1     1     1     1     1
    ##                          
    ##                           14339 14868 14920 15907 16200 17014 17436 17730
    ##   2021-10-04T01:54:20.88Z     1     1     1     1     1     1     1     1
    ##                          
    ##                           17883 17993 18181 18762 19715 21038 22365 24921
    ##   2021-10-04T01:54:20.88Z     1     1     1     1     1     1     1     1
    ##                          
    ##                           25264 25612 26565 27573 27866 30199 30478 32791
    ##   2021-10-04T01:54:20.88Z     1     1     1     1     1     1     1     1
    ##                          
    ##                           37484 37544 38768 60380 64434 75695 86463 87780
    ##   2021-10-04T01:54:20.88Z     1     1     1     1     1     1     1     1
    ##                          
    ##                           93791 115245 117578 121109 126372 130998 137295
    ##   2021-10-04T01:54:20.88Z     1      1      1      1      1      1      1
    ##                          
    ##                           142173 199423 205297 278592 448817 597723 700932
    ##   2021-10-04T01:54:20.88Z      1      1      1      1      1      1      1

# Numerical Summaries for some Quantitative Variables

Numerical summaries provide all results from summary this can include
the min, Q1, mean, median, Q3, and max and a valid sample size

``` r
#Numerical Summary of variables by each country
summary(data.by.Countries)
```

    ##  Countries.Country  Countries.CountryCode Countries.NewConfirmed
    ##  Length:192         Length:192            Min.   :    0.0       
    ##  Class :character   Class :character      1st Qu.:    0.0       
    ##  Mode  :character   Mode  :character      Median :   38.5       
    ##                                           Mean   : 1662.7       
    ##                                           3rd Qu.:  776.5       
    ##                                           Max.   :39206.0       
    ##  Countries.TotalConfirmed Countries.NewDeaths Countries.TotalDeaths
    ##  Min.   :       1         Min.   :  0.00      Min.   :     0.0     
    ##  1st Qu.:   20920         1st Qu.:  0.00      1st Qu.:   233.8     
    ##  Median :  160917         Median :  0.00      Median :  2479.5     
    ##  Mean   : 1220968         Mean   : 28.01      Mean   : 24980.7     
    ##  3rd Qu.:  634808         3rd Qu.: 13.25      3rd Qu.: 12765.8     
    ##  Max.   :43657833         Max.   :873.00      Max.   :700932.0     
    ##  Countries.NewRecovered Countries.TotalRecovered Countries.Date    
    ##  Min.   :0              Min.   :0                Length:192        
    ##  1st Qu.:0              1st Qu.:0                Class :character  
    ##  Median :0              Median :0                Mode  :character  
    ##  Mean   :0              Mean   :0                                  
    ##  3rd Qu.:0              3rd Qu.:0                                  
    ##  Max.   :0              Max.   :0                                  
    ##     cumsum1          cumsum2      
    ##  Min.   :     0   Min.   :   0.0  
    ##  1st Qu.: 34227   1st Qu.: 776.8  
    ##  Median :102222   Median :1727.0  
    ##  Mean   :107071   Mean   :2074.0  
    ##  3rd Qu.:179693   3rd Qu.:3828.0  
    ##  Max.   :319238   Max.   :5378.0

``` r
#Numerical Summary of variables by Globe
summary(data.by.Globe)
```

    ##  Global.NewConfirmed Global.TotalConfirmed Global.NewDeaths
    ##  Min.   :319238      Min.   :234425950     Min.   :5378    
    ##  1st Qu.:319238      1st Qu.:234425950     1st Qu.:5378    
    ##  Median :319238      Median :234425950     Median :5378    
    ##  Mean   :319238      Mean   :234425950     Mean   :5378    
    ##  3rd Qu.:319238      3rd Qu.:234425950     3rd Qu.:5378    
    ##  Max.   :319238      Max.   :234425950     Max.   :5378    
    ##  Global.TotalDeaths Global.NewRecovered Global.TotalRecovered
    ##  Min.   :4796297    Min.   :0           Min.   :0            
    ##  1st Qu.:4796297    1st Qu.:0           1st Qu.:0            
    ##  Median :4796297    Median :0           Median :0            
    ##  Mean   :4796297    Mean   :0           Mean   :0            
    ##  3rd Qu.:4796297    3rd Qu.:0           3rd Qu.:0            
    ##  Max.   :4796297    Max.   :0           Max.   :0            
    ##  Global.Date       
    ##  Length:192        
    ##  Class :character  
    ##  Mode  :character  
    ##                    
    ##                    
    ## 

# Create Five plots

Plots provide viewers with a visualization of the data and the
distribution of the dataset. It also will show how variables relate to
one another.

``` r
#1. Barplot
data.by.Countries %>% filter(grepl('China|Korea|United States|United Kingdom|Italy|Spain',Countries.Country) & Countries.Date > '2021-10-02') %>% 
  select(Countries.Country, Countries.NewConfirmed) %>% 
  group_by(Countries.Country) %>% 
  summarise(Countries.NewConfirmed = sum(Countries.NewConfirmed)) %>% 
  arrange(-Countries.NewConfirmed) %>% 
  top_n(15) %>% 
  ggplot(aes(y = fct_reorder(Countries.Country, Countries.NewConfirmed), x = Countries.NewConfirmed)) +
    geom_bar(stat = 'identity', fill = 'darkred') + labs(title = 'Highest Covid-19 Confirmed Cases by Country', y= "Countries", x = "New Confirmed Cases")
```

    ## Selecting by Countries.NewConfirmed

![](docs/_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

``` r
#2. Histogram
ggplot(data=data.by.Countries, aes(data.by.Countries$Countries.NewConfirmed)) + 
  geom_histogram()
```

    ## Warning: Use of `data.by.Countries$Countries.NewConfirmed` is discouraged. Use
    ## `Countries.NewConfirmed` instead.

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](docs/_files/figure-gfm/unnamed-chunk-9-2.png)<!-- -->

``` r
qplot(data.by.Countries$Countries.NewConfirmed,
      geom="histogram",
      binwidth = 1,  
      main = "Number of Countries of NewConfirmed Cases", 
      xlab = "Countries",  
      fill=I("blue"), 
      col=I("red"), 
      alpha=I(.2),
      xlim=c(20,50))
```

    ## Warning: Removed 179 rows containing non-finite values (stat_bin).

    ## Warning: Removed 2 rows containing missing values (geom_bar).

![](docs/_files/figure-gfm/unnamed-chunk-9-3.png)<!-- -->

``` r
#3. Box Plot

#Sept daily cases of 5 countries
data.by.Countries%>% filter(grepl('China|Korea|United States|United Kingdom|Italy|Spain',Countries.Country) & Countries.Date >= '2021-09-02') %>% ggplot(data.by.Countries, mapping = aes(x=Countries.Date, y = Countries.Country)) + geom_boxplot() + geom_point(mapping = aes(color = Countries.Country) , position = "jitter", size = 2) + labs(title = "Boxplot for Weight") + coord_flip()
```

![](docs/_files/figure-gfm/unnamed-chunk-9-4.png)<!-- -->

``` r
#4. Scatter Plot
data.by.Countries %>% select(Countries.Country, Countries.TotalConfirmed, Countries.TotalDeaths, Countries.TotalRecovered) %>% 
group_by(Countries.Country) %>% 
summarise(dead = sum(Countries.TotalDeaths) ,confirmed = sum(Countries.TotalConfirmed)) %>% ggplot(aes(x = confirmed, y = dead)) + geom_point() + labs(title = 'Scatter Plot', y= "Total Deaths", x = "Total Confirmed")
```

![](docs/_files/figure-gfm/unnamed-chunk-9-5.png)<!-- -->

``` r
#5. Extra Plot b 
my_result_json2 %>% 
  select(Country, Date, Cases) %>% 
  filter(Country == 'South Africa') %>% 
  group_by(Country, Date) %>% 
  summarise(Cases = sum(Cases)) %>% ggplot(aes(x = Date, y = Cases, group = )) + geom_line(color = 'red')
```

    ## `summarise()` has grouped output by 'Country'. You can override using the `.groups` argument.

    ## geom_path: Each group consists of only one observation. Do you need to
    ## adjust the group aesthetic?

![](docs/_files/figure-gfm/unnamed-chunk-9-6.png)<!-- -->
