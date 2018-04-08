<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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

<!-- Ideally we can use only this jsp to use  -->
<body>

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
			
			
		<c:choose>
		    <c:when test="${ currentPatient != null || currentUser.role.equalsIgnoreCase('Patient')}">
		       	<% // Show patient's navbar if the patient is logged in, or doctor clicked on patient's diagnosis %>
		       
		       	<%@ include file="patient_navbar.jsp"%>
		    </c:when>    
		    <c:otherwise>
		    	<% // showed when doctor navigates to specific diagnosis %>
		        <%@ include file="doctor_navbar.jsp"%> 
		    </c:otherwise>
		</c:choose>
	<div style=" width:900px; margin-left:20%; margin-top:6.5%;position:absolute;">
			<div class="page-header">
  				<h1><c:out value="${diagnosis.firstName}" />'s Diagnosis: <c:out value="${diagnosis.diagnosisName}"/></h1>
			</div>
			
			<h2>Symptoms: <small><c:out value="${diagnosis.symptoms}"/></small></h2>
			<h2>Prognosis:<small> <c:out value="${diagnosis.prognosis}"/></small></h2>
			
		
	</div>
	<div id="CommentsContainer" style="margin-left:20%; margin-top: 22.5%">	
	<div class="container-noborder">
			<h3> Comments </h3>
			<table border=1 width=900>
			<thead>
				<tr>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Doctor</th>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Message (Timestamp)</th>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;">Patient</th>
					<th style="color: white; background-color:#C0C0C0; text-align: center; font-size: 24px; heigt:24px;" colspan=2>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${comments}" var="msg">
				<!-- "From" value indicates owner of message -->
				<!-- Add some sick CSS for messages -->
					<tr>
						<td align="center">
							<c:choose>
								<c:when test="${msg.getFrom()!= msg.getPatientId()}">
										Dr. <c:out value="${msg.getName()}" />
									<!-- If the "From" ID is not the patient, then we know the Doctor sent this message -->
								</c:when>
							</c:choose>
						</td>
						<td align="center"><c:out value="${msg.getMessage()}" /> 
						(<fmt:formatDate pattern="yyyy-MM-dd" value="${msg.getTimeStamp()}"  />)</td>
						<td align="center">
							<c:choose>
								<c:when test="${msg.getFrom() == msg.getPatientId()}">
										<c:out value="${msg.getName()}" />
									<!-- If the "From" ID is the patient, then we know the Patient sent this message -->
								</c:when>
							</c:choose>
						</td>
						<c:set var="current" value="${currentUser.userid}"/>
						<c:if test="${msg.from == current}" >
							<td align="center" colspan=2>
							<form method="POST" action="DoctorController" name="EditComment">
								 	<input type="hidden" name="cId" value="${msg.commentId}"/>
								 	<input type="hidden" name="dId" value="${diagnosis.diagnosisId}" />
									<input name="delete" type="submit" value="Delete"/>
							</form>
							</td>
						</c:if>									
					</tr>
				</c:forEach>
			</tbody>
		</table>
			<form method="POST" action='DoctorController' name="InsertComment">
				<input type="hidden" name="dId" value="${diagnosis.diagnosisId}" />
				<input type="text" placeholder="Hi there." name="comment"/><input type="submit" value="Add Comment" onclick="button()"/>
			</form>
				<p>${message}</p>
				<c:remove var="message" scope="session" /> 
	</div>
	</div>		
	<% } %>
</body>

    <script language="JavaScript">
   
        function button(){
         	document.form.showForm.value ="show"; // give the showForm variable a value
         	form.submit(); // submit the form. Then go to patient controller/doPost
        } 
        
    </script>
    
</html>