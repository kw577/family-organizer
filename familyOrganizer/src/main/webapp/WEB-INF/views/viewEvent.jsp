
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

									<button type="button" class="btn btn-warning"
										title="Edit event">
										<i class="fas fa-pen"></i>
									</button>


									<button type="button" class="btn btn-danger"
										title="Delete event">
										<i class="fas fa-trash-alt"></i>

									</button>

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
											title="Participants"></i></span>&#09;Jan Nowak, Adam Nowak, Beata
										Nowak
									</div>

									<div class="eventDetailCardParticipantsItem2">


										<button type="button" class="btn btn-warning"
											title="Edit participant list">
											<i class="fas fa-user-plus"></i>
										</button>

									</div>

								</div>

								<div class="eventDetailCardDescription">
									<span style="font-weight: bold;">Description:</span></br> 
									${viewEvent.description}
								</div>


								<div class="eventDetailCardChat">
									<div class="chat_header">Comments:</div>

									<div class="chat_body">


										<div class="chat_myComment">
											<div class="chat_myComment_help"></div>
											<div class="chat_myComment_cnt">

												<div class="chat_myComment_box">
													<div class="chat_myComment_header">
														Jan Nowak </br> 22.08.2020 godz. 10:45
													</div>

													<div class="chat_myComment_body">
														Test test txcvzxv xvxz xvxcv x cv xzcvxcz test 1 </br>
														sdfsfadsfdsfas dsfsdfsadfasdf sdfasdfdsf sdf sdfsadfsd
														fsdfas

													</div>

												</div>

											</div>
										</div>



										<div class="chat_myComment">
											<div class="chat_myComment_help"></div>
											<div class="chat_myComment_cnt">

												<div class="chat_myComment_box">
													<div class="chat_myComment_header">
														Jan Nowak </br> 23.08.2020 godz. 11:45
													</div>

													<div class="chat_myComment_body">
														dasfdfasadsfdfafddf </br> fasfdsfsdfdsf sdfsdafds sdfda fads
														fdfd dfsdaf adsf fddfasdfdsf saddsadsdSDs sdfasfdsf
														dfasfdfghgfhfhhfd fasfdsfsdfdsf sdfsdafds sdfda fads fdfd
														dfsdaf adsf fddfasdfdsf saddsadsdSDs sdfasfdsf
														dfasfdfghgfhfhhfd fasfdsfsdfdsf sdfsdafds sdfda fads fdfd
														dfsdaf adsf fddfasdfdsf saddsadsdSDs sdfasfdsf
														dfasfdfghgfhfhhfd fasfdsfsdfdsf sdfsdafds sdfda fads fdfd
														dfsdaf adsf fddfasdfdsf saddsadsdSDs sdfasfdsf
														dfasfdfghgfhfhhfd

													</div>

												</div>

											</div>
										</div>











										<div class="chat_otherComments">

											<div class="chat_otherComments_cnt">

												<div class="chat_otherComments_box">
													<div class="chat_otherComments_header">
														Adam Nowak </br> 23.08.2020 godz. 11:45
													</div>

													<div class="chat_otherComments_body">
														dasfdfasadsfdfafddf fdfadsfsf</br> fasfdsfsdfdsf sdfsdafds
														sdfda fads fdfd dfsdaf adsf fddfasdfdsf saddsadsdSDs
														sdfasfdsf dfasfdfghgfhfhhfd


													</div>

												</div>

											</div>
											<div class="chat_otherComments_help"></div>
										</div>



										<div class="chat_otherComments">

											<div class="chat_otherComments_cnt">

												<div class="chat_otherComments_box">
													<div class="chat_otherComments_header">
														Adam Nowak </br> 23.08.2020 godz. 11:45
													</div>

													<div class="chat_otherComments_body">
														dasfdfasadsfdfafddf fdfadsfsf</br> fasfdsfsdfdsf sdfsdafds
														sdfda fads fdfd dfsdaf adsf fddfasdfdsf saddsadsdSDs
														sdfasfdsf dfasfdfghgfhfhhfd dfgfdgsdfg ffhfggh dfgs
														fasfdsfsdfdsf sdfsdafds sdfda fads fdfd dfsdaf adsf
														fddfasdfdsf saddsadsdSDs sdfasfdsf dfasfdfghgfhfhhfd
														dfgfdgsdfg ffhfggh dfgs fasfdsfsdfdsf sdfsdafds sdfda fads
														fdfd dfsdaf adsf fddfasdfdsf saddsadsdSDs sdfasfdsf
														dfasfdfghgfhfhhfd dfgfdgsdfg ffhfggh dfgs


													</div>

												</div>

											</div>
											<div class="chat_otherComments_help"></div>
										</div>


















									</div>




									<div class="chat_footer">
										<form>
											<div class="form-group">
												<label for="exampleFormControlTextarea1">Write your
													comment:</label>
												<textarea class="form-control"
													id="exampleFormControlTextarea1" maxlength="2500"
													placeholder="Enter your comment..."></textarea>
											</div>
											<button type="submit" class="btn btn-primary">Submit</button>
										</form>
									</div>







								</div>


							</div>

						</div>





					</c:if>



				</div>

			</div>


		</div>

	</div>



</section>