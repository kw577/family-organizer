
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

				<form>
					<div class="createEventFormBody">



						<div class="form-group">
							<label for="name" style="font-size: 14px;">New Event's
								name:</label> <input type="text" class="form-control" id="name"
								placeholder="Enter title" name="name">
						</div>



						<div class="form-row" style="border-bottom: 1px solid #283454; padding-bottom: 5px;">
							<div class="col">
								<label for="name" style="font-size: 14px;">Start - day:</label> <input
									type="text" class="form-control" id="start_date"
									placeholder="Start date" name="start_date" onkeydown="return false">
							</div>
							<div class="col">
								<label for="name" style="font-size: 14px;">Start - time:</label> <input
									type="text" class="form-control" id="start_time"
									placeholder="Start time" name="start_time">
							</div>
						</div>

						<div class="form-row" style="padding-top: 5px;">
							<div class="col">
								<label for="name" style="font-size: 14px;">End - day:</label> <input
									type="text" class="form-control" id="end_date"
									placeholder="End date" name="end_date" onkeydown="return false">
							</div>
							<div class="col">
								<label for="name" style="font-size: 14px;">End - time:</label> <input
									type="text" class="form-control" id="end_time"
									placeholder="End time" name="end_time">
							</div>
						</div>


						<div class="form-group">
							<label for="description" style="font-size: 14px;">Description:</label>
							<textarea class="form-control" id="description"
								placeholder="Enter event's description" name="description"></textarea>
						</div>


						<div class="form-group">
							<label for="email" style="font-size: 14px;">Localization:</label>
							<input type="text" class="form-control" id="localization"
								placeholder="Enter event's localization" name="localization">
						</div>
					</div>



					<div class="createEventFormFooter">
						<button type="submit" class="btn btn-primary">Submit</button>
						<button class="btn btn-danger">Cancel</button>

					</div>
					
					
					
		
					
					
					

				</form>

			</div>

		</div>


	</div>


</section>




