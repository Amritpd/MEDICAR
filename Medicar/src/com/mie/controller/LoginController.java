package com.mie.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mie.dao.DiagnosisDao;
import com.mie.dao.FileDao;
import com.mie.dao.UserDao;
import com.mie.model.File;
import com.mie.model.User;

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String PATIENT = "patient_dashboard.jsp";
	private static String DOCTOR = "listDiagnoses.jsp";
	private static String LOGIN = "login.jsp";
	private UserDao dao;
	private DiagnosisDao diadao;
	private FileDao fdao;
	
	public LoginController() {
		super();
		dao = new UserDao();
		diadao = new DiagnosisDao();
		fdao = new FileDao();
	}

protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	           throws ServletException, java.io.IOException {
	
	User user = new User(); // create a new user instance 
	// grab the email and password inputed by user 
	user.setEmail(request.getParameter("email"));
	user.setPassword(request.getParameter("password"));
	String forward = "";

	try {	    
			
		user = dao.login(user); // attempt to login with the given user credentials
		
		// user should now have a role and their ID set
		if (user.getRole() != null && user.getUserid() > 0){
			
			HttpSession session = request.getSession(true); // get the current session
			session.setAttribute("currentUser", user); // set the currentUser object to the user 
			
			if (user.getRole().equalsIgnoreCase("Doctor")){
				forward = DOCTOR; // go to doctor dashboard 
				//make sure the doctors diagnoses are set 
				request.setAttribute("diagnoses", diadao.getDiagnoses(user.getUserid()));
			}
			else if (user.getRole().equalsIgnoreCase("Patient")){
				forward = PATIENT; // go to patient dashboard
				session.setAttribute("biometrics", fdao.getFiles( user.getUserid() ));
			}
			
		} else {
			String message = "Invalid credentials. Try again.";
			request.setAttribute("message", message); // use request and not session since we don't want the error message 
			forward = LOGIN;										  // to last the whole session
			//show error message instead of re-routing 
		}
	
	} catch (Throwable e){
		System.out.println(e); 
	}
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	} // end doGet

} // end class 
