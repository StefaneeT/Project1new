Project 1
================
Stefanee Tillman
10/04/2021

This is a vignette to show how to get data from an API. In this vignette
we will be exploring data from a COVID-19 API. To begin, I will create a
few functions to interact with two of the endpoints and explore some of
the data I can retrieve Globally and by Country.

Some of these functions return data at a Global level and some of the
APIs use the data by specified Country. A recommendation is to supply a
full Country name (e.g. “Afghanistan”).

``` r
rmarkdown::render("C:/Users/Stefa/OneDrive/Documents/GitHub/Project1new/README.Rmd",
 output_format = "github_document",
 output_file = "docs/",
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

`Summary.Covid`

This function was created to interact with different Country and Global
endpoints of the Covid API. This function will return a `data.frame`
containing Country and Global data such as: Newly Confirmed Cases, Total
Confirmed Cases, New Deaths, Total Deaths, New Recovered, Total Recover
and the current date of each country.

``` r
Summary.Covid<- function(type = "all", country = "all"){
my_url<- GET("https://api.covid19api.com/summary")
my_result_text<- content(my_url, as = 'text')
my_result_json<- fromJSON(my_result_text, flatten = TRUE)
my_result_df<- as.data.frame(my_result_json)
my_result_df

if(type =="country"){
my_result_df

data.by.Countries <-select(my_result_df, c('Countries.Country', 'Countries.CountryCode', 'Countries.NewConfirmed', 'Countries.TotalConfirmed', 'Countries.NewDeaths', 'Countries.TotalDeaths', 'Countries.NewRecovered', 'Countries.TotalRecovered', 'Countries.Date'))

#Creating Two New Variables
data.by.Countries<- data.by.Countries %>%  mutate(cumsum1 = cumsum(data.by.Countries$Countries.NewConfirmed), cumsum2 = cumsum(data.by.Countries$Countries.NewDeaths))
data.by.Countries
#Here two new variables are created to display the cumulative sum of the variable "Countries.NewConfirmed" which displays the new confirmed Covid-19 cases by country and the cumulative sum of the "Countries.NewDeaths" which displays the new deaths from Covid-19 by country.There is also the daily confirm South-Africa Cases.

}
else if(type == "global"){
  
#Pulling Global Data
data.by.Globe <-select(my_result_df, c('Global.NewConfirmed', 'Global.TotalConfirmed', 'Global.NewDeaths', 'Global.TotalDeaths', 'Global.NewRecovered', 'Global.TotalRecovered', 'Global.Date'))

}}
```

`Country.pull`

This function was created to interact with country endpoints of the
Covid API. This function will return a `data.frame` containing Covid-19
data for the country such as: Name, Code, and Slug,

``` r
Country.pull<- function(country, Type){
my_url<- GET("https://api.covid19api.com/countries")
my_result_text<- content(my_url, as = 'text')
my_result_json<- fromJSON(my_result_text, flatten = TRUE)
my_result_json

Type<- tolower((Type))

if(Type == "country"){
show<- my_result_json %>% filter(Country == country) %>% select(Slug)
}else if(Type == "slug"){
show<- my_result_json %>% filter(Country == country) %>% select(Slug)
}}
return(my_result_json)
```

`Daylive`

This function will returns all cases by case type for a country from the
first recorded case with the latest record being the live count. Cases
will appear as be one of the following: confirmed, recovered, deaths

``` r
Daylive<- function(type = "all", Country = "all"){
my_url<- GET("https://api.covid19api.com/dayone/country/south-africa/status/confirmed/live")
my_result_text<- content(my_url, as = 'text')
my_result_json<- fromJSON(my_result_text, flatten = TRUE)
if(type == "Status")}
}else if(Type == "Cases"){
show<- my_result_json %>% filter(Country == country) %>% select(Status)
}
```

`Countrylive`

This function will returns all cases by case type for all countries from
the first recorded case with the latest record being the live count.
Cases will appear as be one of the following: confirmed, recovered,
deaths

``` r
Daylive<- function(type = "all", Status = "all"){
my_url<- GET("https://api.covid19api.com/country/south-africa/status/confirmed/live?from=2020-03-01T00:00:00Z&to=2020-04-01T00:00:00Z")
my_result_text<- content(my_url, as = 'text')
my_result_json<- fromJSON(my_result_text, flatten = TRUE)
my_result_json
if(type == "Confirmed", "Recovered", "Deaths"){
show<- my_result_json %>% filter(Status == status) %>% select(Confirmed)
}else if(Type == "Recovered"){
show<- my_result_json %>% filter(Status == status) %>% select(Confirmed)
}}
return(my_result_json)
```

`gather`

This function will gather all needed data from previously made functions

``` r
gather<- function(type, ...){
  type<- tolower(type)
  if(func == "Summary.Covid")
{
    table<- Summary.covid(...)
  } else if (type == "Country.pull"){
    table<- Country.pull()
  }}
