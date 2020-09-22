class CalendarWeek {
	
	//http://kursjs.pl/kurs/date/date-calendar.php
	//https://stackoverflow.com/questions/5511323/calculate-the-date-yesterday-in-javascript
	
	
	constructor (choosenDay) {
		
		//current day
		this.today = new Date();
		
		//day for which calendar will be generated
		//this.selectedDay = new Date(2019,1,26);
		this.selectedDay = new Date(choosenDay);
		
        this.day = this.selectedDay.getDate();
        this.month = this.selectedDay.getMonth();
        this.year = this.selectedDay.getFullYear();
		
		//day of the week
		this.dayName = this.selectedDay.getDay();
			
		//beginning of the week - we assume that Monday is beginning of the week
		this.weekFirstDay = new Date((this.selectedDay.getTime()-(this.dayName)*24*60*60*1000));
		
		//end of the week - we assume that Sunday is the end of the week
		this.weekLastDay = new Date((this.selectedDay.getTime()+(7 - 1 - this.dayName)*24*60*60*1000));
		
        this.divCalendarCnt = null;
        this.divCalendarHoursDescription = null;
        this.divCalendarWorkspace = null;
        this.divCalendarHeader = null;
        this.divCalendarMainView = null;
        
        this.divCalendarHeaderTitle = null;
        this.divCalendarHeaderDayList = null;
		
		        
        
	}
	
	
	//Function to add calendar hours descriptions
	addHoursDescription() {
	
		var insertHTMLcode = "";
		
		//add 1 div class calendarEmptyCorner1 and 1 div calendarEmptyCorner2
		insertHTMLcode += '<div class="calendarEmptyCorner1"></div>';
		insertHTMLcode += '<div class="calendarEmptyCorner2"></div>';
		
		insertHTMLcode += '<div class="calendarDescription">00:00</div>';
		
		var hour = 0;
		var minutes = "";
		var description = "";
		
		var i=0;
		
		for (i; i<=46; i++)
		{
			
			var description = "";
			if ((i+1) % 2 == 0) hour++;
			
			if ((i+1) % 2 == 0) {
				
				minutes="00";
			} else {
				minutes="30";
			}
					
			
			if (hour < 10) {
				
				description = "0" + hour + ":" + minutes;
			} else {
				description = hour + ":" + minutes;
			}
			
			
			insertHTMLcode += '<div class="calendarDescription">' + description +'</div>';
				
			
		}
		
	
		this.divCalendarHoursDescription.innerHTML = insertHTMLcode;
	}
	
	
	//Function to add calendar days descriptions
	addDaysDescription() {
		
		this.divCalendarHeaderTitle.setAttribute("id","divCalendarHeaderTitle");
	
		month_list = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
		day_list = ["Sun", "Mon", "Tues", "Wed", "Thur", "Fri", "Sat"];
		
		//Add header title
		var headerTitle = "";
		
		
		if(this.weekFirstDay.getFullYear() == this.weekLastDay.getFullYear()){
		
			if((this.selectedDay.getMonth() == this.weekFirstDay.getMonth()) && (this.selectedDay.getMonth() == this.weekLastDay.getMonth())){
				headerTitle = month_list[this.selectedDay.getMonth()] + " " + (this.weekFirstDay.getDate()) + "-" + (this.weekLastDay.getDate()) + ", " + (this.selectedDay.getFullYear());
			} else {

				headerTitle = month_list[this.weekFirstDay.getMonth()] + " " + (this.weekFirstDay.getDate()) + " - " + month_list[this.weekLastDay.getMonth()] + " " + (this.weekLastDay.getDate()) + ", " + (this.selectedDay.getFullYear());

			}
			
		} else {
			


				headerTitle = month_list[this.weekFirstDay.getMonth()] + " " + (this.weekFirstDay.getDate()) + ", " + this.weekFirstDay.getFullYear() + " - " + month_list[this.weekLastDay.getMonth()] + " " + (this.weekLastDay.getDate()) + ", " + (this.weekLastDay.getFullYear());

			
			
			
			
		}
		
		this.divCalendarHeaderTitle.innerHTML = headerTitle;
		
		//keeps information about present calendar view (day for which this view was generated) - usufull when switching calendar view https://www.sitepoint.com/how-why-use-html5-custom-data-attributes/
		//this.divCalendarHeaderTitle.setAttribute("data-identifier", "W" + this.selectedDay.getDate() + this.selectedDay.getMonth() + this.selectedDay.getFullYear());
		this.divCalendarHeaderTitle.setAttribute("data-identifier", "W" + this.checkDateCode(this.selectedDay));
					
		
		//Add days description
		var i=0;
		var insertHTMLcode = "";
		var tempDay = new Date(this.weekFirstDay);
		for (i; i<=6; i++)
		{
			
			
			insertHTMLcode += '<div class="calendarHeaderDay">' + (tempDay.getDate()) + ' ' + day_list[i] +'</div>';
			
						
			tempDay.setDate(tempDay.getDate()+1);
			
		}
		
		this.divCalendarHeaderDayList.innerHTML = insertHTMLcode;
	
	
	
	}
	
	
	
	checkDateCode(checkDate) {
		
		var result = "";
			
		result += checkDate.getFullYear();
				
		if (checkDate.getMonth() < 10) {
				
			result += "0" + checkDate.getMonth();
		} else {
			result += checkDate.getMonth();
		}
			
			
		if (checkDate.getDate() < 10) {
				
			result += "0" + checkDate.getDate();
		} else {
			result += checkDate.getDate();
		}
		
		return result;
	
	}
	
	
	
	checkHourCode(checkHour) {
		
		var result = "";
		var min = ""
		var hr = ""
		//var result = Math.ceil(checkHour/2);
		
		
		hr = Math.floor((checkHour) / 2);
		
		if ((checkHour) % 2 == 0) {
				
			min = "00";
		} else {
			min = "30";
		}
					
			
		if (hr < 10) {
				
			result = "_0" + hr + min;
		} else {
			result = "_" + hr + min;
		}
		
		return result;
		
	}

	
	//Function to add calendar days descriptions
	addDayFields() {
		
		var i=0;
		var j=0;
		var insertHTMLcode = "";	
		var tempDay = new Date(this.weekFirstDay);
		
		//codes for div id
		var dateCode = "";
		var hourCode = "";
		
		
		for (i; i<=6; i++)
		{
			
			//Prepare day code - to add id atrribute to each div
			dateCode = this.checkDateCode(tempDay);
			
			
			insertHTMLcode += '<div class="calendarDayColumn" id="' + dateCode + '">';
			
				for (j=0; j<=47; j++)
				{
					
					hourCode = this.checkHourCode(j);
					insertHTMLcode += '<div class="calendarDayHour" onclick="selectedByUser(this)" id="' + dateCode + hourCode + '"></div>';
			
				}
			
			
			insertHTMLcode += '</div>';
			
			tempDay.setDate(tempDay.getDate()+1);
	
			
			
		}
		
		this.divCalendarMainView.innerHTML = insertHTMLcode;
		
	}
	
	
	
	
	init() {
		
		this.divCalendarCnt = document.createElement("div");
		this.divCalendarCnt.classList.add("calendarCnt");
		
		this.divCalendarHoursDescription = document.createElement("div");
		this.divCalendarHoursDescription.classList.add("calendarHoursDescription");
		
		this.divCalendarWorkspace = document.createElement("div");
		this.divCalendarWorkspace.classList.add("calendarWorkSpace");
		
		this.divCalendarHeader = document.createElement("div");
		this.divCalendarHeader.classList.add("calendarHeader");
		
		this.divCalendarMainView = document.createElement("div");
		this.divCalendarMainView.classList.add("calendarMainView");
	
		this.divCalendarHeaderTitle = document.createElement("div");
		this.divCalendarHeaderTitle.classList.add("calendarHeaderTitle");
		
		this.divCalendarHeaderDayList = document.createElement("div");
		this.divCalendarHeaderDayList.classList.add("calendarHeaderDayList");
		
		this.divCalendarCnt.appendChild(this.divCalendarHoursDescription);
		this.divCalendarCnt.appendChild(this.divCalendarWorkspace);
		this.divCalendarWorkspace.appendChild(this.divCalendarHeader);
		this.divCalendarWorkspace.appendChild(this.divCalendarMainView);
		this.divCalendarHeader.appendChild(this.divCalendarHeaderTitle);
		this.divCalendarHeader.appendChild(this.divCalendarHeaderDayList);
		
				
		this.addHoursDescription();
		this.addDaysDescription();
		this.addDayFields(); 
		
		
		//------------------------
		//this.divCalendarHeaderTitle.innerHTML = "April 10-17" + " week beginning " + this.weekFirstDay.getDate() + " " + this.weekFirstDay.getMonth() 
		
		//+ " The end of the week " + this.weekLastDay.getDate() + " " + this.weekLastDay.getMonth();
		
		
	}
	
	

	
}





