package com.mie.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mie.model.User;
import com.mie.util.DbUtil;

/*
 * The patient DAO is used to represent patients in a doctor's database. Note that patients are
 * just a subset of users in the system, hence a corresponding Patient class was not needed and 
 * we could the User class was enough for our needs  
 */
public class PatientDao { // Patient Data Access Object

	private static Connection connection;

	public PatientDao() {
		connection = DbUtil.getConnection(); // establish connection with the
												// database
	}

	public List<User> getPatients(int dId) {
		List<User> patients = new ArrayList<User>();
		ArrayList<Integer> pids = new ArrayList<Integer>();

		try {
			Statement statement = connection.createStatement();
			ResultSet rs = statement
					.executeQuery("select PatientID from Doctor_To_Patient where DoctorID="
							+ dId);
			// get all the matching patient IDs that correspond to the current
			// doctor id
			while (rs.next()) {
				pids.add(rs.getInt("PatientID"));
			}

			// now we need to get the names and other info of the matching
			// pateints by patient ID
			// manually build the prepared statement (since other methods did
			// not work)

			StringBuilder builder = new StringBuilder();
			for (int i = 0; i < pids.size(); i++) { // get all the question
													// marks we need
				builder.append("?,");
			}

			String stmt = "select * from User where UserID in ("
					+ builder.deleteCharAt(builder.length() - 1).toString()
					+ ")" + " ORDER BY User.LastName ASC";
			// prepare the statement
			PreparedStatement preparedStatement = connection
					.prepareStatement(stmt);

			int index = 1;
			for (int id : pids) { // iterate through the pids
				preparedStatement.setInt(index++, id); // set the question mark
														// equal to the currrent
														// pid
			}
			ResultSet rs2 = preparedStatement.executeQuery(); // execute the
																// prepared
																// statement

			while (rs2.next()) { // iterate through the result set
				User patient = new User();
				patient.setFirstName(rs2.getString("FirstName"));
				patient.setLastName(rs2.getString("LastName"));
				patient.setEmail(rs2.getString("Email"));
				patient.setUserid(rs2.getInt("UserID"));
				// add the patient to the patient list
				patients.add(patient);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return patients;
	}

	public User getPatient(int pId) {
		User user = new User();
		try { // statement returns the patient corrsponding to the PId
			PreparedStatement preparedStatement = connection
					.prepareStatement("select * from User where UserID=?");
			preparedStatement.setInt(1, pId);
			ResultSet rs = preparedStatement.executeQuery(); // should only
																// contain one
																// user
			if (rs.next()) { // if we find a matching user
				user.setUserid(rs.getInt("UserID")); // set the id and role of
														// the user object
				user.setFirstName(rs.getString("FirstName"));
				user.setLastName(rs.getString("LastName"));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}
}