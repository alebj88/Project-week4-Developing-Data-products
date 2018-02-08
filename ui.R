library(shiny)

#Archive ui.R.
shinyUI(fluidPage(
    titlePanel("Visualize Many Models"),					
    sidebarLayout(													
        sidebarPanel(	
            
            #Linear model parameters.
            h3("Linear Model:"),
            h4("Slope"),
            textOutput("RText_Slope"),
            h4("Intercept"),
            textOutput("RText_Inter"),
            checkboxInput("Box_ShowMod1","Show/Hide Linear Model 1",value=T),
            
            #Polynomial model parameters.
            h3("Polynomial Model:"),
            h4("Slope gr1, gr2, gr3."),
            textOutput("RText_SlopeP"),
            h4("Intercept"),
            textOutput("RText_InterP"),
            checkboxInput("Box_ShowMod2","Show/Hide Polynomial Model 2",value=T),
            #textOutput("ShowMe"),
            
            #Inputs
            selectInput("Select_Yvar", "Select the dependent variable:",
                        choices = c("Girth"="Girth","Height"="Height","Volume"="Volume"),
                        selected = "Height"
            ),
            selectInput("Select_Xvar", "Select the explanatory variable:",
                        choices = c("Girth"="Girth","Height"="Height","Volume"="Volume"),
                        selected = "Girth"
            ),
            numericInput("Slider_Value",textOutput("RText_Q"),
                         value=15,min=1,max=100,step=1)
            
        ), 
        mainPanel(
            plotOutput("RPlot_Scatt",brush=brushOpts(id="Brush")),
            h4("Predicted value from the linear model:"),
            textOutput("RText_pred1"),
            h4("Predicted value from the polynomical model:"),
            textOutput("RText_pred2")
        )
    )
))