class CalendarDay {
	
	
	constructor (choosenDay) {
		
		//current day
		this.today = new Date();
		
		//day for which calendar will be generated
		this.selectedDay = new Date(choosenDay);
		
        this.day = this.selectedDay.getDate();
        this.month = this.selectedDay.getMonth();
        this.year = this.selectedDay.getFullYear();
		
		//day of the week
		this.dayName = this.selectedDay.getDay();
			
			
        this.divCalendarCnt = null;
        this.divCalendarHoursDescription = null;
        this.divCalendarWorkspace = null;
        this.divCalendarHeader = null;
        this.divCalendarMainView = null;
        
        this.divCalendarHeaderTitle = null;
        this.divCalendarHeaderDayList = null;
		
		               
	}
	
	//Function to add calendar hours descriptions
	addHoursDescription() {
	
		var insertHTMLcode = "";
		
		//add 1 div class calendarEmptyCorner1 and 1 div calendarEmptyCorner2
		insertHTMLcode += '<div class="calendarEmptyCorner1"></div>';
		insertHTMLcode += '<div class="calendarEmptyCorner2"></div>';
		
		insertHTMLcode += '<div class="calendarDescription">00:00</div>';
		
		var hour = 0;
		var minutes = "";
		var description = "";
		
		var i=0;
		
		for (i; i<=46; i++)
		{
			
			var description = "";
			if ((i+1) % 2 == 0) hour++;
			
			if ((i+1) % 2 == 0) {
				
				minutes="00";
			} else {
				minutes="30";
			}
					
			
			if (hour < 10) {
				
				description = "0" + hour + ":" + minutes;
			} else {
				description = hour + ":" + minutes;
			}
			
			
			insertHTMLcode += '<div class="calendarDescription">' + description +'</div>';
				
			
		}
		
	
		this.divCalendarHoursDescription.innerHTML = insertHTMLcode;
	}
	
	
	//Function to add calendar days descriptions
	addDaysDescription() {
		
		this.divCalendarHeaderTitle.setAttribute("id","divCalendarHeaderTitle");
	
		month_list = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
		day_list = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		
		//Add header title
		var headerTitle = "";
		
		headerTitle = day_list[this.selectedDay.getDay()] + " - " + (this.selectedDay.getDate()) + " " + month_list[this.selectedDay.getMonth()] + ", " + this.selectedDay.getFullYear();
	
		this.divCalendarHeaderTitle.innerHTML = headerTitle;
		
		//keeps information about present calendar view (day for which this view was generated) - usufull when switching calendar view 
		this.divCalendarHeaderTitle.setAttribute("data-identifier", "D" + this.checkDateCode(this.selectedDay));
					
		
		//Add day description
		var insertHTMLcode = "";

		insertHTMLcode += '<div class="calendarHeaderDay2">' + (this.selectedDay.getDate()) + ' ' + day_list[this.selectedDay.getDay()] +'</div>';
		
		this.divCalendarHeaderDayList.innerHTML = insertHTMLcode;
	
	
	
	}
	
	
	
