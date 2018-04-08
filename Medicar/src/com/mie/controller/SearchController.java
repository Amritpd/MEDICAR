package com.mie.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.mie.dao.FileDao;
import com.mie.dao.UserDao;
import com.mie.model.File;
import com.mie.model.Record;
import com.mie.model.User;

public class SearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String INSERT_OR_EDIT = "/user.jsp";
	private static String LIST_USER = "/listUser.jsp";
	private static String SEARCH_USER = "/searchFNUser.jsp";
	private static String PATIENT = "patient_dashboard.jsp";
	private UserDao dao;
	private FileDao fdao;

	public SearchController() {
		super();
		dao = new UserDao();
		fdao = new FileDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String forward = "";
		String action = request.getParameter("action");

		if (action.equalsIgnoreCase("delete")) {
			int userId = Integer.parseInt(request.getParameter("userId"));
			dao.deleteUser(userId);
			forward = LIST_USER;
			request.setAttribute("users", dao.getAllUsers());
		} else if (action.equalsIgnoreCase("edit")) {
			forward = INSERT_OR_EDIT;
			int userId = Integer.parseInt(request.getParameter("userId"));
			User user = dao.getUserById(userId);
			request.setAttribute("user", user);
		} else if (action.equalsIgnoreCase("listUser")) {
			forward = LIST_USER;
			request.setAttribute("users", dao.getAllUsers());
		} else {
			forward = INSERT_OR_EDIT;
		}
		
		System.out.println("FOWARD: "+ forward);
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//User user = new User();
		//user.setFirstName(request.getParameter("firstName"));
		//user.setLastName(request.getParameter("lastName"));
		
						
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("currentUser");
		int userId = user.getUserid();
		
		
		String jsonString = request.getParameter("jsonString");
		Gson gson = new Gson();
		Record[] biometricsRecords = gson.fromJson(jsonString, Record[].class);
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		Date d;

		
		for(Record record : biometricsRecords) {
			// do something
			System.out.println(record.getRHR());
			File file = new File();
			file.setBpDiast(record.getBpDiast());
			file.setBpSyst(record.getBpSyst());
			file.setChol(record.getChol());
			file.setRHR(record.getRHR());
			file.setPatientId(userId);
			try {
				d = sdf.parse(record.getDate());
				file.setTimeStamp( sdf.parse( record.getDate() )  );
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			fdao.addRecord(file);
		}	
		
		session.setAttribute("biometrics", fdao.getFiles( user.getUserid() ));
		RequestDispatcher view = request.getRequestDispatcher(PATIENT);
		view.forward(request, response);
		
//		String keyword = request.getParameter("keyword");
//		
//		RequestDispatcher view = request.getRequestDispatcher(SEARCH_USER);
//		request.setAttribute("keyword", keyword);
//		request.setAttribute("users", dao.getUserByKeyword(keyword));
//		view.forward(request, response);
	}
}