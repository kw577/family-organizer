
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

									<button type="button" class="btn btn-warning">
										<i class="fas fa-pen"></i>
									</button>


									<button type="button" class="btn btn-danger">
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



</section>