	checkDateCode(checkDate) {
		
		var result = "";
			
		result += checkDate.getFullYear();
				
		if (checkDate.getMonth() < 10) {
				
			result += "0" + checkDate.getMonth();
		} else {
			result += checkDate.getMonth();
		}
			
			
		if (checkDate.getDate() < 10) {
				
			result += "0" + checkDate.getDate();
		} else {
			result += checkDate.getDate();
		}
		
		return result;
	
	}
	
	
	
	checkHourCode(checkHour) {
		
		var result = "";
		var min = ""
		var hr = ""		
		
		hr = Math.floor((checkHour) / 2);
		
		if ((checkHour) % 2 == 0) {
				
			min = "00";
		} else {
			min = "30";
		}
					
			
		if (hr < 10) {
				
			result = "_0" + hr + min;
		} else {
			result = "_" + hr + min;
		}
		
		return result;
		
	}

	
	//Function to add calendar days descriptions
	addDayFields() {
		

		var j=0;
		var insertHTMLcode = "";	
		
		
		//codes for div id
		var dateCode = "";
		var hourCode = "";
		
				
		//Prepare day code - to add id atrribute to each div
		dateCode = this.checkDateCode(this.selectedDay);
			
			
		insertHTMLcode += '<div class="calendarDayColumn2" id="' + dateCode + '">';
			
			for (j=0; j<=47; j++)
			{
						
				hourCode = this.checkHourCode(j);
				insertHTMLcode += '<div class="calendarDayHour" onclick="selectedByUser(this)" id="' + dateCode + hourCode + '"></div>';
			
			}
			
			
		insertHTMLcode += '</div>';
					
		
		this.divCalendarMainView.innerHTML = insertHTMLcode;
		
	}
	
	
	
	
	init() {
		
		this.divCalendarCnt = document.createElement("div");
		this.divCalendarCnt.classList.add("calendarCnt");
		
		this.divCalendarHoursDescription = document.createElement("div");
		this.divCalendarHoursDescription.classList.add("calendarHoursDescription");
		
		this.divCalendarWorkspace = document.createElement("div");
		this.divCalendarWorkspace.classList.add("calendarWorkSpace");
		
		this.divCalendarHeader = document.createElement("div");
		this.divCalendarHeader.classList.add("calendarHeader");
		
		this.divCalendarMainView = document.createElement("div");
		this.divCalendarMainView.classList.add("calendarMainView");
	
		this.divCalendarHeaderTitle = document.createElement("div");
		this.divCalendarHeaderTitle.classList.add("calendarHeaderTitle");
		
		this.divCalendarHeaderDayList = document.createElement("div");
		this.divCalendarHeaderDayList.classList.add("calendarHeaderDayList");
		
		this.divCalendarCnt.appendChild(this.divCalendarHoursDescription);
		this.divCalendarCnt.appendChild(this.divCalendarWorkspace);
		this.divCalendarWorkspace.appendChild(this.divCalendarHeader);
		this.divCalendarWorkspace.appendChild(this.divCalendarMainView);
		this.divCalendarHeader.appendChild(this.divCalendarHeaderTitle);
		this.divCalendarHeader.appendChild(this.divCalendarHeaderDayList);
		
				
		this.addHoursDescription();
		this.addDaysDescription();
		this.addDayFields(); 
		
		
		
		
	}
	
	

	
}




