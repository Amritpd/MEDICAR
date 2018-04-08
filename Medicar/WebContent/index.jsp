<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1">
 
 <script src="js/jquery-3.1.1.min.js"></script>
 <script src="js/bootstrap.min.js"></script>
 <!-- <link rel="stylesheet" type="text/css" href="style/DeepNavbarStyles.css">  --> 
 <link rel="stylesheet" href="style/bootstrap.min.css">


<title>MEDICAR Diagnosis Manager</title>
  <style>
  .carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
      width: 100%;
      margin-top:-30px;
      
  }
  
   .jumbotron {
      background-color: #f4511e;
      color: #fff;
      padding: 100px ;
  }
  
  
		 .container-fluids {
      padding: 60px 50px;
  }  
    .bg-about {
      background-color: #345678;
      color: white;
  }
  
  
   .bg-Info1{
  	background-color:#789fbb;
  	color:white;
  }
  .bg-Info{
  	background-color:#8abca7;
  	color:white;
  }
   .bg-Links{
  	background-color:#c2d5db;
  	color:white;
  }
  </style>

</head>

<body data-spy="scroll" data-target=".navbar" data-offset="50">





<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">MediCar</a>
    </div>
    <div>
      <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="nav navbar-nav">
          <li><a href="#section1">About	</a></li>
          <li><a href="#section2">Doctors</a></li>
          <li><a href="#section3">Patients</a></li>
          <li><a href="login.jsp" >Login</a></li> 
        </ul>
      </div>
    </div>
  </div>
</nav>  

   <div class="slider-container">
  <br>
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
      <li data-target="#myCarousel" data-slide-to="3"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">

      <div class="item active">
        <img src="style/slider1.jpg" alt="Chania" width="460" height="345">
        <div class="carousel-caption">
          <h3>Welcome to Medicar</h3>
          <p>The future of doctor-patient interactions.</p>
        </div>
      </div>

      <div class="item">
        <img src="style/slider2pic.jpg" alt="Chania" width="100%" height="=100%">
        <div class="carousel-caption">
          
        </div>
      </div>
    
      <div class="item">
        <img src="style/slider3.jpg" alt="Flower" width="460" height="345">
        <div class="carousel-caption">
        
        </div>
      </div>

      <div class="item">
        <img src="style/slider4.jpg" alt="Flower" width="460" height="345">
        <div class="carousel-caption">
         
        </div>
      </div>
  
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>
  <div class="container-fluid bg-about">
  <h1>About Medicar</h1>
  <h2>A Diagnosis Manager for Doctors!</h2>   
  <p>The MEDICAR team was contracted to minimize the amount of time healthcare professionals spend on administrative tasks. Currently, doctors and nurses waste valuable time on biometric data collection, physical data recording and retrieval, and unnecessary conversation with patients on non-critical topics. This wastes the time of both healthcare professionals and patients, wastes taxpayer dollars, and results in reduced quality of service.</p>
  <p>The solution the MEDICAR team created is the MEDICAR Diagnosis Manager, a web application that digitizes doctor-patient interaction. This system allows two distinct user classes, patients and doctors, to interact with one another, each with their own functionality reflecting their needs. The patients are able to upload their biometric data, view their data history in table and graph form, view diagnoses issued by their doctor(s), and interact with their doctor by commenting on a diagnosis. The doctors are able to view the data their patient(s) upload, issue diagnoses, and interact with their patient by commenting on previously issued diagnoses. 
  </p>
   
  <h1> HOW IT WORKS</h1>
  <p>Doctors can log into the system, and view a list of their most recent conversations with patients. They can go to the "Patients" tabs to manage the patients that are assigned to them. A doctor can then press "See more" on a patient's profile, and they will be granted a view of the patient's dashboard, File history, and diagnoses tab. By pressing this, the doctor can see the diagnosis discussion they had with the patient, or create a diagnosis by pressing "Create Diagnosis" when they have manouvered to the Diagnoses tab of the patient's profile. They can also press the "Go Back to Patients" button to return to a list of their assigned patients.</p>
	<br/>
