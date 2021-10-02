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
rmarkdown::render("C:/Users/Stefa/OneDrive/Documents/GitHub/Project1new/Project1new.rmd",
 output_format = "github_document",
 output_file = "README.md",
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
my_url2<- GET("https://api.covid19api.com/dayone/country/south-africa/status/confirmed")
my_result_text2<- content(my_url2, as = 'text')
my_result_json2<- fromJSON(my_result_text2, flatten = TRUE)
my_result_json2
```

\#Two new added variables

Here two new variables are created to display the cumulative sum of the
variable “Countries.NewConfirmed” which displays the new confirmed
Covid-19 cases by country and the cumulative sum of the
“Countries.NewDeaths” which displays the new deaths from Covid-19 by
country.There is also the daily confirm South-Africa Cases.

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
#table() creates contingency tables

tab1<- table(data.by.Countries$Countries.Date, data.by.Countries$Countries.NewConfirmed)
tab1
```

    ##                           
    ##                             0  1 10 11 12 14 18 23 24 27 28 29 30 31 33 34 35
    ##   2021-10-04T00:43:23.686Z 63  1  2  2  1  2  1  1  1  1  4  1  1  2  2  1  1
    ##                           
    ##                            38 41 45 47 56 58 63 66 67 72 76 86 99 105 115 124
    ##   2021-10-04T00:43:23.686Z  1  2  1  1  1  2  1  1  1  1  1  1  2   1   1   1
    ##                           
    ##                            140 174 181 183 217 227 236 242 256 292 298 309
    ##   2021-10-04T00:43:23.686Z   1   1   1   1   1   1   1   1   1   1   1   1
    ##                           
    ##                            348 414 435 458 466 471 527 548 549 589 606 659
    ##   2021-10-04T00:43:23.686Z   1   1   1   1   1   1   1   1   1   1   1   1
    ##                           
    ##                            660 684 690 702 724 742 761 813 821 822 855 886
    ##   2021-10-04T00:43:23.686Z   1   1   1   1   1   1   1   1   1   1   1   1
    ##                           
    ##                            888 991 993 1152 1190 1228 1236 1252 1306 1344
    ##   2021-10-04T00:43:23.686Z   1   1   1    1    1    1    1    1    1    1
    ##                           
    ##                            1347 1400 1414 1416 1448 1497 1586 1656 1658 1728
    ##   2021-10-04T00:43:23.686Z    1    1    1    1    1    1    1    1    1    1
    ##                           
    ##                            1798 1826 1872 1998 2085 2111 2132 2309 2356 2407
    ##   2021-10-04T00:43:23.686Z    1    1    1    1    1    1    1    1    1    1
    ##                           
    ##                            3309 4272 4873 5261 5490 6412 6482 7369 10135
    ##   2021-10-04T00:43:23.686Z    1    1    1    1    1    1    1    1     1
    ##                           
    ##                            10915 11375 12396 12590 13466 14686 22842 24632
    ##   2021-10-04T00:43:23.686Z     1     1     1     1     1     1     1     1
    ##                           
    ##                            27973 29520 39206
    ##   2021-10-04T00:43:23.686Z     1     1     1

``` r
tab2<- table(data.by.Countries$Countries.Date, data.by.Countries$Countries.NewDeaths)
tab2
```

    ##                           
    ##                             0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
    ##   2021-10-04T00:43:23.686Z 87 16  4  6  8  5  2  4  3  2  2  1  2  1  3  2  1
    ##                           
    ##                            17 20 22 23 24 25 26 27 29 32 35 36 38 42 43 45 46
    ##   2021-10-04T00:43:23.686Z  2  1  1  1  2  2  2  1  2  2  1  1  1  1  1  1  1
    ##                           
    ##                            48 51 55 75 87 89 109 124 163 164 184 203 216 217
    ##   2021-10-04T00:43:23.686Z  2  1  1  1  1  1   1   1   1   1   1   1   1   1
    ##                           
    ##                            244 468 614 647 873
    ##   2021-10-04T00:43:23.686Z   1   1   1   1   1

``` r
tab3<- table(data.by.Countries$Countries.Date, data.by.Countries$Countries.TotalDeaths)
tab3
```

    ##                           
    ##                            0 1 3 13 21 26 27 33 38 42 43 52 60 79 84 91 100
    ##   2021-10-04T00:43:23.686Z 7 1 1  1  2  1  1  2  1  1  1  1  1  1  2  1   1
    ##                           
    ##                            107 112 118 121 125 130 135 147 154 159 169 174
    ##   2021-10-04T00:43:23.686Z   1   1   1   1   1   2   1   2   1   1   1   1
    ##                           
    ##                            187 190 197 203 204 207 230 231 234 286 338 340
    ##   2021-10-04T00:43:23.686Z   1   1   1   1   1   1   1   1   1   1   1   1
    ##                           
    ##                            379 418 459 533 549 552 606 611 632 634 636 719
    ##   2021-10-04T00:43:23.686Z   1   1   1   1   1   1   1   1   1   1   1   1
    ##                           
    ##                            777 796 835 843 861 901 958 1078 1084 1111 1156
    ##   2021-10-04T00:43:23.686Z   1   1   1   1   1   1   1    1    1    1    1
    ##                           
    ##                            1224 1245 1281 1333 1334 1360 1389 1459 1500 1574
    ##   2021-10-04T00:43:23.686Z    1    1    1    1    1    1    1    1    1    1
    ##                           
    ##                            1734 1859 1884 1918 1932 2100 2265 2283 2360 2368
    ##   2021-10-04T00:43:23.686Z    1    1    1    1    1    1    1    1    1    1
    ##                           
    ##                            2451 2507 2607 2665 2710 2724 2731 2904 2959 3159
    ##   2021-10-04T00:43:23.686Z    1    1    1    1    1    1    1    1    1    1
    ##                           
    ##                            3262 3515 3649 4055 4096 4132 4174 4483 4569 4625
    ##   2021-10-04T00:43:23.686Z    1    1    1    1    1    1    1    1    1    1
    ##                           
    ##                            4664 4849 5041 5131 5249 5354 5675 5819 6057 6413
    ##   2021-10-04T00:43:23.686Z    1    1    1    1    1    1    1    1    1    1
    ##                           
    ##                            6559 6683 6829 7206 7236 7534 7778 8331 8341 8664
    ##   2021-10-04T00:43:23.686Z    1    1    1    1    1    1    1    1    1    1
    ##                           
    ##                            8716 9005 9854 10635 10736 11021 11093 11157 12649
    ##   2021-10-04T00:43:23.686Z    1    1    1     1     1     1     1     1     1
    ##                           
    ##                            13019 13700 14315 14868 14889 15907 16200 16937
    ##   2021-10-04T00:43:23.686Z     1     1     1     1     1     1     1     1
    ##                           
    ##                            17399 17730 17835 17986 18181 18750 19601 20995
    ##   2021-10-04T00:43:23.686Z     1     1     1     1     1     1     1     1
    ##                           
    ##                            22344 24921 25264 25612 26565 27555 27866 30199
    ##   2021-10-04T00:43:23.686Z     1     1     1     1     1     1     1     1
    ##                           
    ##                            30477 32762 37394 37484 38656 60380 64240 75689
    ##   2021-10-04T00:43:23.686Z     1     1     1     1     1     1     1     1
    ##                           
    ##                            86463 87753 93791 115239 117578 120880 126372
    ##   2021-10-04T00:43:23.686Z     1     1     1      1      1      1      1
    ##                           
    ##                            130998 137295 142115 199423 205297 278592 448817
    ##   2021-10-04T00:43:23.686Z      1      1      1      1      1      1      1
    ##                           
    ##                            597723 700932
    ##   2021-10-04T00:43:23.686Z      1      1

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
    ##  Mode  :character   Mode  :character      Median :   64.5       
    ##                                           Mean   : 1774.5       
    ##                                           3rd Qu.:  991.5       
    ##                                           Max.   :39206.0       
    ##  Countries.TotalConfirmed Countries.NewDeaths Countries.TotalDeaths
    ##  Min.   :       1         Min.   :  0.00      Min.   :     0.0     
    ##  1st Qu.:   20920         1st Qu.:  0.00      1st Qu.:   233.2     
    ##  Median :  160389         Median :  1.00      Median :  2479.0     
    ##  Mean   : 1220247         Mean   : 29.68      Mean   : 24970.8     
    ##  3rd Qu.:  634125         3rd Qu.: 14.00      3rd Qu.: 12741.5     
    ##  Max.   :43657833         Max.   :873.00      Max.   :700932.0     
    ##  Countries.NewRecovered Countries.TotalRecovered Countries.Date    
    ##  Min.   :0              Min.   :0                Length:192        
    ##  1st Qu.:0              1st Qu.:0                Class :character  
    ##  Median :0              Median :0                Mode  :character  
    ##  Mean   :0              Mean   :0                                  
    ##  3rd Qu.:0              3rd Qu.:0                                  
    ##  Max.   :0              Max.   :0                                  
    ##     cumsum1          cumsum2    
    ##  Min.   :     0   Min.   :   0  
    ##  1st Qu.: 37086   1st Qu.: 786  
    ##  Median :110398   Median :1788  
    ##  Mean   :116382   Mean   :2159  
    ##  3rd Qu.:198782   3rd Qu.:4009  
    ##  Max.   :340712   Max.   :5699

``` r
#Numerical Summary of variables by Globe
summary(data.by.Globe)
```

    ##  Global.NewConfirmed Global.TotalConfirmed Global.NewDeaths
    ##  Min.   :340712      Min.   :234287358     Min.   :5699    
    ##  1st Qu.:340712      1st Qu.:234287358     1st Qu.:5699    
    ##  Median :340712      Median :234287358     Median :5699    
    ##  Mean   :340712      Mean   :234287358     Mean   :5699    
    ##  3rd Qu.:340712      3rd Qu.:234287358     3rd Qu.:5699    
    ##  Max.   :340712      Max.   :234287358     Max.   :5699    
    ##  Global.TotalDeaths Global.NewRecovered Global.TotalRecovered
    ##  Min.   :4794400    Min.   :0           Min.   :0            
    ##  1st Qu.:4794400    1st Qu.:0           1st Qu.:0            
    ##  Median :4794400    Median :0           Median :0            
    ##  Mean   :4794400    Mean   :0           Mean   :0            
    ##  3rd Qu.:4794400    3rd Qu.:0           3rd Qu.:0            
    ##  Max.   :4794400    Max.   :0           Max.   :0            
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
