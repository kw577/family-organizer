<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<%
    response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
%>

<c:set var="contextRoot" value="${pageContext.request.contextPath}"/>


<spring:url var="images" value="/resources/images"/>
<spring:url var="css" value="/resources/css"/>
<spring:url var="js" value="/resources/js"/>
<spring:url var="fontello" value="/resources/fontello"/>


<!DOCTYPE HTML>
<html lang="pl">
<head>
	<meta charset="utf-8" />
	<title>Online Family Organizer</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	
	<!-- Bootstrap -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
		
	<!-- Google font -->	
	<link href="https://fonts.googleapis.com/css?family=PT+Sans&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=BenchNine:wght@300&display=swap" rel="stylesheet">
	
	<!-- Bootstrap -->
	<link href="${css}/bootstrap.min.css" rel="stylesheet">
			
	<!-- CSS -->
    <link href="${css}/style.css" rel="stylesheet" type="text/css">
		
	<!-- Script to genarate calendar view -->
	<script src="${js}/calendar.js"></script>	
		
	<!-- Fontello -->
	<link rel="stylesheet" href="${fontello}/fontello1/css/fontello.css" type="text/css"/>
	<link rel="stylesheet" href="${fontello}/fontello2/css/fontello.css" type="text/css"/>
	
	<!-- Font awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
	
	
</head>