class CalendarMonth {
	
	
	constructor (choosenDay) {
		
		//current day
		this.today = new Date();
		
		//day for which calendar will be generated
		this.selectedDay = new Date(choosenDay);
			
		
		//number of days in the month
        this.daysInMonth = new Date(this.selectedDay.getFullYear(), this.selectedDay.getMonth() + 1, 0).getDate();
		
		
		//beginning of the month
		this.monthFirstDay = new Date(this.selectedDay.getFullYear(), this.selectedDay.getMonth(), 1, 12, 0, 0, 0);
		
			//begining of the week with first day of the month
			this.monthFirstDayWeekBeginning = new Date((this.monthFirstDay.getTime()-(this.monthFirstDay.getDay())*24*60*60*1000));
		
		
		//last day in the month
		this.monthLastDay = new Date(this.selectedDay.getFullYear(), this.selectedDay.getMonth(), this.daysInMonth, 12, 0, 0, 0);
		
			//end of the week with last day of the month
			this.monthLastDayWeekEnding = new Date((this.monthLastDay.getTime()+(7 - 1 - this.monthLastDay.getDay())*24*60*60*1000));
		
		
		
        this.divCalendarCnt = null;
        this.divCalendarWorkspace = null;
        this.divCalendarHeader = null;
        this.divCalendarMainView = null;
        
        this.divCalendarHeaderTitle = null;
        this.divCalendarHeaderDayList = null;
		
		        
        
	}
	
	
	
	//Function to add calendar days descriptions
	addDaysDescription() {
		
		this.divCalendarHeaderTitle.setAttribute("id","divCalendarHeaderTitle");
	
		month_list = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
		day_list = ["Sun", "Mon", "Tues", "Wed", "Thur", "Fri", "Sat"];
		
		//Add header title
		var headerTitle = "";
		

		headerTitle = month_list[this.selectedDay.getMonth()] + " " + (this.selectedDay.getFullYear());

		
		this.divCalendarHeaderTitle.innerHTML = headerTitle;
		
		
		//keeps information about present calendar view (day for which this view was generated) - usufull when switching calendar view https://www.sitepoint.com/how-why-use-html5-custom-data-attributes/
		this.divCalendarHeaderTitle.setAttribute("data-identifier", "M" + this.checkDateCode(this.selectedDay));
			

		
		//Add days description
		var i=0;
		var insertHTMLcode = "";
		
		for (i; i<=6; i++)
		{
			
			
			insertHTMLcode += '<div class="calendarHeaderDay3">' + day_list[i] +'</div>';
			//insertHTMLcode += '<div class="calendarHeaderDay3">' + (this.selectedDay.getDate()) + ' ' + day_list[this.selectedDay.getDay()] +'</div>';
			
		}
		
		this.divCalendarHeaderDayList.innerHTML = insertHTMLcode;
	
	
	
	}
	
	
	
	checkDateCode(checkDate) {
		
		var result = "";
			
		result += checkDate.getFullYear();
				
		if (checkDate.getMonth() < 10) {
				
			result += "0" + checkDate.getMonth();
		} else {
			result += checkDate.getMonth();
		}
			
			
		if (checkDate.getDate() < 10) {
				
			result += "0" + checkDate.getDate();
		} else {
			result += checkDate.getDate();
		}
		
		return result;
	
	}
	
	
	
	checkHourCode(checkHour) {
		
		var result = "";
		var min = ""
		var hr = ""
		
		
		hr = checkHour * 4;
				
			
		if (hr < 10) {
				
			result = "_0" + hr + "00";
		} else {
			result = "_" + hr + "00";
		}
		
		return result;
		
	}

	
	//Function to add calendar days descriptions
	addDayFields() {
		
		var i=0;
		var j=0;
		var stop=0;
		var insertHTMLcode = "";	
		var tempDay = new Date(this.monthFirstDayWeekBeginning);
		
		//codes for div id
		var dateCode = "";
		var hourCode = "";
		
			
		
		do {
			
			insertHTMLcode += '<div class="calendarDaysRow">';
			
			
				for (i; i<=6; i++)
				{
					
					//Prepare day code - to add id atrribute to each div
					dateCode = this.checkDateCode(tempDay);
					
					
					insertHTMLcode += '<div class="calendarDayTile" id="' + dateCode + '">';
					
						if(tempDay.getMonth() == this.selectedDay.getMonth()) {					
	
							insertHTMLcode += '<div class="calendarDayTileHeader">' + tempDay.getDate() + '</div>';
							
						} else {
							
							insertHTMLcode += '<div class="calendarDayTileHeader2">' + tempDay.getDate() + '</div>';
							
						}
						
						
					
						for (j=0; j<=5; j++)
						{
							
							hourCode = this.checkHourCode(j);
							insertHTMLcode += '<div class="calendarDayTileHour" onclick="selectedByUser(this)" id="' + dateCode + hourCode + '"></div>';
					
						}
						
					
					insertHTMLcode += '</div>';
					
					tempDay.setDate(tempDay.getDate()+1);
			
					
					
				}
			
				i = 0;
			
			
			stop++;
			
			insertHTMLcode += '</div>';
		}
		while ((this.monthLastDayWeekEnding) > (tempDay) && stop<10); 
		
					
		
		this.divCalendarMainView.innerHTML = insertHTMLcode;
		
	}
	
	
	
	
	init() {
		
		this.divCalendarCnt = document.createElement("div");
		this.divCalendarCnt.classList.add("calendarCnt");
		
		this.divCalendarWorkspace = document.createElement("div");
		this.divCalendarWorkspace.classList.add("calendarWorkSpace");
		
		this.divCalendarHeader = document.createElement("div");
		this.divCalendarHeader.classList.add("calendarHeader");
		
		this.divCalendarMainView = document.createElement("div");
		this.divCalendarMainView.classList.add("calendarMainView2");
	
		this.divCalendarHeaderTitle = document.createElement("div");
		this.divCalendarHeaderTitle.classList.add("calendarHeaderTitle");
		
		this.divCalendarHeaderDayList = document.createElement("div");
		this.divCalendarHeaderDayList.classList.add("calendarHeaderDayList");
		
		this.divCalendarCnt.appendChild(this.divCalendarWorkspace);
		this.divCalendarWorkspace.appendChild(this.divCalendarHeader);
		this.divCalendarWorkspace.appendChild(this.divCalendarMainView);
		this.divCalendarHeader.appendChild(this.divCalendarHeaderTitle);
		this.divCalendarHeader.appendChild(this.divCalendarHeaderDayList);
		
				
		this.addDaysDescription();
		this.addDayFields(); 
		
		
		//------------------------
		//this.divCalendarHeaderTitle.innerHTML = "April 10-17" + " week beginning " + this.weekFirstDay.getDate() + " " + this.weekFirstDay.getMonth() 
		
		//+ " The end of the week " + this.weekLastDay.getDate() + " " + this.weekLastDay.getMonth();
		
		
	}
	
	

	
}












