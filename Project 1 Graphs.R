```{r}
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


```{r}
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
```

```{r}

#3. Box Plot

#Sept daily cases of 5 countries
data.by.Countries%>% filter(grepl('China|Korea|United States|United Kingdom|Italy|Spain',Countries.Country) & Countries.Date >= '2021-09-02') %>% ggplot(data.by.Countries, mapping = aes(x=Countries.Date, y = Countries.Country)) + geom_boxplot() + geom_point(mapping = aes(color = Countries.Country) , position = "jitter", size = 2) + labs(title = "Boxplot for Weight") + coord_flip()
```

```{r}
#4. Scatter Plot
data.by.Countries %>% select(Countries.Country, Countries.TotalConfirmed, Countries.TotalDeaths, Countries.TotalRecovered) %>% 
  group_by(Countries.Country) %>% 
  summarise(dead = sum(Countries.TotalDeaths) ,confirmed = sum(Countries.TotalConfirmed)) %>% ggplot(aes(x = confirmed, y = dead)) + geom_point() + labs(title = 'Scatter Plot', y= "Total Deaths", x = "Total Confirmed")
```

```{r}
#5. Extra Plot b 
my_result_json2 %>% 
  select(Country, Date, Cases) %>% 
  filter(Country == 'South Africa') %>% 
  group_by(Country, Date) %>% 
  summarise(Cases = sum(Cases)) %>% ggplot(aes(x = Date, y = Cases, group = )) + geom_line(color = 'red')



```