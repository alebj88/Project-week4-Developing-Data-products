# Project-week4-Developing-Data-products

## Overview

This is an RStudio Shiny application created as part of the peer assessment 
for the Coursera Developing Data Products class. 

The documentation of the project and the R codes are in the Github repository.

The link of said repository is:

https://github.com/alebj88/Project-week4-Developing-Data-products

The app is hosted at: 

https://alebj88.shinyapps.io/Project_week4/

## Summary of the Application

The application calculates regression models for the 'trees' data set using the variables selected by the user. An explanatory variable and a variable of
response.  

It adjusts both a linear model and a polynomial model, of maximum degree 3, to the cloud of points and allows to extract the predicted values for each value of the explanatory variable.  

If the user wants to fix the models to a subset of the cloud of points,
he can select them by using the cursor directly on plot, dragging it. The application will show the results automatically.  

### The application uses 4 widgets listed below.
- checkboxInput 1: Show/Hide Linear Model 1.  
- checkboxInput 2: Show/Hide Linear Model 2.  
- selectInput 1: A box to select the dependent variable.  
- selectInput 2: A box to select the explanatory variable.  
- numericInput : A field to enter numbers. The values of the explanatory variables to be predicted.  

## Trees Data Set.

###Description

This data set provides measurements of the girth, height and volume of timber in 31 felled black cherry trees. Note that girth is the diameter of the tree (in inches) measured at 4 ft 6 in above the ground.

###Format

A data frame with 31 observations on 3 variables.

- Girth	     numeric	 Tree diameter in inches
- Height	 numeric	 Height in ft
- Volume	 numeric	 Volume of timber in cubic ft


