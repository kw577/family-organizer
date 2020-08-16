
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<%@taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>

<section class="createEventFormView">

	<div class="container-fluid">

		<div class="row">

			<div class="createEventFormWrapper">

				<div class="createEventFormHeader">Create new event:</div>



				<sform:form id="addNewEventForm" modelAttribute="newEvent"
							action="${contextRoot}/addNewEvent/"
							name="addNewEventForm" method="post">


					<div class="createEventFormBody">

						<div class="form-group">
							<label for="title" style="font-size: 14px;">New Event's name:</label> 
							<sform:input type="text" class="form-control" placeholder="Enter title" 
								path="title" id="title" name="title" maxlength="250"/>
						</div>


						<div class="form-row" style="border-bottom: 1px solid #283454; padding-bottom: 5px;">
							<div class="col">
								<label for="start_day" style="font-size: 14px;">Start - day:</label> 
								<sform:input type="text" class="form-control" placeholder="Start date" 
									path="start_day" id="start_day" name="start_day" onkeydown="return false"/>			
							</div>
							<div class="col">			
								<label for="start_time" style="font-size: 14px;">Start - time:</label> 
								<sform:input type="text" class="form-control" placeholder="Start time" 
									path="start_time" id="start_time" name="start_time"/>					
							</div>
						</div>


						<div class="form-row" style="padding-top: 5px;">
							<div class="col">
								<label for="end_day" style="font-size: 14px;">End - day:</label> 
								<sform:input type="text" class="form-control" placeholder="End date" 
									path="end_day" id="end_day" name="end_day" onkeydown="return false"/>			
							</div>
							<div class="col">			
								<label for="end_time" style="font-size: 14px;">End - time:</label> 
								<sform:input type="text" class="form-control" placeholder="End time" 
									path="end_time" id="end_time" name="end_time"/>					
							</div>
						</div>


						<div class="form-group">			
							<label for="description" style="font-size: 14px;">Description:</label> 
							<sform:textarea type="text" class="form-control" placeholder="Enter event's description" 
								path="description" id="description" name="description" maxlength="2500"/>
						</div>

						<div class="form-group">	
							<label for="localization" style="font-size: 14px;">Localization:</label> 
							<sform:input type="text" class="form-control" placeholder="Enter event's localization" 
								path="localization" id="localization" name="localization" maxlength="250"/>
						</div>
					</div>

					<sform:hidden path="family_id" />
					<sform:hidden path="owner_id" />

					<div class="createEventFormFooter">
						<input type="submit" class="btn btn-primary" value="Save">
						<a href="${contextRoot}/home"><button class="btn btn-danger">Cancel</button></a>
					</div>
								

				</sform:form>

			</div>

		</div>


	</div>


</section>