<body onload="start();">
	<div class="wrapper">
	
		 <!-- Sidebar -->
		<nav id="sidebar">
			<div class="sidebarHeader">
				<!-- Logo for wide screen -->
				<a href="${contextRoot}/home" class="d-none d-md-block"><img src="${images}/logo_white.png" alt="Logo" title="Main page"></a>
					
				<!-- Logo for narrow view -->
				<a href="${contextRoot}/home" class="d-block d-md-none"><img src="${images}/logo_mini.png" alt="Logo" title="Main page"></a>
	
			</div>
			
			<security:authorize access="isAuthenticated()">
				<div id="sidebarUser">
					<a href="#" title="User panel"> <i class="icon-user"></i><span class="d-none d-md-inline-block ml-1">  ${userModel.name} ${userModel.surname} </span></a>
				</div>
			</security:authorize>	
			
			<div id="sidebarClock" class="d-none d-md-block">
				<a href="#" title="User panel">Loading..</a>
			</div>


			<ul class="list-unstyled components">
			
			
				<li>
					<a href="#" title="Calendar"><i class="icon-calendar-empty"></i><span class="d-none d-md-inline-block ml-1">  Calendar </span></a>					
				</li>
				
				<li>
					<a href="#" title="Today"><i class="icon-calendar-check-o"></i><span class="d-none d-md-inline-block ml-1">  Today </span></a>	
				</li>
				
				<li>
					<a href="#" title="Tasks"><i class="icon-check"></i><span class="d-none d-md-inline-block ml-1">  Tasks </span></a>
				</li>
			
				<li class="active">
					<a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle abcde"><i class="icon-list-bullet"></i><span class="d-none d-md-inline-block ml-1">  My plans </span></a>
					<ul class="collapse list-unstyled" id="homeSubmenu">
						<li>
							<a href="#" title="Add event"><i class="icon-calendar-plus-o"></i><span class="d-none d-md-inline-block ml-1">  Add event </span></a>
						</li>
						<li>
							<a href="#" title="Timeline"><i class="icon-clock"></i><span class="d-none d-md-inline-block ml-1">  Timeline </span></a>
						</li>
						<li>
							<a href="#" title="Manage events"><i class="icon-briefcase"></i><span class="d-none d-md-inline-block ml-1">  Manage events </span></a>
						</li>
					</ul>
				</li>			
				
				<li>
					<a href="#" title="Contacts"><i class="icon-address-card-o"></i><span class="d-none d-md-inline-block ml-1">  Contacts </span></a>
				</li>
				
				<li>
					<a href="${contextRoot}/notes" title="User Notes page"><i class="icon-edit"></i><span class="d-none d-md-inline-block ml-1">  Notes </span></a>
				</li>

				<li>
					<a href="#" title="Conversations"><i class="icon-chat"></i><span class="d-none d-md-inline-block ml-1">  Conversations </span></a>
				</li>
				<li>
					<a href="#" title="Files manager"><i class="icon-doc-inv"></i><span class="d-none d-md-inline-block ml-1">  Files manager </span></a>
				</li>
			</ul>
		</nav>	
	
		<div class="page">
			<header>
				<nav class="navbar navbarMyColor navbar-expand-md navbar-dark" id="navbarTop">
				
					<!-- Button to show/hide sidebar  -->
					<button type="button" id="sidebarCollapse" class="btn btn-default sidebarToggler">
						<i class="icon-left-open"></i>
					</button>	
				
				
					<!-- Button for mobile view  -->
					<button class="navbar-toggler" type="button" data-target="#navbarMenu" data-toggle="collapse" aria-label="Navbar toggle" aria-controls="navbarMenu" aria-expanded="false">
						<span class="navbar-toggler-icon"></span>
					</button>
				
					<div id="navbarMenu" class="collapse navbar-collapse">
											
						<ul class="navbar-nav  ml-auto w-100 justify-content-end">
						
							<!-- This is available only for Admin of Family  -->
							<security:authorize access="hasAuthority('ADMIN')">
								<li class="nav-item active">
									<a class="nav-link" href="${contextRoot}/manage/familyAccount"> Admin panel <i class="icon-users"></i></a>
								</li>
							</security:authorize>
						
							<li class="nav-item active">
								<a class="nav-link" href="#"> Notifications <i class="icon-bell-alt"></i></a>
							</li>
							
							
							<!-- Dropdown menu (add class dropdown-toggle to id "submenu" to add arrow)  -->
							<li class="nav-item dropdown">
								<a class="nav-link active" href="#" id="submenu" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> My profile <i class="icon-user-circle"></i></a>
								
									<div class="dropdown-menu" aria-labelledby="submenu">
									
										<a class="dropdown-item" href="#"><i class="icon-cog"></i> My account </a>
										<a class="dropdown-item" href="#"><i class="icon-wrench"></i> Settings </a>								
										<a class="dropdown-item" href="${contextRoot}/logout"><i class="icon-logout"></i> Logout </a>
									
									</div>					
								
							</li>
									
						</ul>					
					</div>
								
				</nav>
				
				
				
				<!-- Home page - calendar view -->	
				<c:if test="${isMainPage == true }"> 
					<%@include file="calendarControls.jsp"%>
				</c:if>	
				
								
			</header>


				
			<main>
			
			
			
				<!-- Home page - calendar view -->	
				<c:if test="${isMainPage == true }"> 
					<%@include file="homePage.jsp"%>
				</c:if>	
			
			
			
				<!-- User Notes page - calendar view -->	
				<c:if test="${isNotesPage == true }"> 
					<%@include file="userNotesPage.jsp"%>
				</c:if>	
			
			
				<!-- User Notes page - calendar view -->	
				<c:if test="${familyAdminPage == true }"> 
					<%@include file="familyAdminPanel.jsp"%>
				</c:if>	
			
			

			
			</main>
			
		</div>	
		
	</div>
	
	
	<div id="footer">
		Praca Dyplomowa - Politechnika Krakowska &copy; 
	</div>
	
	
	<!-- Bootstrap -->
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="${js}/bootstrap.min.js"></script>

	<!-- Bootbox -->
	<script src="${js}/bootbox.min.js"></script>

	<!-- jQuery validator -->
	<script src="${js}/jquery.validate.js"></script>
	

	<!-- Other scripts -->
	<script src="${js}/scripts.js"></script>


	<!-- Link scripts below in separate file -->
	<script>
		window.userRole = '${userModel.role}';
	</script>
	
	
	<script>

		
		function start() {
			checkTime();
			
			if(document.body.contains(document.getElementById('calendarViewWrapper'))){
				loadCalendar();
			}
		}
		
		
		
		//hide sidebar with button
		$(document).ready(function () {

			$('#sidebarCollapse').on('click', function () {
				//$('#sidebar').toggleClass('active');
				$('#sidebarCollapse').toggleClass('btn-warning');
				$('#sidebarCollapse').toggleClass('mirrorView');
				
				if ($(window).width() < 752) {
					$('#sidebar').toggleClass('activeMini');
				} else {
					$('#sidebar').toggleClass('active');
				}
				
				
				$('.page').toggleClass('pageWithoutSidebar');
				
				
				if($('.page').hasClass('pageWithoutSidebar')) {
				
					if($('.page').hasClass('pageWithSidebar')) $('.page').removeClass('pageWithSidebar');
					if($('.page').hasClass('pageWithSidebarMini')) $('.page').removeClass('pageWithSidebarMini');
				
				
				} else {
				
					if ($(window).width() < 752) {
						$('.page').addClass('pageWithSidebarMini');
						
						
					} else {
						$('.page').addClass('pageWithSidebar');
					
					}
					
				}
				
				
				
			});

		});
		
		//narrow down sidebar when resizing screen
		$(document).ready(function() {
			
			$(window).resize(function() {
				
				if($('.page').hasClass('pageWithSidebar')) $('.page').removeClass('pageWithSidebar');
				if($('.page').hasClass('pageWithSidebarMini')) $('.page').removeClass('pageWithSidebarMini');
				
				
				if ($(window).width() < 752) {
					if ($('#sidebar').hasClass('active')) {
						$('#sidebar').removeClass('active');
						$('#sidebar').addClass('activeMini');
					}
				} else if ($(window).width() >= 752){
				
						if ($('#sidebar').hasClass('activeMini')) {
						$('#sidebar').removeClass('activeMini');
						$('#sidebar').addClass('active');
					}
				}	
				
				
				
				if(! ($('.page').hasClass('pageWithoutSidebar'))) {
					
					
					if ($(window).width() < 752) {
					
					$('.page').addClass('pageWithSidebarMini');
					} else {
					
					$('.page').addClass('pageWithSidebar');	
					
									
					}
							
				
				}
				
				
				
			
			});
		});
		
		
		// narrow sidebar for mobile view https://stackoverflow.com/questions/33089119/bootstrap-use-of-different-classes-depending-on-the-screen-size
		// change sidebar for mobile view
	
		
		function checkWidth(init) {

			if ($(window).width() < 752) {
				$('#sidebar').addClass('sidebarMini');
				if(!$('.page').hasClass('pageWithoutSidebar')) $('.page').addClass('pageWithSidebarMini');
			} else {
				if(!$('.page').hasClass('pageWithoutSidebar')) $('.page').addClass('pageWithSidebar');
				
					if (!init) {
					$('#sidebar').removeClass('sidebarMini');
				}
			}
		}

		$(document).ready(function() {
			checkWidth(true);

			$(window).resize(function() {
				checkWidth(false);
			});
		});
				
		
		
		function checkTime()
		{
		
			month_list = [ "Jan.", "Feb.", "Mar.", "Apr.", "May", "Jun.", "Jul.", "Aug.", "Sept.", "Oct.", "Nov.", "Dec." ];
			day_list = ["Sun.", "Mon.", "Tues.", "Wed.", "Thur.", "Fri.", "Sat."];
  
			var today = new Date();
			
			var day = today.getDate();
			var month = month_list[today.getMonth()];
			var year = today.getFullYear();
			
			var dayName = day_list[today.getDay()];
			
			
			var hour = today.getHours();
			var minutes = today.getMinutes();
			//var seconds = today.getSeconds();
			
			
			if (hour<10) hour = "0" + hour;		
			if (minutes < 10) minutes = "0" + minutes;		
			//if (seconds < 10) seconds = "0" + seconds;
			
			document.getElementById("sidebarClock").innerHTML = dayName + " " + month + " " + day + "     "+hour+":"+minutes;
			 
			setTimeout("checkTime()",1000);
		}
			

		$(document).ready(function() {
		var NavY = $('#navbarTop').offset().top;
		 
		var stickyNav = function(){
		var ScrollY = $(window).scrollTop();
			  
		if (ScrollY > NavY) { 
			$('#navbarTop').addClass('sticky');
		} else {
			$('#navbarTop').removeClass('sticky'); 
		}
		};
		 
		
		stickyNav();
		 
		$(window).scroll(function() {
			stickyNav();
		});
		});
		
			
		
	</script>
	
		
	
</body>
</html>
