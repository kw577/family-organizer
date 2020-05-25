<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>

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
	<title>Online Planner</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	
	<!-- Bootstrap -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
	<!-- Google font -->	
	<link href="https://fonts.googleapis.com/css?family=PT+Sans&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=BenchNine:wght@300&display=swap" rel="stylesheet">
	    
    <!-- Bootstrap -->
	<link href="${css}/bootstrap.min.css" rel="stylesheet">
			
	<!-- CSS -->
    <link href="${css}/style.css" rel="stylesheet" type="text/css">
    
				
</head>

<body>
	<div class="wrapper">
	
		<div class="loginContainer">
	
				<div class="loginContainerTop">
	
					<div><img src="${images}/logo_mini.png" alt="Logo"></div>
					<div>Sign in to Family Organizer</div>
	
				</div>
				
				
				<c:if test="${not empty message}">
					<div class="loginErrorMessage">
						<div class="alert alert-danger text-center">${message}</div>
					</div>
				</c:if>
		
				<div class="loginContainerMiddle">
	
					
					<form action="${contextRoot}/login" method="POST" id="loginForm">
						
						Email address: 
						<input type="text" placeholder="email" name="username" id="username" >
						
						Password:
						<input type="password" placeholder="Password" name="password" id="password" >
						
						<input type="submit" class="loginButton" value="Login">
						
					</form>
					
	
				</div>	

				<div class="loginContainerBottom">
	
					You are not registered ? <a href="${contextRoot}/register">Create an account.</a> 
	
				</div>	
		
		
		</div>
		
	</div>
	
	
	<!-- Bootstrap -->
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="${js}/bootstrap.min.js"></script>


		<!-- jQuery validator -->
	<script src="${js}/jquery.validate.js"></script>
	
	<script>

	$loginForm = $('#loginForm'); 
	if($loginForm.length) {
		$loginForm.validate({			
				rules: {
					username: {
						required: true,
						email: true
					},
					password: { 
						required: true				
					}
				},
				messages: {					
					username: {
						required: 'Please enter your email!',
						email: 'Enter a valid email address!'
					},	
					password: {
						required: 'Please enter your password!'
					}
					
				},
				errorElement : "em",
				errorPlacement : function(error, element) {
					error.addClass('formAlerts');
					
					error.insertBefore(element);
					
					
				}				
			}
		);
	}
			
		
		
	</script>

	
</body>
</html>