//window.onload = start;


var my_div = null;
var newDiv = null;


//oznaczenia np utworzonych przez uzytkownika wydarzen i.t.p
function addCalendarEvents (calendarView, viewType) 
{
	// TEST !!!!!!!!!!!!!!!!!!!!!!		
	//Mark current day in weekly view
	var searchedId = calendarView.checkDateCode(calendarView.today);
	if (document.getElementById(searchedId))
		document.getElementById(searchedId).classList.add('calendarMarkToday');
	
	
	if(viewType == "D") {
	
		
		console.log("Day view");
		
		var choosenDay = calendarView.selectedDay;
		
		//console.log("Load events for day: " + choosenDay);
		
		//Test
		var jsonUrl = window.contextRoot + '/json/data/calendarDayView/getEvents?year=' 
						+ choosenDay.getFullYear() + '&month=' 
						+ choosenDay.getMonth() + '&day=' + choosenDay.getDate();
		
		
		console.log(jsonUrl);
		
		
		$.getJSON(jsonUrl, function(data){ 
		      $.each(data, function(key, value){
		   
		    	 console.log("#################################"); 
		    	 console.log("Checking event with id: " + value.id);
		    	 var color_code = colorHashCode(value.owner_id);
		    	 
		    	 		    	  
		    	 var startDivId =  findDivIdForDate(value.start_date.year, 
		    			 							value.start_date.monthValue - 1, 
		    			 							value.start_date.dayOfMonth, 
		    			 							value.start_date.hour, 
		    			 							value.start_date.minute);
		    	  
		    	 var endDivId =  findDivIdForDate(value.end_date.year, 
							value.end_date.monthValue - 1, 
							value.end_date.dayOfMonth, 
							value.end_date.hour, 
							value.end_date.minute); 
		    	 
		    	 
		    	 console.log("Start div: " + startDivId);
		    	 console.log("End div: " + endDivId);
		    	 
		    	 
		    	 //check is another event already added in some of tiles booked for this event
		    	 var maxDivCount = -1;
		    	 var tempValue = -1;
		    	 
		    	 var checkDivWithId = startDivId;
		    	 var checkDiv;
		    	 
		    	 do {
		    		 
		    		 checkDiv = document.getElementById(checkDivWithId);
		    		 //console.log("Checking div: " + checkDivWithId);
		    		 
		    		 if(checkDiv){
		    			 tempValue =  document.getElementById(checkDivWithId).childElementCount;
		    			 //console.log("tempValue: " + tempValue);
		    			 if(tempValue > maxDivCount){
		    				 maxDivCount = tempValue;
		    				 //console.log("maxDivCount: " + maxDivCount);
		    			 }
		    			 		    			 
		    		 }
		    		 
		    		 checkDivWithId = findPreviousDiv(checkDivWithId);
		    		 
		    		 
		    	 }
		    	 while (checkDiv!=null && tempValue != 0);
		    	 
		    	 
		    	 
		    	 var firstDivFromArea = findNextDiv(checkDivWithId);
		    	 
		    	 console.log("firstDivFromArea: " + firstDivFromArea);
		    	 console.log("maxDivCount: " + maxDivCount);
		    	 
		    	 
		    	 
		    	 //---------------------------------------------------------------------
		    	 
		    	 checkDivWithId = endDivId;

		    	 do {
		    		 
		    		 checkDiv = document.getElementById(checkDivWithId);
		    		 //console.log("Checking div: " + checkDivWithId);
		    		 
		    		 if(checkDiv){
		    			 tempValue =  document.getElementById(checkDivWithId).childElementCount;
		    			 //console.log("tempValue: " + tempValue);
		    			 if(tempValue > maxDivCount){
		    				 maxDivCount = tempValue;
		    				 //console.log("maxDivCount: " + maxDivCount);
		    			 }
		    			 		    			 
		    		 }
		    		 
		    		 checkDivWithId = findNextDiv(checkDivWithId);
		    		 
		    		 
		    	 }
		    	 while (checkDiv!=null && tempValue != 0);
		    	 
		    	 
		    	 
		    	 var lastDivFromArea = findPreviousDiv(checkDivWithId);
		    	 
		    	 console.log("lastDivFromArea: " + lastDivFromArea);
		    	 console.log("maxDivCount: " + maxDivCount);
		    	 
		    	 
		    	 //---------------------------------------------------------------------
		    	 
		    	 checkDivWithId = startDivId;

		    	 do {
		    		 
		    		 checkDiv = document.getElementById(checkDivWithId);
		    		 console.log("Checking div: " + checkDivWithId);
		    		 
		    		 if(checkDiv){
		    			 tempValue =  document.getElementById(checkDivWithId).childElementCount;
		    			 console.log("tempValue: " + tempValue);
		    			 if(tempValue > maxDivCount){
		    				 maxDivCount = tempValue;
		    				 console.log("maxDivCount: " + maxDivCount);
		    			 }
		    			 		    			 
		    		 }
		    		 
		    		 checkDivWithId = findNextDiv(checkDivWithId);
		    		 
		    		 
		    	 }
		    	 while (checkDivWithId != findNextDiv(endDivId));
		    	 
		    	 console.log("maxDivCount: " + maxDivCount);
		    	 
		    	 //---------------------------------------------------------------------
		    	 
		    	 
		    	 
		    	 //Generate calendar view
		    	 
		    	 var tempDivId = firstDivFromArea;
		    	 var tempDiv;
		    	 var eventDivsArea = 0;
		    	 var insideDivsAmount = 0;
		    	 console.log("---------------------------------");
		    	 console.log("Adding this event to calendar");
		    	 
		    	 do {
		    		 
		    		 if(tempDivId == startDivId) {
		    			 eventDivsArea = 1;
		    		 }
		    		 
		    		 console.log("tempDivId: " + tempDivId);
		    		 console.log("eventDivsArea: " + eventDivsArea);
		    		 
		    		 //console.log("Checking div with id: " + tempDivId);
		    		 
		    		 
		    		 tempDiv = document.getElementById(tempDivId);
		    		 
		    		 if(tempDiv){
		    			 
		    			 insideDivsAmount = document.getElementById(tempDivId).childElementCount;
		    			 
		    			 if(eventDivsArea == 0 && insideDivsAmount != 0) {
		    				 
		    				 
		    				 var i;
		    				 for (i = 0; i < (maxDivCount-insideDivsAmount+1); i++) {
		    					 document.getElementById(tempDivId).innerHTML += '<div class="eventCalendarTile"></div>';
		    					 
		    					 console.log("fdfsfdadfdafadfdsfafdfas");
		    				 } 
		    				  				   				 
		    				 
		    			 }
		    			 else if(eventDivsArea == 1) {
		    				 
		    				 var j;
		    				 for (j = 0; j < (maxDivCount-insideDivsAmount); j++) {
		    					 document.getElementById(tempDivId).innerHTML += '<div class="eventCalendarTile"></div>';
		    				 } 
		    				 
					    	 document.getElementById(tempDivId).innerHTML += '<div class="eventCalendarTile" style = "background-color: ' 
					    		 + color_code + '; opacity: 0.7;"><a class="eventCalendarTileLink" href="' + window.contextRoot + '/viewEvent/' 
					    		 + value.id + '/basicView/' + '">' + value.title + '</a></div>';
		    				 
		    			 }
		    			 
		    			 

		    		 
		    		 
		    		 }

			    	 
		    		 
		    		 
		    		 
		    		 
		    		 
		    		 
		    		 if(tempDivId == endDivId) {
		    			 eventDivsArea = 0;
		    		 }
			    	 tempDivId = findNextDiv(tempDivId);
			    	 
			    	 //console.log("Next div id: " + tempDivId);
		    	 }
		    	 while (tempDivId != findNextDiv(lastDivFromArea));
		    	 
		    	 
		    	 
		    	 
		    	 
		    	 
		    	 ///////////////////////////////////////////////
		    	 
		    	 
		    	 
		    	 /*
		    	 var tempDivId = startDivId;
		    	 var tempDiv;
		    	 do {
		    		 
		    		 //console.log("Checking div with id: " + tempDivId);
		    		 
		    		 
		    		 tempDiv = document.getElementById(tempDivId);
		    		 
		    		 if(tempDiv){
				    	 document.getElementById(tempDivId).innerHTML += '<div class="eventCalendarTile" style = "background-color: ' 
				    		 + color_code + '; opacity: 0.7;"><a class="eventCalendarTileLink" href="' + window.contextRoot + '/viewEvent/' 
				    		 + value.id + '/basicView/' + '">' + value.title + '</a></div>';
		    		 }

			    	 
			    	 tempDivId = findNextDiv(tempDivId);
			    	 
			    	 //console.log("Next div id: " + tempDivId);
		    	 }
		    	 while (tempDivId != findNextDiv(endDivId));
		    	*/ 
		    	 
		    	 //console.log("#####################################");
		    	 
		    	 /*
		    	 document.getElementById(startDivId).innerHTML += '<div class="eventCalendarTile" style = "background-color: ' 
		    		 + color_code + '; opacity: 0.7;"><a class="eventCalendarTileLink" href="' + window.contextRoot + '/viewEvent/' 
		    		 + value.id + '/basicView/' + '">' + value.title + '</a></div>';
		    	 
		    	 
		    	 if(startDivId != endDivId) {
			    	 document.getElementById(endDivId).innerHTML += '<div class="eventCalendarTile" style = "background-color: ' 
			    		 + color_code + '; opacity: 0.7;"><a class="eventCalendarTileLink" href="' + window.contextRoot + '/viewEvent/' 
			    		 + value.id + '/basicView/' + '">' + value.title + '</a></div>';
			 
		      	 }
		    	 */
		    	 
		    	 //document.getElementById(startDivId).innerHTML += '<div class="eventCalendarTile" style="background-color: red;"></div>';
		        	
		    	 
		    	 //'<div class="eventCalendarTile" style += "background-color: ' + color_code + ';"></div>';
		    			    	 
		    	 //<a href="${contextRoot}/home" class="d-none d-md-block"><img src="${images}/logo_white.png" alt="Logo" title="Main page"></a>
		    	 
		      });

		  });
		
		///
		
		
		
		
		
		
		
		
		
		
	}
	
	
	
	
	if(viewType == "W") {
	
		
		console.log("Week view");
		
		var choosenWeekFirstDay = calendarView.weekFirstDay;
		var choosenWeekLastDay = calendarView.weekLastDay;
		
		console.log("Load events for week: " + choosenWeekFirstDay + "     -     " + choosenWeekLastDay);
		
	}
	
	
}