return(table)
```

# Data Exploration

Here we will be interact with a few of the endpoints of the Covid-19
Data. Mainly, the Countries and Global Data

``` r
require(tidyverse)
require(dplyr)
```

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
![plot](https://raw.githubusercontent.com/StefaneeT/Project1new/main/images/Contingency Table 1.png)

```r
tab2<- table(data.by.Countries$Countries.Date, data.by.Countries$Countries.NewDeaths)
tab2
```
![plot](https://raw.githubusercontent.com/StefaneeT/Project1new/main/images/Contingency Table 2.png)


```r
tab3<- table(data.by.Countries$Countries.Date, data.by.Countries$Countries.TotalDeaths)
tab3
```

![plot](https://raw.githubusercontent.com/StefaneeT/Project1new/main/images/Contingency Table 2.png)

Numerical summaries provide all results from summary this can include
the min, Q1, mean, median, Q3, and max and a valid sample size

``` r
#Numerical Summary of variables by each country
Summary<-summary(data.by.Countries)
```
![plot](https://raw.githubusercontent.com/StefaneeT/Project1new/main/images/Country Numerical Summary.png)

```r
#Numerical Summary of variables by Globe
summary(data.by.Globe)
```
![plot](https://raw.githubusercontent.com/StefaneeT/Project1new/main/images/Global Numerical Summary.png)



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
    geom_bar(stat = 'identity', fill = 'pink') + labs(title = 'Highest Covid-19 Confirmed Cases by Country', y= "Countries", x = "New Confirmed Cases")
```
![plot](https://raw.githubusercontent.com/StefaneeT/Project1new/main/images/ProjectBarplot.jpg)

From this bargraph graph, we can observe that between the countries
China, South Korea, United States, United Kingdom, Italy, and Spain the
United States has more newly confirmed Covid-19 Cases with South Korea
having the least.

``` r
#2. Histogram
my_result_df<- data.by.Countries[c(1:8), c(1:8)]
g<- ggplot(data = my_result_df, aes(x = Countries.CountryCode, y = Countries.TotalDeaths)) + geom_bar(stat = "identity", width = 0.7, col = "pink", fill = "pink") + labs(title = 'Total Confirmed Cases for Country Code', y= "Total Confirmed", x = "Country Code")
print(g)
```
![plot](https://raw.githubusercontent.com/StefaneeT/Project1new/main/images/ProjectHistogram.jpg)


For this histogram, we can observe the total confirmed Covid-19 from
each Country Code ‘AD’, ‘AF’, ‘AG’, ‘AL’, ‘AM’, ‘AO’, ‘AR’, ‘DZ’. From
this graph, it can be observed that Argentina has high confirmed
Covid-19 Rates.

``` r
#3. Box Plot
ggplot(South.Africa.data, aes(x = Country, y = Cases)) + geom_boxplot(width =0.7, aes(fill = Country))+ labs(title = 'Cases in South Africa', y= "Cases", x = "Country")
```
![plot](https://raw.githubusercontent.com/StefaneeT/Project1new/main/images/ProjectBoxplot.jpg)

This boxplot isn’t too meaninful but it displays a Box Plot for the
Country Africa and the IQR for confirmed case rates over the pandemic.

``` r
#4. Scatter Plot
data.by.Countries %>% select(Countries.Country, Countries.TotalConfirmed, Countries.TotalDeaths, Countries.TotalRecovered) %>% 
group_by(Countries.Country) %>% 
summarise(dead = sum(Countries.TotalDeaths) ,confirmed = sum(Countries.TotalConfirmed)) %>% ggplot(aes(x = confirmed, y = dead)) + geom_point() + labs(title = 'Scatter Plot', y= "Total Deaths", x = "Total Confirmed")
```

![plot](https://raw.githubusercontent.com/StefaneeT/Project1new/main/images/Project1ScatterPlot.jpg)

This scatterplot isn’t too interesting but it displays the relationship
between total confirmed cases and total deaths. The two variables don’t
have an extended relationship but it can be observed that if 0 cases are
confirmed then there will be 0 deaths and then it flares out as cases
increases.

``` r
#5. Extra Plot b 
my_result_df<- data.by.Countries[c(1:8), c(1:8)]
g<- ggplot(data = my_result_df, aes(x = Countries.CountryCode, y = Countries.TotalDeaths)) + geom_bar(stat = "identity", width = 0.7, col = "pink", fill = "pink") + labs(title = 'Total Confirmed Deaths for Country Code', y= "Total Deaths", x = "Country Code")
print(g)
```
![plot](https://raw.githubusercontent.com/StefaneeT/Project1new/main/images/ProjectExtraHistogram.jpg)


For this histogram, we can observe the Total Confirmed Covid Deaths from
the first Country Codes, similarly to the confirmed Covid Cases;
Argentina still has the highest rates.
