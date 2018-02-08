#INPUTS
# checkboxInput("Box_ShowMod1")  #Boolean
# checkboxInput("Box_ShowMod2")  #Boolean
# sliderInput("Slider_Value")    #Numeric
# selectInput("Select_Yvar")     #Character
# selectInput("Select_Xvar")     #Character
#
#OUTPUTS
#
# RText_Slope
# RText_Inter
# RText_SlopeP
# RText_InterP
# RText_Pred1
# RText_Pred2
# RPlot_Scatt
library(shiny)

#Archive server.R.
shinyServer(function(input,output){

    #Configuring the numericInput.
    output$RText_Q <-renderText({         
        X <-input$Select_Xvar
        if(X == "Height"){
            Q <-"What is the height of the tree?"
        }else if (X == "Volume"){
            Q <-"What is the volume of the tree?"
        }else{
            Q <-"What is the girth of the tree?"
        }
    })
    
    #Linear Model -------------------------------------------------
    
    #linear regression model for the completed data
    LinModR1 <-reactive({
        Y <-input$Select_Yvar       #Character
        X <-input$Select_Xvar
        if(Y == "Girth"){
            if(X == "Height"){
                mod  <-lm(Girth ~ Height,data=trees) 
                return(mod)
            }else if (X == "Volume"){
                mod  <-lm(Girth ~ Volume,data=trees) 
                return(mod)
            }
        }else if (Y == "Height"){
            if(X == "Girth"){
                mod  <-lm(Height ~ Girth,data=trees) 
                return(mod)
            }else if (X == "Volume"){
                mod  <-lm(Height ~ Volume,data=trees) 
                return(mod)
            }
        }else if (Y == "Volume"){
            if(X == "Height"){
                mod  <-lm(Volume ~ Height,data=trees) 
                return(mod)
            }else if (X == "Girth"){
                mod  <-lm(Volume ~ Girth,data=trees) 
                return(mod)
            }
        }
        return(NULL)
    })
    
    #Linear regression model for the bushed data
    LinModR2 <-reactive({	
        Y <-input$Select_Yvar
        X <-input$Select_Xvar
        B_data <-brushedPoints(trees,input$Brush,xvar=X,yvar=Y)	
        if(nrow(B_data)<2){																				
            return(NULL)
        }
        if(Y == "Girth"){
            if(X == "Height"){
                mod  <-lm(Girth ~ Height,data=B_data) 
                mod1 <<-mod   #The model is extracted from the reative function.
                return(mod)
            }else if (X == "Volume"){
                mod  <-lm(Girth ~ Volume,data=B_data) 
                mod1 <<-mod
                return(mod)
            }
        }else if (Y == "Height"){
            if(X == "Girth"){
                mod  <-lm(Height ~ Girth,data=B_data) 
                mod1 <<-mod
                return(mod)
            }else if (X == "Volume"){
                mod  <-lm(Height ~ Volume,data=B_data) 
                mod1 <<-mod
                return(mod)
            }
        }else if (Y == "Volume"){
            if(X == "Height"){
                mod  <-lm(Volume ~ Height,data=B_data) 
                mod1 <<-mod
                return(mod)
            }else if (X == "Girth"){
                mod  <-lm(Volume ~ Girth,data=B_data) 
                mod1 <<-mod  
                return(mod)
            }
        }
        return(NULL)
    })

    #Output parameter
    output$RText_Slope<-renderText({					
        if(is.null(LinModR2())){										
            LinModR1()[[1]][2]
        }else{										
            LinModR2()[[1]][2]							
        }
    })
    
    #Output parameter
    output$RText_Inter<-renderText({					
        if(is.null(LinModR2())){										
            LinModR1()[[1]][1]
        }else{										
            LinModR2()[[1]][1]												
        }
    })	
    
    #Polynomial Model-----------------------------------------------
    
    #Polynomial regression model for the completed data
    PolModR1 <-reactive({	
        Y <-input$Select_Yvar
        X <-input$Select_Xvar
        if(Y == "Girth"){
            if(X == "Height"){
                mod  <-lm(Girth ~  poly(Height,degree=3,raw=TRUE),data=trees) 
                return(mod)
            }else if (X == "Volume"){
                mod  <-lm(Girth ~  poly(Volume,degree=3,raw=TRUE),data=trees) 
                return(mod)
            }
        }else if (Y == "Height"){
            if(X == "Girth"){
                mod  <-lm(Height ~  poly(Girth,degree=3,raw=TRUE),data=trees) 
                return(mod)
            }else if (X == "Volume"){
                mod  <-lm(Height ~  poly(Volume,degree=3,raw=TRUE),data=trees) 
                return(mod)
            }
        }else if (Y == "Volume"){
            if(X == "Height"){
                mod  <-lm(Volume ~  poly(Height,degree=3,raw=TRUE),data=trees) 
                return(mod)
            }else if (X == "Girth"){
                mod  <-lm(Volume ~  poly(Girth,degree=3,raw=TRUE),data=trees) 
                return(mod)
            }
        }
        return(NULL)
    })
    
    #Polynomial regression model for the bushed data
    PolModR2 <-reactive({	
        Y <-input$Select_Yvar
        X <-input$Select_Xvar
        B_data <-brushedPoints(trees,input$Brush,xvar=X,yvar=Y)	
        if(nrow(B_data)<2){													
            return(NULL)
        }
        if(Y == "Girth"){
            if(X == "Height"){
                mod  <-lm(Girth ~  poly(Height,degree=3,raw=TRUE),data=B_data) 
                mod2 <<-mod   #The model is extracted from the reative function.
                return(mod)
            }else if (X == "Volume"){
                mod  <-lm(Girth ~  poly(Volume,degree=3,raw=TRUE),data=B_data) 
                mod2 <<-mod
                return(mod)
            }
        }else if (Y == "Height"){
            if(X == "Girth"){
                mod  <-lm(Height ~  poly(Girth,degree=3,raw=TRUE),data=B_data) 
                mod2 <<-mod
                return(mod)
            }else if (X == "Volume"){
                mod  <-lm(Height ~  poly(Volume,degree=3,raw=TRUE),data=B_data) 
                mod2 <<-mod
                return(mod)
            }
        }else if (Y == "Volume"){
            if(X == "Height"){
                mod  <-lm(Volume ~  poly(Height,degree=3,raw=TRUE),data=B_data) 
                mod2 <<-mod
                return(mod)
            }else if (X == "Girth"){
                mod  <-lm(Volume ~  poly(Girth,degree=3,raw=TRUE),data=B_data) 
                mod2 <<-mod  
                return(mod)
            }
        }
        return(NULL)
    })
    
    #Output parameter
    output$RText_SlopeP<-renderText({					
        if(is.null(PolModR2())){										
            c(PolModR1()[[1]][2],PolModR1()[[1]][3],PolModR1()[[1]][4])
        }else{			
            c(PolModR2()[[1]][2],PolModR2()[[1]][3],PolModR2()[[1]][4])
          
        }
    })
    
    #Output parameter
    output$RText_InterP <-renderText({					
        if(is.null(PolModR2())){										
            PolModR1()[[1]][1]
        }else{										
            PolModR2()[[1]][1]											
        }
    })
    
    #Predicting points with the slider-----------------------------------------
    
    #Linear model prediction
    LinModPred <-reactive({
        Y <-input$Select_Yvar
        X <-input$Select_Xvar
        if(X == Y){
            return(NULL)
        }
        number <-input$Slider_Value
        #Selection
        if(is.null(LinModR2())){										
            modFit <-LinModR1()
        }else{										
            modFit <-LinModR2()												
        }
        if(X == "Girth"){
            predict(modFit,newdata = data.frame(Girth=number))
        }else if (X == "Height"){
            predict(modFit,newdata = data.frame(Height=number))
        }else{
            predict(modFit,newdata = data.frame(Volume=number))
        }
    })

    #Polynomial model  prediction.
    PolModPred <-reactive({
        Y <-input$Select_Yvar
        X <-input$Select_Xvar
        if(X == Y){
            return(NULL)
        }
        number <-input$Slider_Value
        #Selection
        if(is.null(PolModR2())){										
            modFit <-PolModR1()
        }else{										
            modFit <-PolModR2()												
        }
        if(X == "Girth"){
            predict(modFit,newdata = data.frame(Girth=number))
        }else if (X == "Height"){
            predict(modFit,newdata = data.frame(Height=number))
        }else{
            predict(modFit,newdata = data.frame(Volume=number))
        }
    })

    #result output 1.
    output$RText_pred1 <-renderText({
        LinModPred()
    })

    #Result output 2.
    output$RText_pred2 <-renderText({
        PolModPred()
    })
    
    #Plots -----------------------------------------------------------
    output$RPlot_Scatt <-renderPlot({
        #Receive Inputs
        Y <-input$Select_Yvar
        X <-input$Select_Xvar
        number <-input$Slider_Value
        #Generate Plot
        plot(trees[,X],trees[,Y],xlab=X,ylab=Y,main="Tree Measurements",
             bty="n",pch=16,cex=1.5)			
        
        #Regression curve construction.
        curva <-function(x,n){  
            if(n == 1){
                y <-PolModR1()[[1]][1]
                for(i in 2:4){
                    if(!is.na(PolModR1()[[1]][i])){
                        y <-y + PolModR1()[[1]][i]*(x^(i-1))
                    }
                }
            }else{
                y <-PolModR2()[[1]][1]
                for(i in 2:4){
                    if(!is.na(PolModR2()[[1]][i])){
                        y <-y + PolModR2()[[1]][i]*(x^(i-1))
                    }
                } 
            }
            return(y)
        }
        
        #If the variables are equal, we do not do any prediction.
        if(X != Y){
            #Add linear regresion trace to the plot.
            if(is.null(LinModR2())){	
                if(input$Box_ShowMod1){
                    abline(LinModR1(),col="blue",lwd=2)
                }	
            }else{
                if(input$Box_ShowMod1){
                    abline(LinModR2(),col="blue",lwd=2)
                }
            }
            
            #Add polynomial regresion trace to the plot.
            if(is.null(PolModR2())){	
                if(input$Box_ShowMod2){
                    curve(curva(x,1),min(trees[,X]),max(trees[,X]),
                          col="red",lwd=2,add=T)
                }	
            }else{
                if(input$Box_ShowMod2){
                    curve(curva(x,2),min(trees[,X]),max(trees[,X]),
                          col="red",lwd=2,add=T)
                }
            }
            #Add legend and prediction points to the plot.
            legend(25,250,c("Model 1 Prediction","Model 2 Prediction"),pch=16,
                   col=c("red","blue"),bty="n",cex=1.2)
            points(number,LinModPred(),bty="n",col="blue",pch=16,cex=2)
            points(number,PolModPred(),bty="n",col="red",pch=16,cex=2)
        }
    })
    # output$ShowMe <-renderText({          #Print section
    #     input$Box_ShowMod2
    # })
})