////////Pomocnicze funkcje

//Generate color based on event's owner id
function colorHashCode(owner_id) {
	
	owner_id = owner_id * 150;
	str = owner_id + "A";
	var hash = 0;
	for (var i = 0; i < str.length; i++) {
		hash = str.charCodeAt(i) + ((hash << 5) - hash);
	}
	var colour = '#';
	for (var i = 0; i < 3; i++) {
		var value = (hash >> (i * 8)) & 0xFF;
		colour += ('00' + value.toString(16)).substr(-2);
	}
	return colour;
} 



//Check div id code for selected date
function findDivIdForDate(date_year, date_month, date_day, date_hour, date_minutes) {
	
	var month_code = "";
	var date_code = "";
	var hour_code = "";
	var minutes_code = "";
	
	if(date_month < 10) {
		month_code = '0' + date_month;
	}
	else {
		month_code = date_month;
	}
	
	if(date_day < 10) {
		date_code = '0' + date_day;
	}
	else {
		date_code = date_day;
	}
	
	if(date_hour < 10) {
		hour_code = '0' + date_hour;
	}
	else {
		hour_code = date_hour;
	}
	
	if(date_minutes < 30) {
		minutes_code = '00';
	}
	else {
		minutes_code = '30';
	}
	
	return date_year + month_code + date_code + '_' + hour_code + minutes_code;
	
}




