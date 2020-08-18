
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<%@taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<section class="eventsPanelView">

	<div class="container-fluid">

		<div class="row">

			<div class="eventsPanelWrapper">

				<div class="eventsPanelHeader">
					<h3>Event's Control Panel</h3>
					Here you can manage your events:
				</div>

				<div class="eventsPanelBody">


					<c:forEach items="${userEventsList}" var="userEvent">
						<div class="singleEventView">
							<div class="eventViewHeader">

								<div class="eventViewHeaderItem1">${userEvent.title}</div>
								<div class="eventViewHeaderItem2">

									<button type="button" class="btn btn-info">

										<i class="fas fa-info-circle"></i>

									</button>
			
									
									<button type="button" class="btn btn-warning" 
									data-toggle="modal" data-target="#modifyEventModal"
									onclick="fillModifyEventForm('<c:out value="${userEvent.id}"/>', '<c:out value="${userEvent.owner_id}"/>', '<c:out value="${userEvent.title}"/>', '<c:out value="${userEvent.description}"/>', '<c:out value="${userEvent.localization}"/>')"
									>
										<i class="fas fa-pen"></i>
									</button>
									
													
									<button type="button" class="btn btn-danger" 
									data-toggle="modal" data-target="#deleteEventModal"
									onclick="fillDeleteEventForm('<c:out value="${userEvent.id}"/>', '<c:out value="${userEvent.owner_id}"/>', '<c:out value="${userEvent.title}"/>')"
									>
										<i class="fas fa-trash-alt"></i>
									</button>
									
								

								</div>

							</div>

							<div class="eventViewBody">

								<div class="eventViewBodyItem1">
									<div class="eventViewDescription">
										<span><i class="far fa-calendar fa-lg"></i></span>&#09;
										<c:set var = "start_date" value="${userEvent.start_date}"/>
      									<c:set var = "start_date_format" value = "${fn:replace(start_date, 'T', ' ')}" />
										${start_date_format}
									</div>
									<div class="eventViewDescription">
										<span><i class="far fa-calendar-check fa-lg"></i></span>&#09;
										<c:set var = "end_date" value="${userEvent.end_date}"/>
      									<c:set var = "end_date_format" value = "${fn:replace(end_date, 'T', ' ')}" />
										${end_date_format}									
									</div>
									<div class="eventViewDescription">
										<span><i class="fas fa-globe-europe fa-lg"></i></span>&#09;
										${userEvent.localization}
									</div>

								</div>

								<div class="eventViewBodyItem2">${userEvent.description}</div>

							</div>

						</div>
					</c:forEach>




				</div>

			</div>


		</div>

	</div>


	<!-- Delete event -->
	<div class="modal fade" id="deleteEventModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title">Delete Event</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>


				<sform:form id="deleteEventForm" modelAttribute="delEvent"
					action="${contextRoot}/deleteEvent/"
					name="deleteEventForm" method="post">
					<!-- Modal body -->
					<div class="modal-body">

						Are you sure that you want to delete this event ?
						<div id="deleteEventInfo" style="font-size: 16px; margin-top: 10px;">
						</div>

						<div class="form-group">
							<sform:input type="hidden" placeholder="id" path="id"
								id="id" name="id" />
						</div>
						
						<div class="form-group">
							<sform:input type="hidden" placeholder="owner_id" path="owner_id"
								id="owner_id" name="owner_id" />
						</div>

						<sform:hidden path="family_id" />
						<sform:hidden path="title" />
						<sform:hidden path="start_date" />
						<sform:hidden path="end_date" />
						<sform:hidden path="localization" />
						<sform:hidden path="description" />

					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<input type="submit" class="btn btn-danger"
								value="Delete">
						<button type="button" class="btn btn-basic"
							data-dismiss="modal">Cancel</button>
					</div>
				</sform:form>
			</div>
		</div>
	</div>





	<!-- Modify event -->
	<div class="modal fade" id="modifyEventModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title">Edit your event</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>


				<sform:form id="modifyEventForm" modelAttribute="modEvent"
					action="${contextRoot}/modifyEvent/"
					name="modifyEventForm" method="post">
					<!-- Modal body -->
					<div class="modal-body">

						<div style="font-size: 16px; margin-top: 10px;">
							Here you can edit your event:
						</div>


						<div class="form-group">
							<label for="title" style="font-size: 12px; margin-top: 20px;">Event's name:</label>
							<sform:input type="text" class="form-control" path="title"
								id="title" name="title" maxlength="250"/>
						</div>		
						
						<div class="form-group">			
							<label for="description" style="font-size: 12px;">Description:</label> 
							<sform:textarea type="text" class="form-control" path="description" 
							id="description" name="description" maxlength="2500"/>
						</div>
						
						
						<div class="form-group">
							<label for="localization" style="font-size: 12px;">Localization:</label>
							<sform:input type="text" class="form-control" path="localization"
								id="localization" name="localization"  maxlength="250"/>
						</div>


						<div class="form-group">
							<sform:input type="hidden" placeholder="id" path="id"
								id="id" name="id" />
						</div>
						
						<div class="form-group">
							<sform:input type="hidden" placeholder="owner_id" path="owner_id"
								id="owner_id" name="owner_id" />
						</div>
						

						<sform:hidden path="family_id" />
						<sform:hidden path="start_date" />
						<sform:hidden path="end_date" />


					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<input type="submit" class="btn btn-primary"
								value="Save">
						<button type="button" class="btn btn-basic"
							data-dismiss="modal">Cancel</button>
					</div>
				</sform:form>
			</div>
		</div>
	</div>





</section>





