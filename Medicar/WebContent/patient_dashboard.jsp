<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">


<title>Patient Dashboard</title>
  <link rel="stylesheet" href="style/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <style>
  .jumbotron {
      background-color: #345678;
      color: #fff;
  }
  .jumboTronContainer{ margin-top:0%; height:12%; padding:0;  }
  .bg-grey {
      background-color: #f6f6f6;
  }
  .container-fluid {
      padding: 60px 50px;
  }
  </style>
 
  <link rel="stylesheet" href="style/PatientDashboardStyles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/Chart.bundle.min.js"></script>

</head>

<body>

	<% if (session.getAttribute("currentUser") == null) {%>
	<%
		RequestDispatcher view = request
					.getRequestDispatcher("logout.jsp");
			view.forward(request, response);
			response.sendRedirect("logout.jsp");
	%>
	
		<%} else { %>
<div class="jumbotron text-center">
 
  		 <%
			User Jumbotronuser = (User) session.getAttribute("currentUser");
  			User patient = (User) session.getAttribute("currentPatient");
  			if (patient != null){ %>
  			<h1><% out.print(patient.getFirstName() + " " + patient.getLastName()); %></h1>	
  			<a style="color: white; font-size: 15px;" href="/SimpleDBExample/DoctorController?action=listPatients"><i class="fa fa-arrow-left" style="font-size:24px"></i>Go Back To Patients </a>	
  		<%	} else { %> 
  				<h1> <%out.print(Jumbotronuser.getFirstName() + " " + Jumbotronuser.getLastName()); %> </h1>
  				<p>Manage your biometrics, or get in touch with your Doctor!</p> <%
  			}
			%> 
				
			
</div>
	`		<%@ include file="patient_navbar.jsp"%>
	

	<%} %>
	

	
	<div class="container">
		<br/>
	  <div class="PatientBiometricsOverflow">
		<div class="row row-bottom-padded">
			<div class="col-md-8 col-md-offset-2">
				<canvas id="BpSystChart" width="800" height="400"></canvas>
			</div>
		</div>
		<div class="row row-bottom-padded">
			<div class="col-md-8 col-md-offset-2">
				<canvas id="BpDiastChart" width="800" height="400"></canvas>
			</div>
		</div>
		<div class="row row-bottom-padded">
			<div class="col-md-8 col-md-offset-2">
				<canvas id="rhrChart" width="800" height="400"></canvas>
			</div>
		</div>
		<div class="row row-bottom-padded">
			<div class="col-md-8 col-md-offset-2">
				<canvas id="cholChart" width="800" height="400"></canvas>
			</div>
		</div>
	</div>
   </div>
<table hidden>
			<thead>
				<tr>
					<th>Systolic Blood Pressure</th>
					<th>Diastolic Blood Pressure</th>
					<th>Resting Heart Rate</th>
					<th>Cholesterol</th>
					<th>Time Stamp</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${biometrics}" var="bio">
					<tr class = "dataRow">
						<td class = "BpSystRow"><c:out value="${bio.getBpSyst()}" /></td>
						<td class = "BpDiastRow"><c:out value="${bio.getBpDiast()}" /></td>
						<td class = "rhrRow"><c:out value="${bio.getRHR()}" /></td>
						<td class = "cholRow"><c:out value="${bio.getChol()}" /></td>
						<td class = "timeStampRow"><c:out value="${bio.getTimeStamp()}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		

</body>
</html>

<script>

var BpSystData = [];
var BpDiastData = [];
var rhrData = [];
var cholData = [];

var BpSystChart = document.getElementById("BpSystChart");
var BpDiastChart = document.getElementById("BpDiastChart");
var rhrChart = document.getElementById("rhrChart");
var cholChart = document.getElementById("cholChart");

$("tr.dataRow").each(function() {
        
	var timeStamp = $(this).find("td.timeStampRow").html();
	
	BpSystData.push({
	    x: timeStamp,
	    y: $(this).find("td.BpSystRow").html()
	});  
        
    BpDiastData.push({
   	    x: timeStamp,
   	    y: $(this).find("td.BpDiastRow").html()
   	});    
    
    rhrData.push({
   	    x: timeStamp,
   	    y: $(this).find("td.rhrRow").html()
   	});   
    
    cholData.push({
   	    x: timeStamp,
   	    y: $(this).find("td.cholRow").html()
   	});  
    
});

BpSystData = BpSystData.slice(0, 31);
BpDiastData = BpDiastData.slice(0, 31);
rhrData = rhrData.slice(0, 31);
cholData = cholData.slice(0, 31);

debugger;
createChart(BpSystData, BpSystChart, "Systolic Blood Pressure", "mmHg");
createChart(BpDiastData, BpDiastChart, "Diastolic Blood Pressure", "mmHg");
createChart(rhrData, rhrChart, "Resting Heart Rate", "BPM");
createChart(cholData, cholChart, "Cholesterol", "mmol/L");

function createChart(data, chartId, label, unit) {
	var scatterChart = new Chart(chartId, {
	    type: 'line',
	    data: {
	        datasets: [{
	            label: label,
	            data: data,
	            backgroundColor: 'rgba(255, 111, 0, 0.3)',
	            lineTension: 0
	        }]
	    },
	    options: {
	        scales: {
	            xAxes: [{
	            	type: 'time',
	                position: 'bottom',
	                time: {
	                    unit: 'day'
	                }
	            }],
	            yAxes: [{
	                scaleLabel: {
	                  display: true,
	                  labelString: label + ' (' + unit + ')' 
	                },
	                ticks: {
	                    beginAtZero: true
	                }
	              }]
	        },
	        title: {
	            display: true,
	            text: label,
	            fontSize: 16
	        },
	        legend: {
	            display: false
	        },
	        responsive:false,
	        maintainAspectRatio: false
	    }
	});
}

</script>