//znajdz wczesniejszy div
function findPreviousDiv(divId) {
	


	var year = divId.slice(0, 4);
	var month = divId.slice(4, 6);
	var day = divId.slice(6, 8);
	var hour = divId.slice(9, 11);
	var minutes = divId.slice(11, 13);

	//console.log("Year: " + year);
	//console.log("Month: " + month);
	//console.log("Day: " + day);
	//console.log("Hour: " + hour);
	//console.log("Minutes: " + minutes);



	var now = new Date(year, month, day, hour, minutes, 0, 0);
	//console.log(now);
	var searchedDate = new Date((now.getTime()-(30*60*1000))); //30 minutes earlier
	//console.log(searchedDate);
	
	
	//Extract div id
	var year_token = searchedDate.getFullYear();
	
	var month_token;
	if (searchedDate.getMonth() < 10){
		month_token = "0" + searchedDate.getMonth();		
	}
	else {
		month_token = searchedDate.getMonth();
	}
	
	var date_token;
	if (searchedDate.getDate() < 10){
		date_token = "0" + searchedDate.getDate();		
	}
	else {
		date_token = searchedDate.getDate();
	}
	
	
	var hour_token;
	if (searchedDate.getHours() < 10){
		hour_token = "0" + searchedDate.getHours();		
	}
	else {
		hour_token = searchedDate.getHours();
	}
	
	
	var minutes_token;
	if (searchedDate.getMinutes() == 0){
		minutes_token = "0" + searchedDate.getMinutes();		
	}
	else {
		minutes_token = searchedDate.getMinutes();
	}
	
	
	
	var searchedDivId = year_token + month_token + date_token + "_" + hour_token + minutes_token;
	//var searchedDivId = searchedDate.getFullYear();
	
	return searchedDivId;
	
}


