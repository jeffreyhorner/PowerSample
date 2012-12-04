library(shiny)

overview <- HTML("
<p>
We simulate a 2-arm
5-year follow-up study using Hmisc. All subjects are followed
at least one year, and patients enter the study with linearly
increasing probability starting with zero. Assume (1) there is
no chance of dropin for the first 6 months, then the probability
increases linearly up to .15 at 5 years; and (2) there is a linearly
increasing chance of dropout up to .3 at 5 years.
</p>
<h3>Instructions</h3>
<ul>
<li>Click on the <b>Design Displays</b> and <b>Results</b> tabs above to see graphics and spower results.
</li>
<li>Change any variable on the left and it will automatically update the tabs.</li>
")

customHeaderPanel <- function(title,windowTitle=title){
    tagList(
       tags$head(
          tags$title(windowTitle),
          tags$link(rel="stylesheet", type="text/css",
                  href="app.css")
       ), 
       div(class = "span12", style = "padding: 10px 0px;", h1(title))
    )
}

shinyUI(pageWithSidebar(

   # Application title
   customHeaderPanel("Power and Sample Size with spower from Hmisc"),

   sidebarPanel(
      numericInput("t1", "First Time Point (t1, years) ", 1,step=1),
      numericInput("t2", "Second Time Point (t2, years) ", 3,step=1),
      numericInput("p1", "t1-year Control Group Survival Prob.:", .95,step=.01),
      numericInput("p2", "t2-year Control Group Survival Prob.:", .7,step=.01),
      numericInput("hr", "Long-term Treatment Effect (hazard ratio):", .75, step=.05),
      numericInput("mo", "Treatment Effect Start Month:", 9,step=1),
      numericInput("nc", "Number of Control Subjects:", 100, step=25),
      numericInput("ni", "Number of Intervention Subjects:", 100, step=25),
      numericInput("nsim", "Number of Simulated Trials:", 100, step=50)

   ),

   mainPanel(
      tabsetPanel(
         tabPanel("Design Displays",plotOutput('psPlot',height='600px')),
         tabPanel("Results",verbatimTextOutput("power")),
         tabPanel("Overview",div(class="spower-overview",overview))
      )
   )
))
