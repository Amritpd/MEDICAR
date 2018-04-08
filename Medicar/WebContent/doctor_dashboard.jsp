<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	<%@ page import="com.mie.model.User" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" type="text/css" href="style/theme.css">

<title>Doctor Dashboard</title>
</head>

<body>

	<% if (session.getAttribute("currentUser") == null){ %>
		<% 
		RequestDispatcher view = request.getRequestDispatcher("logout.jsp");
		view.forward(request, response);
		%>
			response.sendRedirect("logout.jsp");
	<% } else { %>
	`	|	<%@ include file="doctor_navbar.jsp"%>
	
			<p> Some data summary here? </p>
				
	<% } %>
	
</body>
</html>