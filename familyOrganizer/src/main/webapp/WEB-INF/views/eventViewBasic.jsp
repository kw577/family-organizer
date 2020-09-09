
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<%@taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<section class="eventsPanelView">

	<div class="container-fluid">

		<div class="row">

			<div class="eventsPanelWrapper">

				<div class="eventsPanelHeader">

					<div class="eventDetailViewHeader">
						<div class="eventDetailViewHeaderItem1">Event basic view:</div>
						<div class="eventDetailViewHeaderItem2">
							<button type="button" class="btn btn-info" title="Go back"
								onclick="window.history.back();">
								<i class="fas fa-arrow-left fa-lg"></i>&#32; BACK
							</button>
						</div>
					</div>


				</div>

				<div class="eventsPanelBody">

					<c:if test="${not empty viewEvent}">
						<div class="singleEventView">
							<div class="eventViewHeader">

								<div class="eventViewHeaderItem1">
									${viewEvent.title}
						
									
									<c:if test="${not empty eventNotification}">
										<c:if test="${eventNotification.type == 1}">
											<i class="far fa-thumbs-up text-success" style="font-size:23px;" title="${eventNotification.description}"></i>
										</c:if>
										<c:if test="${eventNotification.type == 2}">
											<i class="far fa-thumbs-down text-danger" style="font-size:23px;" title="${eventNotification.description}"></i>
										</c:if>
									 	<c:if test="${eventNotification.type == 3}">
											<i class="fas fa-exclamation-circle text-warning" style="font-size:23px;" title="${eventNotification.description}"></i>
										</c:if>
									 	<c:if test="${eventNotification.type == 4}">
											<i class="far fa-calendar-times text-warning" style="font-size:23px;" title="${eventNotification.description}"></i>
										</c:if>
									 	<c:if test="${eventNotification.type == 5}">
											<i class="far fa-comment-dots text-info" style="font-size:23px;" title="${eventNotification.description}"></i>
										</c:if>
									 	
									</c:if>
								</div>
								<div class="eventViewHeaderItem2">


									<c:if test="${viewButtonActive == true }">
										<a href="${contextRoot}/viewEvent/${viewEvent.id}/detailView"
											title="View details">
											<button type="button" class="btn btn-info">
												<i class="fas fa-info-circle"></i>
											</button>
										</a>
									</c:if>


									<c:if test="${viewEvent.owner_id == userModel.id }">

										<button type="button" class="btn btn-warning"
											data-toggle="modal" data-target="#modifyEventModal"
											onclick="fillModifyEventForm('<c:out value="${viewEvent.id}"/>', '<c:out value="${viewEvent.owner_id}"/>', '<c:out value="${viewEvent.title}"/>', '<c:out value="${viewEvent.description}"/>', '<c:out value="${viewEvent.localization}"/>')">
											<i class="fas fa-pen"></i>
										</button>


										<button type="button" class="btn btn-danger"
											data-toggle="modal" data-target="#deleteEventModal"
											onclick="fillDeleteEventForm('<c:out value="${viewEvent.id}"/>', '<c:out value="${viewEvent.owner_id}"/>', '<c:out value="${viewEvent.title}"/>')">
											<i class="fas fa-trash-alt"></i>
										</button>

									</c:if>

								</div>

							</div>

							<div class="eventViewBody">

								<div class="eventViewBodyItem1">
									<div class="eventViewDescription">
										<span><i class="far fa-calendar fa-lg"></i></span>&#09;
										<c:set var="start_date" value="${viewEvent.start_date}" />
										<c:set var="start_date_format"
											value="${fn:replace(start_date, 'T', ' ')}" />
										${start_date_format}
									</div>
									<div class="eventViewDescription">
										<span><i class="far fa-calendar-check fa-lg"></i></span>&#09;
										<c:set var="end_date" value="${viewEvent.end_date}" />
										<c:set var="end_date_format"
											value="${fn:replace(end_date, 'T', ' ')}" />
										${end_date_format}
									</div>
									<div class="eventViewDescription">
										<span><i class="fas fa-globe-europe fa-lg"></i></span>&#09;
										${viewEvent.localization}
									</div>

								</div>

								<div class="eventViewBodyItem2">${viewEvent.description}</div>

							</div>

						</div>
						
						
						
						<div class="eventNotificationBox">
						
							<div class="eventNotificationHeader bg-info">
								<div class="eventViewHeaderItem1">Event notification</div>
								<div class="eventViewHeaderItem2">
									<c:if test="${empty eventNotification}">
										<button type="button" class="btn btn-secondary"
											data-toggle="modal" data-target="#addEventNotificationModal">
											Add <i class="fas fa-plus"></i>
										</button>			
									</c:if>	
								</div>
							</div>
							
							<div class="eventNotificationBody">
								<c:if test="${not empty eventNotification}">
									<table id="eventNotificationTable">
										<tr>
											<td style="font-size:40px;">
												<c:if test="${eventNotification.type == 1}">
													<i class="far fa-thumbs-up text-success" style="font-size:40px;"></i>
												</c:if>
												<c:if test="${eventNotification.type == 2}">
													<i class="far fa-thumbs-down text-danger" style="font-size:40px;"></i>
												</c:if>
											 	<c:if test="${eventNotification.type == 3}">
													<i class="fas fa-exclamation-circle text-warning" style="font-size:40px;"></i>
												</c:if>
											 	<c:if test="${eventNotification.type == 4}">
													<i class="far fa-calendar-times text-warning" style="font-size:40px;"></i>
												</c:if>
											 	<c:if test="${eventNotification.type == 5}">
													<i class="far fa-comment-dots text-info" style="font-size:40px;"></i>
												</c:if>
											
											</td>
											<td>Jan Nowak</td>
											<td>10.09.2020</td>
											<td>${eventNotification.description}</td>
											<td style="min-width:110px;">
												
												<button type="button" class="btn btn-warning">
													<i class="fas fa-pen"></i>
												</button>
												
																			
																	
										
												<button type="button" class="btn btn-danger">
													<i class="fas fa-trash-alt"></i>
												</button>
												
											</td>
										</tr>
									</table>
								</c:if>
							
										
																		
							
							
							</div>		
						</div>
						
						
						
					</c:if>





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
					action="${contextRoot}/timeline/deleteEvent" name="deleteEventForm"
					method="post">
					<!-- Modal body -->
					<div class="modal-body">

						Are you sure that you want to delete this event ?
						<div id="deleteEventInfo"
							style="font-size: 16px; margin-top: 10px;"></div>

						<div class="form-group">
							<sform:input type="hidden" placeholder="id" path="id" id="id"
								name="id" />
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
						<input type="submit" class="btn btn-danger" value="Delete">
						<button type="button" class="btn btn-basic" data-dismiss="modal">Cancel</button>
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
					action="${contextRoot}/timeline/modifyEvent/"
					name="modifyEventForm" method="post">
					<!-- Modal body -->
					<div class="modal-body">

						<div style="font-size: 16px; margin-top: 10px;">Here you can
							edit your event:</div>


						<div class="form-group">
							<label for="title" style="font-size: 12px; margin-top: 20px;">Event's
								name:</label>
							<sform:input type="text" class="form-control" path="title"
								id="title" name="title" maxlength="250" />
						</div>

						<div class="form-group">
							<label for="description" style="font-size: 12px;">Description:</label>
							<sform:textarea type="text" class="form-control"
								path="description" id="description" name="description"
								maxlength="2500" />
						</div>


						<div class="form-group">
							<label for="localization" style="font-size: 12px;">Localization:</label>
							<sform:input type="text" class="form-control" path="localization"
								id="localization" name="localization" maxlength="250" />
						</div>


						<div class="form-group">
							<sform:input type="hidden" placeholder="id" path="id" id="id"
								name="id" />
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
						<input type="submit" class="btn btn-primary" value="Save">
						<button type="button" class="btn btn-basic" data-dismiss="modal">Cancel</button>
					</div>
				</sform:form>
			</div>
		</div>
	</div>






	<!-- Add event notification -->
	<div class="modal fade" id="addEventNotificationModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title">Add notification to this event:</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>


				<sform:form id="addEventNotificationForm" modelAttribute="newNotification"
					action="${contextRoot}/manage/addNotification/" name="addEventNotificationForm"
					method="post">
					<!-- Modal body -->
					<div class="modal-body">


						<div class="form-group">
							<label style="font-size: 12px;">Notification type:</label>
							<sform:select class="form-control" id="type" name="type" path="type">
								<sform:option value="1">Permission</sform:option>
								<sform:option value="2">Refusal</sform:option>
								<sform:option value="3">High Priority</sform:option>
								<sform:option value="4">Conflict other event</sform:option>
								<sform:option value="5">Information</sform:option>
							</sform:select>
						</div>



						<div class="form-group">			
								<label for="description" style="font-size: 12px;">
									Description:
								</label> 
								<sform:textarea type="text" class="form-control" placeholder="Enter your comment..." 
									path="description" id="description" name="description" maxlength="490"/>
						</div>


						<div class="form-group">
							<sform:input type="hidden" path="event_id"
							id="event_id" name="event_id" value="${viewEvent.id}"/>
						</div>



						<sform:hidden path="id" />
						<sform:hidden path="owner_id" />
						<sform:hidden path="family_id" />
						<sform:hidden path="date_posted" />
				

					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<input type="submit" class="btn btn-primary" value="Save">
						<button type="button" class="btn btn-basic" data-dismiss="modal">Cancel</button>
					</div>
				</sform:form>
			</div>
		</div>
	</div>



















</section>





