package com.mie.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mie.dao.DiagnosisDao;
import com.mie.dao.FileDao;
import com.mie.dao.PatientDao;
import com.mie.dao.UserDao;
import com.mie.model.Diagnosis;
import com.mie.model.User;

// control what the patient can do from his/her dashboard
public class PatientController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String DIAGNOSIS = "/diagnosis.jsp";
	private static String LIST_FILES = "/listFiles.jsp";
	private static String LIST_DIAGNOSES = "/listPatientDiagnoses.jsp";
	private UserDao dao;
	private PatientDao pdao;
	private DiagnosisDao diadao;  
	private FileDao fdao; 

	public PatientController() {
		super();
		dao = new UserDao();
		pdao = new PatientDao(); 
		diadao = new DiagnosisDao();
		fdao = new FileDao(); 
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String forward = "";
		String action = request.getParameter("action");
		
		if (action.equalsIgnoreCase("listPatientDiagnoses")){ // if we want to list a patient's diagnoses 
			forward = LIST_DIAGNOSES; // next page is the patient's diagnoses
			HttpSession session = request.getSession();
			User patient = (User) session.getAttribute("currentPatient"),
					user = (User) session.getAttribute("currentUser");
			
			if (patient != null){ // implies doctor is looking at a patient's diagnoses
				// only want to show diagnoses corresponding to the logged in doctor and specific patient
				// user session variable is the doctor
				request.setAttribute("diagnoses", diadao.getDiagnoses2(patient.getUserid(),user.getUserid()));
			} else if (user != null){ // implies user (patient) is looking at his/her diagnoses 
			    // show all diagnoses corresponding to this patient
				request.setAttribute("diagnoses", diadao.getDiagnoses2(user.getUserid()));
			}
			      
		} else if (action.equalsIgnoreCase("listPatientFiles")){
			forward = LIST_FILES;
			HttpSession session = request.getSession();
			User patient = (User) session.getAttribute("currentPatient"),
					user = (User) session.getAttribute("currentUser");
			
			if (patient != null){ // implies doctor is looking at a patient's files and patient object is set
				request.setAttribute("files", fdao.getFiles(patient.getUserid()));
			} else if (user != null){ // implies user (patient) is looking at his/her files 
			    // show all files corresponding to this user
				request.setAttribute("files", fdao.getFiles(user.getUserid()));
			}
			
		}
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// Show the "New Diagnosis" form. 
		//The forward page will always be the patient's diagnoses page again 
		String clicked = request.getParameter("showForm"); // this gets set through the Javascript
		
		HttpSession session = request.getSession();
		User patient = (User) session.getAttribute("currentPatient"),
				user = (User) session.getAttribute("currentUser");
		
		String msg = "show"; // for convenience.
		 
		if (clicked != null){// if the user has clicked create diagnosis button
		request.setAttribute("showForm", true); // show the Create Diagnosis form
		} else if (request.getParameter("cancel") != null){ // if the cancel button is clicked 
			request.removeAttribute("showForm"); // hide the form	
		} else if (request.getParameter("submit") != null){ // if the submit button is clicked
			request.setAttribute("showForm", true); // initially keep showing the form - assume user puts invalid input
			// get the values from the form 
			String diagnosis = request.getParameter("diagnosisName"),
					symptoms = request.getParameter("symptoms"),
			       prognosis = request.getParameter("prognosis");
		
			if (diagnosis.length()==0 || symptoms.length()==0 || prognosis.length()==0){ // if field values aren't set
				String message = "All fields are mandatory. Try again.";
				request.setAttribute("message", message); 
			} else { // all values set
				Diagnosis dia = new Diagnosis();
				
				// assume the user is doctor (since only doctor can create diagnoses)
				dia.setDoctorId(user.getUserid());
				dia.setPatientId(patient.getUserid());
				dia.setDiagnosisName(diagnosis);
				dia.setSymptoms(symptoms);
				dia.setPrognosis(prognosis);
				dia.setCreatedOn(new Date());
				dia.setLastUpdated(new Date());
				
				diadao.addDiagnosis(dia);// insert the new diagnosis into the database
				request.removeAttribute("showForm"); // hide the form 
			}
		}
		
		if (patient != null){ // implies doctor is looking at a patient's diagnoses
			// only want to show diagnoses corresponding to the logged in doctor and specific patient
			// user session variable is the doctor
			request.setAttribute("diagnoses", diadao.getDiagnoses2(patient.getUserid(),user.getUserid()));
		} else if (user != null){ // implies user (patient) is looking at his/her diagnoses 
		    // show all diagnoses corresponding to this patient
			request.setAttribute("diagnoses", diadao.getDiagnoses2(user.getUserid()));
		}
	
		RequestDispatcher view = request.getRequestDispatcher(LIST_DIAGNOSES);
		view.forward(request, response);
	}
}