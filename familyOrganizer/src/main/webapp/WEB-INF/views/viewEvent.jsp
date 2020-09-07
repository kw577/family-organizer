
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<%@taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<section class="eventDetailedView">

	<div class="container-fluid">

		<div class="row">

			<div class="eventDetailViewWrapper">

				<div class="eventDetailViewHeader">
					<div class="eventDetailViewHeaderItem1">Event preview:</div>
					<div class="eventDetailViewHeaderItem2">
						<button type="button" class="btn btn-info" title="Go back" onclick="window.history.back();">
							<i class="fas fa-arrow-left fa-lg"></i>&#32; BACK
						</button>
					</div>
				</div>

				<div class="eventDetailViewBody">


					<c:if test="${not empty viewEvent}">

						<div class="eventDetailViewCard">
							<div class="eventDetailCardHeader">

								<div class="eventDetailCardHeaderItem1">${viewEvent.title}</div>
								<div class="eventDetailCardHeaderItem2">
									
												
									<c:if test="${viewEvent.owner_id == userModel.id }"> 
											
								
										<button type="button" class="btn btn-warning" title="Edit event"
										data-toggle="modal" data-target="#modifyEventModal1"
										onclick="fillModifyEventForm1('<c:out value="${viewEvent.id}"/>', '<c:out value="${viewEvent.owner_id}"/>', '<c:out value="${viewEvent.title}"/>', '<c:out value="${viewEvent.description}"/>', '<c:out value="${viewEvent.localization}"/>')"
										>
											<i class="fas fa-pen"></i>
										</button>
								
								
										
										<button type="button" class="btn btn-danger" title="Delete event"
										data-toggle="modal" data-target="#deleteEventModal1"
										onclick="fillDeleteEventForm1('<c:out value="${viewEvent.id}"/>', '<c:out value="${viewEvent.owner_id}"/>', '<c:out value="${viewEvent.title}"/>')"
										>
											<i class="fas fa-trash-alt"></i>
										</button>
												
										
									</c:if>	
									
									
									
	

								</div>

							</div>



							<div class="eventDetailCardBody">

								<div class="eventDetailCardBasic">
									<div class="eventDetailCardInfo">
										<span><i class="far fa-calendar fa-lg"
											title="Start date"></i></span>
												<c:set var = "start_date" value="${viewEvent.start_date}"/>
      											<c:set var = "start_date_format" value = "${fn:replace(start_date, 'T', ' ')}" />
												&#09; ${start_date_format}		
									</div>
									<div class="eventDetailCardInfo">
										<span><i class="far fa-calendar-check fa-lg"
											title="End date"></i></span>
												<c:set var = "end_date" value="${viewEvent.end_date}"/>
      											<c:set var = "end_date_format" value = "${fn:replace(end_date, 'T', ' ')}" />
												&#09; ${end_date_format}		
									</div>
									<div class="eventDetailCardInfo">
										<span><i class="fas fa-globe-europe fa-lg"
											title="Localization"></i></span>&#09; ${viewEvent.localization}
									</div>

								</div>

								<div class="eventDetailCardParticipants">

									<div class="eventDetailCardParticipantsItem1">
										<span><i class="fas fa-users fa-lg"
											title="Participants"></i></span>&#09;${eventOwner.name} ${eventOwner.surname}
											<c:forEach items="${peopleInvited}" var="personInvited">
												&#44;&#09;${personInvited.name} ${personInvited.surname}
											</c:forEach>
											
									</div>

									<div class="eventDetailCardParticipantsItem2">
										
										<c:if test="${viewEvent.owner_id == userModel.id }"> 
										
											<c:if test="${not empty peopleNotInvited}">
												<button type="button" class="btn btn-warning" title="Add participant"
												data-toggle="modal" data-target="#addNewInvitationModal"
												onclick="fillAddNewInvitationForm('<c:out value="${viewEvent.id}"/>')"
												>
													<i class="fas fa-user-plus"></i>
												</button>
							
											</c:if>		
											
											
											<c:if test="${not empty peopleInvited}">
												<button type="button" class="btn btn-danger" title="Cancel invitation"
												data-toggle="modal" data-target="#deleteInvitationModal"
												onclick="fillDeleteInvitationForm('<c:out value="${viewEvent.id}"/>')"
												>
													<i class="fas fa-user-minus"></i>
												</button>
							
											</c:if>	
											
													
										</c:if>	
										
									</div>

								</div>

								<div class="eventDetailCardDescription">
									<span style="font-weight: bold;">Description:</span></br> 
									${viewEvent.description}
								</div>
								
								
								
					
								
								
								
								
								<div class="eventDetailCardAttachements">
								
									<div class="attachements_header">Attachments:</div>

									<div class="attachements_body">

										<div class="row">
										
										
											<c:forEach items="${listOfAttachments}" var="eventAttachment">
												<div class="col-sm-6 col-md-3 col-xl-2" data-toggle="modal" data-target="#viewAttachementModal" 
												style="margin-bottom: 25px;" onclick="fillViewAttachementModal('<c:out value="${contextRoot}"/>', '<c:out value="${eventAttachment.owner}"/>', '<c:out value="${eventAttachment.date_posted}"/>', '<c:out value="${eventAttachment.code}"/>')">
													<div class="attachement_cnt">
														<div class="attachement_content" style='height: 100%; width: 100%;'>
															<img src="${contextRoot}/resources/images/${eventAttachment.code}.jpg" style='height: 100%; width: 100%; object-fit: contain'>	
														</div>
													</div>										
												</div>
											</c:forEach>
										
																							
											
										</div>

									</div>



									<div class="attachements_footer">
			
										<sform:form id="addNewAttachmentForm" modelAttribute="newAttachment"
											action="${contextRoot}/addAttachment/"
											enctype="multipart/form-data"
											name="addNewAttachmentForm" method="post">
									
						
											<div class="form-row align-items-center">
											    <div class="col-auto">
													<sform:input type="file" path="file" id="file" name="file" class="form-control" 
													accept=".jpg,.jpeg,.png" required="required"/>
											    </div>
											   
												<div class="form-group">
													<sform:input type="hidden" path="event_id"
														id="event_id" name="event_id" value="${viewEvent.id}"/>
												</div>
												
																	
												<sform:hidden path="id" />
												<sform:hidden path="owner_id" />
												<sform:hidden path="date_posted" />
												<sform:hidden path="code" />
												   
											   
											    <div class="col-auto">
											      	<input type="submit" class="btn btn-primary" value="Submit">
											    </div>
											</div>
															
												
										</sform:form>
																	
																	
									</div>


								</div>
								
								
								
								
								
							
								
								
								


								<div class="eventDetailCardChat">
									<div class="chat_header">Comments:</div>

									<div class="chat_body">


										<c:forEach items="${listOfComments}" var="eventComment">
										
											<c:if test="${eventComment.owner_id == userModel.id }">
										
												<div class="chat_myComment">
													<div class="chat_myComment_help"></div>
													<div class="chat_myComment_cnt">
										
														<div class="chat_myComment_box">
															<div class="chat_myComment_header">
																${eventComment.owner} </br> ${eventComment.date_posted}
															</div>
										
															<div class="chat_myComment_body">
																${eventComment.description}
															</div>
										
														</div>
										
													</div>
												</div>
										
											</c:if>	
											
											
											
											<c:if test="${eventComment.owner_id != userModel.id }">
										
												<div class="chat_otherComments">
		
													<div class="chat_otherComments_cnt">
		
														<div class="chat_otherComments_box">
															<div class="chat_otherComments_header">
																${eventComment.owner} </br> ${eventComment.date_posted}
															</div>
		
															<div class="chat_otherComments_body">
																${eventComment.description}
		
		
															</div>
		
														</div>
		
													</div>
													<div class="chat_otherComments_help"></div>
												</div>
										
											</c:if>	
											
											
											
											
										
										</c:forEach>



									</div>




									<div class="chat_footer">
			
					
										<sform:form id="addNewCommentForm" modelAttribute="newComment"
											action="${contextRoot}/addComment/"
											name="addNewCommentForm" method="post">
						
						
											<div class="form-group">			
													<label for="description" style="font-size: 14px;">
														Write your comment:
													</label> 
													<sform:textarea type="text" class="form-control" placeholder="Enter your comment..." 
														path="description" id="description" name="description" maxlength="2500"/>
											</div>
						
						
												<div class="form-group">
													<sform:input type="hidden" path="event_id"
														id="event_id" name="event_id" value="${viewEvent.id}"/>
												</div>
						
												<sform:hidden path="id" />
												<sform:hidden path="owner_id" />
												<sform:hidden path="date_posted" />
												
						
												<input type="submit" class="btn btn-primary"
														value="Submit">
												
										</sform:form>
																		
																	
									</div>


								</div>


							</div>

						</div>


					</c:if>



				</div>

			</div>


		</div>

	</div>











	<!-- Add new invitation -->
	<div class="modal fade" id="addNewInvitationModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title">Add new people to this event</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>


				<sform:form id="addNewInvitationForm" modelAttribute="newInvitation"
					action="${contextRoot}/addNewInvitation/"
					name="addNewInvitationForm" method="post">
	
					<!-- Modal body -->
					<div class="modal-body">


						<div style="font-size: 16px; margin-bottom: 10px;">
							Here you can choose who you want to invite:
						</div>

						
						<div class="form-group">
							<label style="font-size: 12px;">Select User</label>
							<sform:select class="form-control" id="user_id" name="user_id" path="user_id">
							    <c:forEach var="personNotInvited" items="${peopleNotInvited}">
							        <sform:option value="${personNotInvited.id}"><c:out value="${personNotInvited.name} ${personNotInvited.surname}"/></sform:option>
							    </c:forEach>
							</sform:select>
						</div>
						
					
				
				
						<div class="form-group">
							<sform:input type="hidden" path="event_id"
								id="event_id" name="event_id"/>
						</div>

						<sform:hidden path="id" />
						<sform:hidden path="seen" />
				
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







	<!-- Delete invitation -->
	<div class="modal fade" id="deleteInvitationModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title">Choose invitation to be cancelled</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>


				<sform:form id="deleteInvitationForm" modelAttribute="delInvitation"
					action="${contextRoot}/deleteInvitation/"
					name="deleteInvitationForm" method="post">
	
					<!-- Modal body -->
					<div class="modal-body">


						<div style="font-size: 16px; margin-bottom: 10px;">
							Here you can choose which invitation will be cancelled:
						</div>

						
						<div class="form-group">
							<label style="font-size: 12px;">Select User</label>
							<sform:select class="form-control" id="user_id" name="user_id" path="user_id">
							    <c:forEach var="personInvited" items="${peopleInvited}">
							        <sform:option value="${personInvited.id}"><c:out value="${personInvited.name} ${personInvited.surname}"/></sform:option>
							    </c:forEach>
							</sform:select>
						</div>
						
					
				
				
						<div class="form-group">
							<sform:input type="hidden" path="event_id"
								id="event_id" name="event_id"/>
						</div>

						<sform:hidden path="id" />
						<sform:hidden path="seen" />
				
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





	<!-- Delete event -->
	<div class="modal fade" id="deleteEventModal1">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title">Delete Event</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>


				<sform:form id="deleteEventForm1" modelAttribute="deleteEvent"
					action="${contextRoot}/viewEvent/deleteEvent"
					name="deleteEventForm1" method="post">
					<!-- Modal body -->
					<div class="modal-body">

						Are you sure that you want to delete this event ?
						<div id="deleteEventInfo1" style="font-size: 16px; margin-top: 10px;">
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
	<div class="modal fade" id="modifyEventModal1">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title">Edit your event</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>


				<sform:form id="modifyEventForm1" modelAttribute="modifyEvent"
					action="${contextRoot}/viewEvent/modifyEvent/"
					name="modifyEventForm1" method="post">
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






	<div class="modal fade" id="viewAttachementModal">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<div class="modal-title" style="font-size: 14px;" id="viewAttachmentTitle"></div>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body" id="viewAttachmentContent"></div>
			
			</div>
		</div>
	</div>




















</section>