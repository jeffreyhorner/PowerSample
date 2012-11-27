library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(

   # Application title
   headerPanel("Power and Sample Size with spower from Hmisc"),

   sidebarPanel(
      numericInput("p1", "1-year Survival Rate:", .95),
      numericInput("p2", "3-year Survival Rate:", .7),
      numericInput("mo", "Treatment Effect Start Month:", 9),

      helpText('This example demonstrates the flexibility of spower and
      related functions from Hmisc. We simulate a 2-arm (350 subjects/arm)
      5-year follow-up study for wich the control group\'s survival
      distribution is Weibull with 1-year survival of .95 and 3-year
      survival of .7. All subjects are followed at least one year,
      and patients enter the study with linearly increasing probability
      starting with zero. Assume (1) there is no chance of dropin for the
      first 6 months, then the probability increases linearly up to .15
      at 5 years; (2) there is a linearly increasing chance of dropout up
      to .3 at 5 years; and (3) the treatment has no effect for the first
      9 months, then it has a constant effect (hazard ratio of .75).'
   )
),

   mainPanel(
      plotOutput('psPlot',height='600px')
   )
))