
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
										<button type="button" class="btn btn-warning"
											title="Edit event">
											<i class="fas fa-pen"></i>
										</button>
	
	
										<button type="button" class="btn btn-danger"
											title="Delete event">
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
















</section>