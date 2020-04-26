<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- c:   - oznacza ze korzystamy z funkcjonalnosci z biblioteki jstl -->
<c:set var="contextRoot" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Online Family Organizer</title>
</head>
<body>
	${contextRoot} info -- ${greeting}
	<br></br>
	<font size=7>${title}</font>
</body>
</html>