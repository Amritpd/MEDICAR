<%@ page import="com.mie.model.User" %>

<div class="NavContainer">
<nav>
	
	<ul id="nav">
		<li style="background-color:#345678"><a  href="/SimpleDBExample/DoctorController?action=listDiagnoses"><i class="fa fa-tachometer" style="font-size:24px"></i> Dashboard</a></li> <!--  Should go back to doctor's dashboard -->
		<li id="PatientsList"><a href="/SimpleDBExample/DoctorController?action=listPatients"><i class="fa fa-user" style="font-size:24px"></i> Patients</a></li>  <!-- Search for a diagnosis -->
		<!-- Search for a patient -->
		<li id="LogOut"><a  href="logout.jsp"><i class=" fa-sign-out" style="font-size:24px"></i>Logout</a></li>
		
	</ul>
</nav>
</div>