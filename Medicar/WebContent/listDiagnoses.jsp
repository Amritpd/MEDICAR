<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">


<title>MEDICAR Diagnosis Manager</title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	  <link rel="stylesheet" href="style/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <style>
  .jumbotron {
      background-color: #345678;
      color: #fff;
  }
  .jumboTronContainer{ margin-top:0%; height:12%; padding:0;  }
  
  </style>
 
  <link rel="stylesheet" href="style/PatientDashboardStyles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/Chart.bundle.min.js"></script><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

	<% if (session.getAttribute("currentUser") == null){ %>
		<% 
		RequestDispatcher view = request.getRequestDispatcher("logout.jsp");
		view.forward(request, response);
		%>
			response.sendRedirect("logout.jsp");
	<% } else { %>
<div class="jumboTronContainer">			
	<div class="jumbotron text-center">
	 <h1>Dr. <%
				User Jumbotronuser = (User) session.getAttribute("currentUser");
			    out.print(Jumbotronuser.getFirstName() + " " + Jumbotronuser.getLastName());
				%>'s Dashboard</h1>
	  <p>View the most up to date conversations with patients!</p> 
	</div>
</div>
	`		<%@ include file="doctor_navbar.jsp"%>
	<center>
		<h1>Your Diagnoses</h1>
	</center>
	<div class="Test2">
	<div class="container-noborder">
		
		<table border=1 width="900">
			<thead>
				<tr>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Diagnosis ID</th>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Patient Name</th>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Diagnosis</th>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Created On</th>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Last Updated</th>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Action</th> 
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${diagnoses}" var="dia">
					<tr>
						<td align="center"><c:out value="${dia.getDiagnosisId()}" /></td>
						<td align="center"><c:out value="${dia.getFirstName()}" /> <c:out value="${dia.getLastName()}" /></td>
						<td align="center"><c:out value="${dia.getDiagnosisName()}" /></td>
						<td align="center"><c:out value="${dia.getCreatedOn()}" /></td>
						<td align="center"><c:out value="${dia.getLastUpdated()}" /></td>
						<td align="center"><a href="DoctorController?action=show&dId=<c:out value="${dia.getDiagnosisId()}"/>">See More</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
			
	<% } %>


</body>
</html>