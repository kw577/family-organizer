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
	
		<div class="registerContainer">
	
				<div class="registerContainerTop">
	
					<div><img src="${images}/logo_mini.png" alt="Logo"></div>
					<div>Create your account</div>
	
				</div>
		
				<div class="registerContainerMiddle">
	
					
					<sform:form id="registerForm" modelAttribute="newUser" action="${contextRoot}/register" name="registerForm" method="post">
					
						Name: 
						<sform:input type="text" placeholder="Name" path="name" id="name"/>
						
						Surname: 
						<sform:input type="text" placeholder="Surname" path="surname" id="surname"/>
						
						Email address: 
						<sform:input type="email" placeholder="e-mail" path="email" id="email"/>
						
						Password:
						<sform:input type="password" placeholder="Password" path="password" id="password"/>
						
						Repeat Password:
						<input type="password" placeholder="Repeat Password" name="repeatPassword" id="repeatPassword">
						
						<input type="submit" class="registerButton" value="Create account">
						
						<sform:hidden path="id"/>
						<sform:hidden path="role"/>
						<sform:hidden path="enabled"/>
						<sform:hidden path="family_id"/>
						
					</sform:form>
					
	
				</div>	

				<div class="registerContainerBottom">
	
					Already have an account ? <a href="#" title="Calendar">Login here.</a> 
	
				</div>	
		
		
		
		
		</div>
		
	</div>
	
	
	<!-- Bootstrap -->
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="${js}/bootstrap.min.js"></script>

	
	<script>

		//Test 1
			
		
		
		
	</script>
	
	
</body>
</html>
