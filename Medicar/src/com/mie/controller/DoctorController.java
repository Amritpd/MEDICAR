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
import com.mie.model.Conversation;
import com.mie.model.Diagnosis;
import com.mie.model.User;

// control what the doctor can do from his/her dashboard
public class DoctorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String DIAGNOSIS = "/diagnosis.jsp",
				 		  LIST_PATIENTS = "/listPatients.jsp",
	                      LIST_DIAGNOSES = "/listDiagnoses.jsp",
	                      PATIENT = "/patient_dashboard.jsp";
	                      
	
	private UserDao dao;
	private PatientDao pdao;
	private DiagnosisDao diadao;  
	private FileDao fdao;

	public DoctorController() {
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
		// list the doctor's patients
		if (action.equalsIgnoreCase("listPatients")){
			forward = LIST_PATIENTS;
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("currentUser");
			request.setAttribute("patients", pdao.getPatients(user.getUserid()) ); 
		} else if (action.equalsIgnoreCase("listDiagnoses")){ // list the doctor's recent diagnosis
			forward = LIST_DIAGNOSES;
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("currentUser");
			request.setAttribute("diagnoses", diadao.getDiagnoses(user.getUserid()));
		} else if (action.equalsIgnoreCase("show")){ // navigate to a specific diagnosis 
			forward = DIAGNOSIS; 
			int dId = Integer.parseInt(request.getParameter("dId")); // get the unique id of the diagnosis
			request.setAttribute("diagnosis", diadao.getDiagnosis(dId)); // set the diagnosis 
			request.setAttribute("comments", diadao.getComments(dId));	
		} else if (action.equalsIgnoreCase("patient")){ // navigate to a specific patient
			forward = PATIENT;
			HttpSession session = request.getSession(true); // get the current session
			int pId = Integer.parseInt(request.getParameter("pId")); // get the unique id of the patient
			session.setAttribute("biometrics", fdao.getFiles( pId ));
			session.setAttribute("currentPatient", pdao.getPatient(pId)); // set the currentPatient object to the clicked patient
		} 
		
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
		
	}
	// handle editing, deletion, and insertion of comments
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException { // adds comment to diagnosis
		 
		int dId = Integer.parseInt(request.getParameter("dId")); // get the diagnosis Id
		// if the user clicks delete button 
		if (request.getParameter("delete") != null){
			System.out.println("BUTTON PRESSED: "  + request.getParameter("delete"));
			diadao.removeComment(Integer.parseInt(request.getParameter("cId")));
			diadao.updateDiagnosis(dId);
		}else { // user is adding a new comment
			// we need to grab the comment. See if it is null or not. 
			String msg = request.getParameter("comment");
			if (msg.length() == 0){ // if comment string is empty
					request.setAttribute("message", "Cannot enter empty comment."); 
			} else {
				// get the user object
				HttpSession session = request.getSession();
				User user = (User) session.getAttribute("currentUser");
				int userId = user.getUserid(); 
				Diagnosis current = diadao.getDiagnosis(dId); // current diagnosis
						
				Conversation comment = new Conversation(); // new conversation object to store the comment
				
				// commentId is autoNumbered 
				comment.setDiagnosisId(dId);
				comment.setFrom(userId);// assume that the message is always from the current user
				comment.setPatientId(current.getPatientId()); // set the patient id
				if (userId == current.getPatientId()){ // if the user id equals the diagnosis' patient Id,
					comment.setTo(current.getDoctorId()); // we know the comment is from the patient therefore comment is to doctor
				} else { // the comment must be from the doctor directed to the patient
					comment.setTo(current.getPatientId());
				}
				comment.setMessage(msg); // set the actual message
				comment.setTimeStamp(new Date()); // set the time  stamp
				// add the comment to Db
				diadao.addComment(comment); // add the comment to the diagnosis
				diadao.updateDiagnosis(dId); // update the diagnosis
			}
		} // end else
		request.setAttribute("diagnosis", diadao.getDiagnosis(dId)); // set the diagnosis 
		request.setAttribute("comments", diadao.getComments(dId));	// set the comments associated w/ diagnosis
	
		RequestDispatcher view = request.getRequestDispatcher(DIAGNOSIS);
		view.forward(request, response);

		
	}
}