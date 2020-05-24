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
		
				<div class="loginContainerMiddle">
	
					
					<form>
						
						Email address: 
						<input type="text" placeholder="email" name="email" id="email" >
						
						Password:
						<input type="password" placeholder="password" name="password" id="password" >
						
						<input type="submit" class="loginButton" value="Login">
						
					</form>
					
	
				</div>	

				<div class="loginContainerBottom">
	
					You are not registered ? <a href="#" title="Calendar">Create an account.</a> 
	
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

	$registerForm = $('#registerForm'); 
	if($registerForm.length) {
		$registerForm.validate({			
				rules: {
					name: {
						required: true,
						minlength: 3
					},
					surname: {
						required: true,
						minlength: 3
					},
					email: { 
						required: true,
						email: true,
						minlength: 5					
					},
					password: { 
						required: true,
						minlength: 5					
					},
					repeatPassword: { 
						equalTo: "#password"				
					}
				},
				messages: {					
					name: {
						required: 'This field can not be empty!',
						minlength: 'Name field must cantain at least 3 characters'
					},
					surname: {
						required: 'This field can not be empty!',
						minlength: 'Surname field must cantain at least 3 characters'
					},
					email: {
						required: 'This field can not be empty!',
						minlength: 'Enter a valid email address!',
						email: 'Enter a valid email address!'
					},	
					password: {
						required: 'This field can not be empty!',
						minlength: 'Password field must cantain at least 5 characters'
					},
					repeatPassword: {
						equalTo: 'Fields: Password and Repeat Password are not equal!'
				
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
