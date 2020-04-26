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
					insertHTMLcode += '<div class="calendarDayHour" onclick="selectedByUser(this)" id="' + dateCode + hourCode + '">' + hourCode +'</div>';
			
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
				insertHTMLcode += '<div class="calendarDayHour" onclick="selectedByUser(this)" id="' + dateCode + hourCode + '">' + hourCode +'</div>';
			
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
							insertHTMLcode += '<div class="calendarDayTileHour" onclick="selectedByUser(this)" id="' + dateCode + hourCode + '">' + hourCode +'</div>';
					
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
function addCalendarEvents (calendarView) 
{
	// TEST !!!!!!!!!!!!!!!!!!!!!!		
	//Mark current day in weekly view
	var searchedId = calendarView.checkDateCode(calendarView.today);
	if (document.getElementById(searchedId))
		document.getElementById(searchedId).classList.add('calendarMarkToday');
	
	
	
}


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
		
	
	addCalendarEvents(cal);
	
	
}



function generateCalendarView(dateSelected, viewType) {
	
	str1=""
	
	//clear current calendar view
	document.getElementById("calendarViewWrapper").innerHTML = "";
	
	
	
	if (viewType == "W") {
		const cal = new CalendarWeek(dateSelected);
		cal.init();
		document.getElementById("calendarViewWrapper").appendChild(cal.divCalendarCnt);
		
		addCalendarEvents(cal);



	} else if (viewType == "D") {
		const cal = new CalendarDay(dateSelected);
		cal.init();
		document.getElementById("calendarViewWrapper").appendChild(cal.divCalendarCnt);
		
		addCalendarEvents(cal);
	} else if (viewType == "M") {
		const cal = new CalendarMonth(dateSelected);
		cal.init();
		document.getElementById("calendarViewWrapper").appendChild(cal.divCalendarCnt);
		
		addCalendarEvents(cal);
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






