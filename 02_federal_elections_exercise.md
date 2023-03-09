Federal Elections Exercise
================
Alex
March 08, 2023

# Load, Clean and Join Data

``` r
## for data manipulation
library(tidyverse)

## for robust standard errors
library(sandwich)
library(lmtest)

## for printing nice tables
library(stargazer)

## for actually loading data
library(fec16)
```

``` r
campaigns     <- data.frame(campaigns)
results_house <- data.frame(results_house) %>% 
  filter(party %in% c('DEM', 'REP')) # how many people did we drop? : 
# individuals <- read.csv('./individuals.csv')
```

# Explore and Make Histograms

``` r
results_house %>% 
  filter(party %in% c('REP', 'DEM', 'IND')) %>% 
  ggplot() + 
  aes(x=primary_votes, fill=party) + 
  geom_histogram(bins=30, position = 'dodge')
```

![](02_federal_elections_exercise_files/figure-gfm/make%20histograms-1.png)<!-- -->

# Make a Scatter Plot

# Run a Regression

``` r
model <- lm(primary_votes ~ incumbent + party, data = results_house)
coeftest(model, vcov. = vcovHC)
```

    ## 
    ## t test of coefficients:
    ## 
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)   18048.69     858.21 21.0306  < 2e-16 ***
    ## incumbentTRUE 47570.91    1945.40 24.4530  < 2e-16 ***
    ## partyREP      -3875.54    1226.96 -3.1586  0.00162 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# Print a Table

``` r
stargazer(
  model, type = 'text'
)
```

    ## 
    ## ===============================================
    ##                         Dependent variable:    
    ##                     ---------------------------
    ##                            primary_votes       
    ## -----------------------------------------------
    ## incumbent                  47,570.910***       
    ##                             (1,410.873)        
    ##                                                
    ## partyREP                   -3,875.536***       
    ##                             (1,200.713)        
    ##                                                
    ## Constant                   18,048.690***       
    ##                              (944.566)         
    ##                                                
    ## -----------------------------------------------
    ## Observations                   1,345           
    ## R2                             0.460           
    ## Adjusted R2                    0.459           
    ## Residual Std. Error   21,909.310 (df = 1342)   
    ## F Statistic          571.847*** (df = 2; 1342) 
    ## ===============================================
    ## Note:               *p<0.1; **p<0.05; ***p<0.01

# Interpret the Regression Output

-   We’ve estimated that a challenger – i.e. someone who is not
    currently an incumbent politician, will garner 18,049 votes.
-   We’ve estimated that an incumbent will get 47,571
