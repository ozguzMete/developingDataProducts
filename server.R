library(shiny) 
library(descr) #freq fuction

rawData <- read.csv("rData.csv")
processedData <- rawData
#data(galton)

shinyServer(
  function(input, output, session) {   
    
    ageText <- reactive({
      if(input$ageRestriction==""){
        rawData$Age
      }else{
        if(max(rawData$Age)<as.numeric(input$ageRestriction)){
          max(rawData$Age)
        }else if(min(rawData$Age)>as.numeric(input$ageRestriction)){
          min(rawData$Age)
        }else{
          input$ageRestriction
        }
      }
    })
    
    ageIndices <- reactive({which(rawData$Age == ageText())})
    
    raceText <- reactive({
      if(input$raceRestriction==""){
        rawData$Race
      }else{
        input$raceRestriction
      }
    })
    
    raceIndices <- reactive({which(rawData$Race== raceText())})
    
    countyText <- reactive({
      if(input$countyRestriction==""){
        rawData$County
      }else{
        input$countyRestriction
      }
    })
    
    countyIndices <- reactive({which(rawData$County== countyText())})
    
    sharedIndices <- reactive({intersect(intersect(ageIndices(),raceIndices()),countyIndices())})
    
    lastNames <- reactive({processedData$Last.Name[sharedIndices()]})
    output$plotLastName <- renderPlot({freq(lastNames(),main = "Number of Executions by Last Name")})
    output$lastNameSummary <- renderPrint({
      freqFrame <- data.frame(count=sort(table(lastNames()), decreasing=TRUE))
      colnames(freqFrame) <- c("Frequency")
      count <- dim(head(freqFrame,5))[1]
      cat(paste("First",count, "last names executed most:"),'\n\n')
      head(freqFrame,5)
    })
    
    firstNames <- reactive({processedData$First.Name[sharedIndices()]})
    output$plotFirstName <- renderPlot({freq(firstNames(),main = "Number of Executions by First Name")})
    output$firstNameSummary <- renderPrint({    
      freqFrame <- data.frame(count=sort(table(firstNames()), decreasing=TRUE))
      colnames(freqFrame) <- c("Frequency")
      count <- dim(head(freqFrame,5))[1]
      cat(paste("First",count, "first names executed most:"),'\n\n')
      head(freqFrame,5)
    })
    
    ages <- reactive({processedData$Age[sharedIndices()]})
    output$plotAge <- renderPlot({freq(ages(),main = "Number of Executions by Age")})
    output$ageSummary <- renderPrint({
      freqFrame <- data.frame(count=sort(table(ages()), decreasing=TRUE))
      
      colnames(freqFrame) <- c("Frequency")
      count <- dim(head(freqFrame,5))[1]
      cat(paste("First",count, "ages executed most:"),'\n\n')
      head(freqFrame,5)
    })
    
    processedData$Date<- as.Date(processedData$Date, "%m/%d/%Y")    
    output$plotYear <- renderPlot({freq(as.numeric(format(processedData$Date[sharedIndices()], '%Y')),main = "Number of Executions by Year")})
    
    races <- reactive({processedData$Race[sharedIndices()]})
    output$plotRace <-renderPlot({freq(races(),main = "Number of Executions by Race")})
    output$raceSummary <- renderPrint({
      freqFrame <- data.frame(count=sort(table(races()), decreasing=TRUE))
      colnames(freqFrame) <- c("Frequency")
      count <- dim(head(freqFrame,5))[1]
      cat(paste("First",count, "races executed most:"),'\n\n')
      head(freqFrame,5)
    })
    
    counties <- reactive({processedData$County[sharedIndices()]})
    output$plotCounty <-renderPlot({freq(counties(),main = "Number of Executions by County")})
    output$countySummary <- renderPrint({
      freqFrame <- data.frame(count=sort(table(counties()), decreasing=TRUE))
      colnames(freqFrame) <- c("Frequency")
      count <- dim(head(freqFrame,5))[1]
      cat(paste("First",count, "counties executed most:"),'\n\n')
      head(freqFrame,5)
    })
    
  }
)