<%@ page import="com.mie.model.User" %>
<div class="NavContainer">

	

	
	<ul id="nav">
		<li id="PatientDashboardLink"><a href="patient_dashboard.jsp"><i class="fa fa-tachometer" style="font-size:24px"></i> Dashboard</a></li> <!--  Should go back to patient's dashboard -->
		<li id="FileLink"><a href="/SimpleDBExample/PatientController?action=listPatientFiles"><i class="fa fa-file-o" style="font-size:24px"></i> Files</a></li>  <!-- Search for a diagnosis -->
		<li id="DiagnosesLink"><a href="/SimpleDBExample/PatientController?action=listPatientDiagnoses" /><i class="fa fa-stethoscope" style="font-size:24px"></i> Diagnoses</a></li> 
		<!-- Search for a patient -->
		<li id="LogOut"><a href="logout.jsp"><i class=" fa-sign-out" style="font-size:24px"></i>Logout</a></li> 
	</ul>

</div>