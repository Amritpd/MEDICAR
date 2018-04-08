<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
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
<script src="js/Chart.bundle.min.js"></script>

<title>MEDICAR Diagnosis Manager</title>
</head>
<body>
	<%  %>

	<% if (session.getAttribute("currentUser") == null){ %>
		<% 
		RequestDispatcher view = request.getRequestDispatcher("logout.jsp");
		view.forward(request, response);
		%>
			response.sendRedirect("logout.jsp");
	<% } else { %>
	<div class="jumbotron text-center">
			<h1>Diagnoses</h1>
		</div>
			<%@ include file="patient_navbar.jsp"%>
			

	<% 
	User user = (User) session.getAttribute("currentUser"); 
	if (user.getRole().equalsIgnoreCase("Doctor")){ 
	%>
    	<div class="createDiagnosis" style="margin-left:70%;">
	    	<form name="form" method="POST" action="PatientController" >
	    	        <input type="hidden" name="showForm">
			        <input type="button" value="Create Diagnosis" onclick="button()">
			       
	    	</form>
    	</div>
			<% } %>

    <%  if(request.getAttribute("showForm") != null) { %>
          	
             <h3>New Diagnosis</h3>
			<form method="POST" action='PatientController' name="newDiagnosis">
				<table>
					<tr>
						<td>Diagnosis Name:</td>
						<td><input type="text" placeholder="A diagnosis" name="diagnosisName"/></td>	
						<td></td>
					</tr>
					
					<tr>
						<td>Symptoms:</td>
						<td><input type="text" placeholder="Symptom 1, Symptom 2" name="symptoms"/></td>	
						<td></td>
					</tr>
				
					<tr>
						<td>Prognosis:</td>
						<td><input type="text" placeholder="Some medicine" name="prognosis"/></td>	
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" name="submit" value="Submit" />
							<input type="submit" name="cancel" value="Cancel" ></td>	
							
						<td></td>
					</tr>
				</table>
				
				<p>${message}</p>
				<c:remove var="message" scope="session" /> 
	
			</form>
			

               
       <% } %>

    <script language="JavaScript">
   
        function button(){
         	document.form.showForm.value ="show"; // give the showForm variable a value
         	form.submit(); // submit the form. Then go to patient controller/doPost
        } 
        
    </script>
	
<div class="Test3">		
	<div class="container-noborder">
		
		<table border=1 width=900>
			<thead>
				<tr>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Diagnosis ID</th>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Doctor Name</th>
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
						<td align="center"><a
							href="DoctorController?action=show&dId=<c:out value="${dia.getDiagnosisId()}"/>">See More</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>		
	<% } %>


</body>
</html>