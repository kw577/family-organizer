
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
				

				<div class="eventDetailViewHeader">
					<div class="eventDetailViewHeaderItem1">Search results:</div>
					<div class="eventDetailViewHeaderItem2">
						<button type="button" class="btn btn-info" title="Go back" onclick="window.history.back();">
							<i class="fas fa-arrow-left fa-lg"></i>&#32; BACK
						</button>
					</div>
				</div>





				</div>
				
					
				<div class="eventsPanelBody">
				
					


					<c:forEach items="${listOfUserEvents}" var="userEvent">
						<div class="singleEventView">
							<div class="eventViewHeader">

								<div class="eventViewHeaderItem1">${userEvent.title}</div>
								<div class="eventViewHeaderItem2">


									<a href="${contextRoot}/viewEvent/${userEvent.id}/detailView" title="View details">
										<button type="button" class="btn btn-info">
												<i class="fas fa-info-circle"></i>	
										</button>
									</a>
							
		
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




</section>





