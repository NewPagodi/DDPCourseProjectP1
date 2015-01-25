



# server.R

#tdata<-data.frame(a=numeric())
#tdata<-data.frame(a=numeric(10))

foodData<-read.csv("data.csv")
rdaVA<-3000
rdaVC<-90
rdaCal<-1000
rdaIron<-8
totals<-0

shinyServer(
	function(input, output, session) {

	updateSelectInput(session, "var", label = "Food:", choices = as.character(foodData$food), selected = as.character(foodData$food)[1])
	
	tdata<-data.frame(Food = character(),VitaminA=numeric(), VitaminC=numeric(),Calcium=numeric(),Iron=numeric())
	names(tdata)<-c("VitaminA (IU)","VitaminC (mg)", "Calcium (mg)", "Iron (mg)" )
	#rdata<-data.frame(VitaminA=numeric(), VitaminC=numeric(),Calcium=numeric(),Iron=numeric())
	lastCount <-0;
	
	dataInput <- reactive({
		lastCount<<-input$goButton
			
			scaleFactor<-input$id1
			
			i<-which(as.character(foodData$food)==input$var)
			
			vitaminA<-foodData[i,2]*(scaleFactor/100);
			#vitaminARDA<-foodData[i,3]*scaleFactor;
			vitaminC<-foodData[i,3]*(scaleFactor/100);
			#vitaminCRDA<-foodData[i,5]*scaleFactor;
			calciu<-foodData[i,4]*(scaleFactor/100);
			#calciumRDA<-foodData[i,7]*scaleFactor;
			iron<-foodData[i,5]*(scaleFactor/100);
			#ironRDA<-foodData[i,9]*scaleFactor;

			names(tdata)<<-c("Food","VitaminA","VitaminC","Calcium","Iron")
			
			tdata<<-rbind( tdata,data.frame(Food = input$var,VitaminA=vitaminA, VitaminC=vitaminC,Calcium=calciu,Iron=iron))
			names(tdata)<<-c("Food","VitaminA(IU)","VitaminC(mg)", "Calcium(mg)", "Iron(mg)" )
			#rdata<<-rbind( rdata,data.frame(VitaminA=5, VitaminC=5,Calcium=5,Iron=5))
			
			totals<<-sapply(tdata[,2:5],sum)
	})

	
	output$summary<-renderPrint({
		if(input$goButton != lastCount)
		{
			dataInput()
			
			print(tdata)
		}
		else if(input$goButton != 0)
		{
			print(tdata)
		}
		else
		{
			print("")
		}

	})

	output$total<-renderPrint({
		if(input$goButton != lastCount)
		{
			dataInput()
			
			print(totals)
		}
		else if(input$goButton != 0)
		{
			print(totals)
		}
		else
		{
			print("")
		}

	})
	
	output$bargraph<-renderPlot({
		if(input$goButton != lastCount)
		{
			dataInput()
		}
		barplot(100*(totals/c(rdaVA,rdaVC,rdaCal,rdaIron)),ylim=c(0,100),main="Percent RDA",xpd=FALSE,names.arg=c("VitaminA","VitaminC","Calcium","Iron"))
	})
	}
)

