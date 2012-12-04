library(shiny)
library(Hmisc)

# Define server logic
shinyServer(function(input, output) {
   cat('shinyServer called\n',file=stderr())

   appData <- reactive(function() {
      cat('appData called\n',file=stderr())
      sink('/dev/null')
      e <- new.env()
      e$t1 <- input$t1
      e$t2 <- input$t2
      e$p1 <- input$p1
      e$p2 <- input$p2
      e$mo <- input$mo
      e$nc <- input$nc
      e$ni <- input$ni
      e$nsim <- input$nsim
      e$hr <- input$hr
      e$sc <- Weibull2(c(e$t1,e$t2),c(e$p1,e$p2))
      e$f <- Quantile2(e$sc,
         hratio=function(x) ifelse(x <= e$mo/12, 1, e$hr),
         dropin=function(x) ifelse(x <= .5, 0, .15 * (x-.5)/(5-.5)),
         dropout=function(x) .3*x/5
      )
      sink()

      e
   })

   output$psPlot <- reactivePlot(function(){
      cat('output$psPlot called\n',file=stderr())
      d <- appData()
      par(mfrow=c(2,2))
      plot(d$f,'all',label.curves=list(keys='lines'))
   })

   output$power <- reactivePrint(function(){
      cat('output$power called\n',file=stderr())
      with(appData(),{
         sink('/dev/null')
         rcens <- function(n) 1 + (5-1) * (runif(n) ^ .5)
         rcontrol <- function(n) f(n,'control')
         rinterv <- function(n) f(n,'intervention')
         set.seed(211)
         x <- spower(rcontrol,rinterv,rcens, nc=nc, ni=ni, test=logrank, nsim=nsim,cox=TRUE)
         sink()
         x
      })
   })

})
