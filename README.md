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
rmarkdown::render("C:/Users/Stefa/OneDrive/Documents/GitHub/Project1new/docs/README.rmd",
 output_format = "github_document",
 output_file = "docs/README.md",
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

# API Interaction Functions

`Countries`

This function was created to interact with different Country endpoints
of the Covid API. This function will return a `data.frame` containing
Country data such as: Newly Confirmed Cases, Total Confirmed Cases, New
Deaths, Total Deaths, New Recovered, Total Recover and the current date
of each country.

``` r
Countries<- function(type="all", Country = "all"){
my_url<- GET("https://api.covid19api.com/summary")
my_result_text<- content(my_url, as = 'text')
my_result_json<- fromJSON(my_result_text, flatten = TRUE)
my_result_df<- as.data.frame(my_result_json)
my_result_df

#Pulling Country Data
data.by.Countries <-select(my_result_df, c('Countries.Country', 'Countries.CountryCode', 'Countries.NewConfirmed', 'Countries.TotalConfirmed', 'Countries.NewDeaths', 'Countries.TotalDeaths', 'Countries.NewRecovered', 'Countries.TotalRecovered', 'Countries.Date'))}
```

`Globes`

This function was created to interact with Global endpoints of the Covid
API. This function will return a `data.frame` containing Covid-19 data
for the globe such as: Newly Confirmed Cases, Total Confirmed Cases, New
Deaths, Total Deaths, New Recovered, Total Recover and the current date
of the world.

``` r
Globes<- function(type = "all", Country = "all"){
my_url<- GET("https://api.covid19api.com/summary")
my_result_text<- content(my_url, as = 'text')
my_result_json<- fromJSON(my_result_text, flatten = TRUE)
my_result_df<- as.data.frame(my_result_json)
my_result_df
data.by.Globe <-select(my_result_df, c('Global.NewConfirmed', 'Global.TotalConfirmed', 'Global.NewDeaths', 'Global.TotalDeaths', 'Global.NewRecovered', 'Global.TotalRecovered', 'Global.Date'))}
```

`SouthAfrica`

This function was created to interact with South Africas endpoints of
the Covid API. This function will return a `data.frame` containing
Covid-19 data for the country South Africa such as: Latitude, Longitude,
Cases, Status, and the current date.

``` r
SouthAfrica<- function(type = "all", Country = "all"){
my_url2<- GET("https://api.covid19api.com/dayone/country/south-africa/status/confirmed")
my_result_text2<- content(my_url2, as = 'text')
my_result_json2<- fromJSON(my_result_text2, flatten = TRUE)
my_result_json2}
```

`WIPlive`

This function will returns all live cases by case type for a country by
the date displayed. These records are pulled every 10 minutes and are
ungrouped.The cases must be one of: confirmed, recovered, deaths.

``` r
WIPlive<- function(type = "all", Country = "all"){
my_url<- GET("https://api.covid19api.com/world?from=2020-03-01T00:00:00Z&to=2020-04-01T00:00:00Z")
my_result_text<- content(my_url, as = 'text')
my_result_json<- fromJSON(my_result_text, flatten = TRUE)
my_result_df<- as.data.frame(my_result_json)
my_result_df}
```

`Daylive`

This function will returns all cases by case type for a country from the
first recorded case with the latest record being the live count. Cases
will appear as be one of the following: confirmed, recovered, deaths

``` r
Daylive<- function(type = "all", Country = "all"){
my_url4<- GET("https://api.covid19api.com/dayone/country/south-africa/status/confirmed/live
")
my_result_text<- content(my_url4, as = 'text')
my_result_json<- fromJSON(my_result_text, flatten = TRUE)
my_result_df<- as.data.frame(my_result_json)
my_result_df}
```

`Countrylive`

This function will returns all cases by case type for all countries from
the first recorded case with the latest record being the live count.
Cases will appear as be one of the following: confirmed, recovered,
deaths

``` r
Daylive<- function(type = "all", Country = "all"){
my_url5<- GET("https://api.covid19api.com/country/south-africa/status/confirmed/live?from=2020-03-01T00:00:00Z&to=2020-04-01T00:00:00Z")
my_result_text<- content(my_url5, as = 'text')
my_result_json<- fromJSON(my_result_text, flatten = TRUE)
my_result_df<- as.data.frame(my_result_json)
my_result_df}
```

# Data Exploration

Here we will be interact with a few of the endpoints of the Covid-19
Data. Mainly, the Countries and Global Data

# Creating Two new variables

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

tab2<- table(data.by.Countries$Countries.Date, data.by.Countries$Countries.NewDeaths)
tab2

tab3<- table(data.by.Countries$Countries.Date, data.by.Countries$Countries.TotalDeaths)
tab3
```

# Numerical Summaries for some Quantitative Variables

Numerical summaries provide all results from summary this can include
the min, Q1, mean, median, Q3, and max and a valid sample size

``` r
#Numerical Summary of variables by each country
summary(data.by.Countries)

#Numerical Summary of variables by Globe
summary(data.by.Globe)
```

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


#2. Histogram
ggplot(data=data.by.Countries, aes(data.by.Countries$Countries.NewConfirmed)) + 
  geom_histogram()


qplot(data.by.Countries$Countries.NewConfirmed,
      geom="histogram",
      binwidth = 1,  
      main = "Number of Countries of NewConfirmed Cases", 
      xlab = "Countries",  
      fill=I("blue"), 
      col=I("red"), 
      alpha=I(.2),
      xlim=c(20,50))
#3. Box Plot

#Sept daily cases of 5 countries
data.by.Countries%>% filter(grepl('China|Korea|United States|United Kingdom|Italy|Spain',Countries.Country) & Countries.Date >= '2021-09-02') %>% ggplot(data.by.Countries, mapping = aes(x=Countries.Date, y = Countries.Country)) + geom_boxplot() + geom_point(mapping = aes(color = Countries.Country) , position = "jitter", size = 2) + labs(title = "Boxplot for Weight") + coord_flip()


#4. Scatter Plot
data.by.Countries %>% select(Countries.Country, Countries.TotalConfirmed, Countries.TotalDeaths, Countries.TotalRecovered) %>% 
group_by(Countries.Country) %>% 
summarise(dead = sum(Countries.TotalDeaths) ,confirmed = sum(Countries.TotalConfirmed)) %>% ggplot(aes(x = confirmed, y = dead)) + geom_point() + labs(title = 'Scatter Plot', y= "Total Deaths", x = "Total Confirmed")


#5. Extra Plot b 
my_result_json2 %>% 
  select(Country, Date, Cases) %>% 
  filter(Country == 'South Africa') %>% 
  group_by(Country, Date) %>% 
  summarise(Cases = sum(Cases)) %>% ggplot(aes(x = Date, y = Cases, group = )) + geom_line(color = 'red')
```
