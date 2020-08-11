<nav class="navbar navbar-expand-md navbar-dark" id="calendarControls">
								
	 <div class="btn-group">
		<!-- Button to switch calendar left  -->
		<button type="button" id="switchLeft" class="btn btn-secondary btn-sm" onclick="switchCalendar(0)" title="Go to an earlier date"><i class="icon-angle-circled-left"></i></button>	
							
		<!-- Button to jump to current date  -->
		<button type="button" id="switchOnToday" class="btn btn-secondary btn-sm" onclick="switchCalendar(5)" title="Go to current date"><i class="icon-home"></i></button>							
						
		<!-- Button to switch calendar right  -->
		<button type="button" id="switchRight" class="btn btn-secondary btn-sm" onclick="switchCalendar(1)" title="Go to an older date"><i class="icon-angle-circled-right"></i></button>
	</div> 
					
									
	<!-- Button for mobile view  -->
	<button class="navbar-toggler calendarToggler" type="button" data-target="#switchViews" data-toggle="collapse" aria-label="Calendar views toggle" aria-controls="switchViews" aria-expanded="false">
		<!--<i class="icon-menu"></i>-->
		<span class="navbar-toggler-icon"></span>
	</button>
					
	<div id="switchViews" class="collapse navbar-collapse ml-auto w-100 justify-content-end">
								
		<div class="btn-group">								
			<button type="button" id="dayView" class="btn btn-secondary btn-sm mybutton" onclick="switchCalendar(2)" title="Day view"><span>D</span></button>
			<button type="button" id="weekView" class="btn btn-secondary btn-sm mybutton" onclick="switchCalendar(3)" title="Week view"><span>W</span></button>	
			<button type="button" id="monthView" class="btn btn-secondary btn-sm mybutton" onclick="switchCalendar(4)" title="Month view"><span>M</span></button>	
		</div> 							
												
	</div>
									
</nav>