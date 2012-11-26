library(shiny)
library(Hmisc)

rcens <- function(n) 1 + (5-1) * (runif(n) ^ .5)
par(mfrow=c(2,2))

# Define server logic
shinyServer(function(input, output) {

output$psPlot <- reactivePlot(function(){
   p1 <- input$p1
   p2 <- input$p2
   mo <- input$mo

   sc <- Weibull2(c(1,3),c(p1,p2))
   f <- Quantile2(sc,
      hratio=function(x) ifelse(x <= mo/12, 1, .75),
      dropin=function(x) ifelse(x <= .5, 0, .15 * (x-.5)/(5-.5)),
      dropout=function(x) .3*x/5
   )
   par(mfrow=c(2,2))
   plot(f,'all',label.curves=list(keys='lines'))
})

})