<p>Patients can upload a csv file of their biometric data, view the actual numbers in their "Files tab" for each file they uploaded, and also view diagnosis discussions they have with their doctors in the "Diagnoses" tab.</p>		

</div>

<div class="container-fluid bg-Info1">
  <h1>MEDICAR - An MIE350 Project</h1>
  <h4> Medicar was designed as a 3rd year Industrial Engineering project by a group of 7 students, of which 4 were on the dev team. The purpose of this application is to allow Doctors to interact with and keep track of their patients seamlessly.</h4>
  <h2>The Dev Team</h2>
  <h3> Amrit Prasad</h3> <p> With a background in industrial engineering, Amrit is an expert in understanding business requirements and 
  creating powerful software solutions that optimize the way companies do work.</p>
  <h3> Deep Prasad</h3> <p> Lead front-end designer for the website, experienced in Internet of Things, Big Data, and Web development.</p>
  <h3> Mohammed Manek</h3> Co-Backend designer. Experience in full stack web development and hackathon organizer.
  <h3> Ronnie Yakubov</h3> Experienced in QA testing, in charge of data analytics features of Medicar.com.  
  
</div>


<div class="container-fluid bg-Info">
<h1> Healthcare Industry Overview</h1>
  <h3> Motivation and Purpose</h3>
  <p>A doctor’s time can potentially mean the life of their patient. Therefore, it is important for doctors to be able to maximize the amount of time spent performing critical patient-facing tasks. However, according to a recent study, doctors tend to spend more time doing paperwork than time in front of patients <a href="http://annals.org/aim/article/2546704/allocation-physician-time-ambulatory-practice-time-motion-study-4-specialties " style="color:grey;">[1]</a>. MEDICAR aims to change that by providing a streamlined way for doctors to perform diagnoses, collect biometric data (such as resting heart rate or blood pressure), keep a live “paper trail” of their work, and interact with their patients without scheduling in-person appointments.  </p>
  <br/>
  <h4>This current “as-is” system has three explicit issues:
   </h4>
  
  
  <ul>
  	<li> <p>In-Person Biometric Data Collection: patients must meet with a medical professional in person to have their biometric data collected, wasting the time of both parties.</p></li>
	<li><p>Non-Critical Doctor-Patient Interaction: currently, a portion of in-person doctor-patient conversations are non-critical, consisting of an information exchange that could be had digitally. As it stands, both patient and doctor time is wasted on setting up an appointment to have a non-critical conversation.</p></li>
	<li>Undigitized Patient Data: many hospitals keep physical, paper records of patient data. Physical records are difficult to manage as they grow, requiring a lot of physical space and a consistent organization structure. Poorly executed physical organizational systems lead to problems with ease of access, inflated costs, storage, and potential loss of data <a href="https://www.bloomberg.com/news/articles/2012-06-21/why-dont-more-hospitals-use-electronic-health-records " style="color:grey;">[2]</a>.</li>
</ul>
</div>

<div class="container-fluid bg-Links">
<h1>Relevant Links</h1>
<a href="http://patient.info/symptom-checker"> http://patient.info/symptom-checker</a>
<a href="http://symptoms.webmd.com/#introView"> http://symptoms.webmd.com/#introView</a>
</div>  


<div id="section2" class="container-fluid">
	
<div class="jumbotron text-center">
  <h1>MEDICAR</h1> 
  <p>We specialize in digitizing patient-doctor interactions.</p> 
  <form class="form-inline">
    <div class="input-group">
      <input type="email" class="form-control" size="50" placeholder="Email Address" required>
      <div class="input-group-btn">
        <button type="button" class="btn btn-danger">Subscribe</button>
      </div>
    </div>
  </form>
</div>
	
</div>

</body>
</html>