//find next div
function findNextDiv(divId) {
	


	var year = divId.slice(0, 4);
	var month = divId.slice(4, 6);
	var day = divId.slice(6, 8);
	var hour = divId.slice(9, 11);
	var minutes = divId.slice(11, 13);

	//console.log("Year: " + year);
	//console.log("Month: " + month);
	//console.log("Day: " + day);
	//console.log("Hour: " + hour);
	//console.log("Minutes: " + minutes);



	var now = new Date(year, month, day, hour, minutes, 0, 0);
	//console.log(now);
	var searchedDate = new Date((now.getTime()+(30*60*1000))); //30 minutes earlier
	//console.log(searchedDate);
	
	
	//Extract div id
	var year_token = searchedDate.getFullYear();
	
	var month_token;
	if (searchedDate.getMonth() < 10){
		month_token = "0" + searchedDate.getMonth();		
	}
	else {
		month_token = searchedDate.getMonth();
	}
	
	var date_token;
	if (searchedDate.getDate() < 10){
		date_token = "0" + searchedDate.getDate();		
	}
	else {
		date_token = searchedDate.getDate();
	}
	
	
	var hour_token;
	if (searchedDate.getHours() < 10){
		hour_token = "0" + searchedDate.getHours();		
	}
	else {
		hour_token = searchedDate.getHours();
	}
	
	
	var minutes_token;
	if (searchedDate.getMinutes() == 0){
		minutes_token = "0" + searchedDate.getMinutes();		
	}
	else {
		minutes_token = searchedDate.getMinutes();
	}
	
	
	
	var searchedDivId = year_token + month_token + date_token + "_" + hour_token + minutes_token;
	//var searchedDivId = searchedDate.getFullYear();
	
	return searchedDivId;
	
}




//////////////////////////////////////////////////












//Load initial view when page is loaded (by default it's week view)
function loadCalendar()
{
	
	//today
	var today = new Date();
		
	const cal = new CalendarWeek(today);
	cal.init();

	my_div = document.getElementById("calendarViewWrapper");
	
	test1 = cal.divCalendarCnt;
		
	document.getElementById("calendarViewWrapper").appendChild(test1);
		
	
	addCalendarEvents(cal, "W");
	
	
}



function generateCalendarView(dateSelected, viewType) {
	
	str1=""
	
	//clear current calendar view
	document.getElementById("calendarViewWrapper").innerHTML = "";
	
	
	
	if (viewType == "W") {
		const cal = new CalendarWeek(dateSelected);
		cal.init();
		document.getElementById("calendarViewWrapper").appendChild(cal.divCalendarCnt);
		
		addCalendarEvents(cal, "W");



	} else if (viewType == "D") {
		const cal = new CalendarDay(dateSelected);
		cal.init();
		document.getElementById("calendarViewWrapper").appendChild(cal.divCalendarCnt);
		
		addCalendarEvents(cal, "D");
	} else if (viewType == "M") {
		const cal = new CalendarMonth(dateSelected);
		cal.init();
		document.getElementById("calendarViewWrapper").appendChild(cal.divCalendarCnt);
		
		addCalendarEvents(cal, "M");
	} else {
		str1 = "sdhhsds";
	}
	
	
	
	
}




function switchCalendar(options) {
	
	//div id=divCalendarHeaderTitle keep information about current view of calendar
	var currentView = document.getElementById("divCalendarHeaderTitle").getAttribute("data-identifier");
	
	
	var calendarType = currentView.substring(0, 1);
	var dayYear = parseInt(currentView.substring(1, 5));
	var dayMonth = parseInt(currentView.substring(5, 7));
	var dayDate = parseInt(currentView.substring(7, 9));
	
	var currentDay = new Date(dayYear,dayMonth,dayDate);
	
	var jumpToDate = 0;
	if (calendarType == "W") {
		jumpToDate = 7;
	} else if (calendarType == "D") {
		jumpToDate = 1;
	} else {
		
		//number of days in a month
		var numberOfDays = new Date(dayYear, dayMonth + 1, 0).getDate();
		
		
		jumpToDate = numberOfDays;
	}
	
	switch (options) {
	case 0:
		var nextChoosenDay = new Date((currentDay.getTime()-(jumpToDate)*24*60*60*1000));
		generateCalendarView(nextChoosenDay, calendarType);
		break;
	case 1:
		var nextChoosenDay = new Date((currentDay.getTime()+(jumpToDate)*24*60*60*1000));
		generateCalendarView(nextChoosenDay, calendarType);	
		break;
	case 2:
		generateCalendarView(currentDay, "D");	
		break;
	case 3:
		generateCalendarView(currentDay, "W");	
		break;
	case 4:
		generateCalendarView(currentDay, "M");	
		break;	

	
	case 5:
		var nextChoosenDay = new Date();
		generateCalendarView(nextChoosenDay, calendarType);
		break;
	


	}
	
	
	
	
	
	
	
	
	//var str = "Hello world!";
//var res = str.substring(1, 4);
	
	
	
	//document.getElementById("footer").innerHTML = currentView + " " + calendarType + " " + dayYear + " " + dayMonth + " " + dayDate + " opton " + options + " jump " + jumpToDate;
}
	



function selectedByUser(divObj) {
	
	divObj.classList.toggle('calendarUserSelect');
}






