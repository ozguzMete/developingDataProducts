shinyUI(pageWithSidebar( 
  headerPanel('Texas Department of Criminal Justice proudly presents...'), 
  sidebarPanel(
    h4('Tuning'),                                                                             
    textInput('ageRestriction', 'Age',''),
    textInput('raceRestriction', 'Race',''),
    textInput('countyRestriction', 'County','')
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Last Name", plotOutput("plotLastName"),verbatimTextOutput("lastNameSummary")),
      tabPanel("First Name", plotOutput("plotFirstName"),verbatimTextOutput("firstNameSummary")),
      tabPanel("Age",  plotOutput("plotAge"),verbatimTextOutput("ageSummary")),
      tabPanel("Year", plotOutput("plotYear")),
      tabPanel("Race", plotOutput("plotRace"),verbatimTextOutput("raceSummary")),
      tabPanel("County", plotOutput("plotCounty"),verbatimTextOutput("countySummary"))
    )
  ) 
))