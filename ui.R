library("shiny")
shinyUI(
  fluidPage(
    titlePanel("Alzheimer Disease Prediction"),
    fluidRow(
      column(3, wellPanel(
        selectInput("genotype", "Select Genotype:", choices = c("E2E2", "E2E3", "E2E4", "E3E3", "E3E4", "E4E4")),
        submitButton("Submit")
      )),
      column(9, 
        tableOutput("values"),
        textOutput("text1"),
        verbatimTextOutput("summary")
      )
    )
  )
)