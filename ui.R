
# ui.R

shinyUI(navbarPage("The Daily Nutrition Tracker",
  tabPanel("Main",
	  #titlePanel(""),
	  
	  sidebarLayout(
		sidebarPanel(
		  helpText("Choose a food and enter the amount eaten.  Then press the Go button."),
		  
		  selectInput("var", 
			label = "Food:",
			choices = c(""),
			selected = ""),
		  
			numericInput('id1', 'Amount eaten in grams:',100, min =1, max =1000, step =1),
			
			actionButton("goButton","Go!"),
			br(),
			br(),
			br(),
			img(src = "food-carrot.png", height = 72, width = 72)

			#submitButton(text = "Apply Changes", icon = NULL)
		),
		
		mainPanel(
		  # textOutput("text1"),
		  # textOutput("text2")
		  # plotOutput("map")
		  plotOutput("bargraph"),
		  p("Total Nutrients:"),
		  verbatimTextOutput("total"),
		  p("Nutrient breakdown:"),
		  verbatimTextOutput("summary")
		)
	  )
  ),
  tabPanel("Help",
	p("The Daily Nutrition Tracker lets you track how much of 4 essential nutrients (Vitamin A, Vitamin C, Calcium, and Iron), you are getting from the foods you eat."),
	h4("How To Use the Tracker"),
	p("You use the left panel on the main page to enter the information.  For each food you've eaten today, simply enter the type of food and the amount eaten in grams.  Then press the go button."),
	h4("What Information Will Be Shown"),
	p("The information is displayed in the right panel.  As each food is entered, the tracker updates 3 sets of information.  First the tracker will give a chart showing how much recommended daily allowance (RDA) of Vitamin A, Vitamin C, Calcium, and Iron that you have you have taken in.  Second, it will also give the total amounts of these nutrients you have taken in.  Finally, it will give a breakdown of that total for each food.")
  )
))




