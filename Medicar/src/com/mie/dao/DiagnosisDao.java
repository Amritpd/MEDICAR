package com.mie.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.mie.model.Conversation;
import com.mie.model.Diagnosis;
import com.mie.util.DbUtil;
/*
 * The Diagnosis DAO is used to represent and interact with diagnoses in the system.
 */
public class DiagnosisDao { // Diagnosis Data Access Object (extends patient since a lot of that class's attributes is used  

	private static Connection connection;

	public DiagnosisDao() {
		connection = DbUtil.getConnection(); // establish connection with the database
	}
	
	public void addDiagnosis (Diagnosis dia){
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("insert into Diagnosis(DoctorID,PatientID,DiagnosisName,Symptoms,Prognosis,CreatedOn,LastUpdated) values (?, ?, ?, ?, ?, ?, ?)");
			// Parameters start with 1
			preparedStatement.setInt(1, dia.getDoctorId());
			preparedStatement.setInt(2, dia.getPatientId());
			preparedStatement.setString(3, dia.getDiagnosisName());
			preparedStatement.setString(4, dia.getSymptoms());
			preparedStatement.setString(5, dia.getPrognosis());
			preparedStatement.setDate(6, new java.sql.Date(dia.getCreatedOn().getTime()));
			preparedStatement.setDate(7, new java.sql.Date(dia.getCreatedOn().getTime()));
			
			preparedStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public List<Diagnosis> getDiagnoses(int dId) { // get the diagnoses corresponding to a doctor's id
		List<Diagnosis> diagnoses = new ArrayList<Diagnosis>(); 
		// Also want to get some of the corresponding patient info for a diagnosis such as Name. 
		// Hence we do an inner join with the User table
		
		try { 
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM Diagnosis"
					                           + " INNER JOIN User ON Diagnosis.PatientID=User.UserID"
					                           + " WHERE Diagnosis.DoctorID="+dId
					                           + " ORDER BY Diagnosis.LastUpdated DESC");
			// get all the matching diagnoses that correspond to the current doctor id
			while (rs.next()) {
				Diagnosis dg = new Diagnosis();
				// get the whole diagnosis object
				dg.setDiagnosisId(rs.getInt("Diagnosis.DiagnosisID"));
				dg.setDoctorId(rs.getInt("Diagnosis.DoctorID"));
				dg.setPatientId(rs.getInt("Diagnosis.PatientID"));
				dg.setDiagnosisName(rs.getString("Diagnosis.DiagnosisName"));
				dg.setSymptoms(rs.getString("Diagnosis.Symptoms"));
				dg.setPrognosis(rs.getString("Diagnosis.Prognosis"));
				dg.setCreatedOn(rs.getDate("Diagnosis.CreatedOn"));
				dg.setLastUpdated(rs.getDate("Diagnosis.LastUpdated"));
				// set the patient's first and last name 
				dg.setFirstName(rs.getString("User.FirstName"));
				dg.setLastName(rs.getString("User.LastName"));
		
				/*System.out.println("DIAG: "+ dg.getDiagnosisId() + " || " + dg.getLastUpdated() + " || " + dg.getFirstName());*/
				diagnoses.add(dg);
			} // end while
						
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return diagnoses;
	}
	
	public List<Diagnosis> getDiagnoses2(int pId) { // get all the patient's diagnoses by their id  
		List<Diagnosis> diagnoses = new ArrayList<Diagnosis>(); 
		// Also want to get some of the corresponding doctor info for a diagnosis such as Name. 
		// Hence we do an inner join with the User table
		
		try { 
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM Diagnosis"
					                           + " INNER JOIN User ON Diagnosis.DoctorID=User.UserID"
					                           + " WHERE Diagnosis.PatientID="+pId
					                           + " ORDER BY Diagnosis.LastUpdated DESC");
			// get all the matching diagnoses that correspond to the current doctor id
			while (rs.next()) {
				Diagnosis dg = new Diagnosis();
				// get the whole diagnosis object
				dg.setDiagnosisId(rs.getInt("Diagnosis.DiagnosisID"));
				dg.setDoctorId(rs.getInt("Diagnosis.DoctorID"));
				dg.setPatientId(rs.getInt("Diagnosis.PatientID"));
				dg.setDiagnosisName(rs.getString("Diagnosis.DiagnosisName"));
				dg.setSymptoms(rs.getString("Diagnosis.Symptoms"));
				dg.setPrognosis(rs.getString("Diagnosis.Prognosis"));
				dg.setCreatedOn(rs.getDate("Diagnosis.CreatedOn"));
				dg.setLastUpdated(rs.getDate("Diagnosis.LastUpdated"));
				// set the doctor's first and last name 
				dg.setFirstName(rs.getString("User.FirstName"));
				dg.setLastName(rs.getString("User.LastName"));
		
				/*System.out.println("DIAG: "+ dg.getDiagnosisId() + " || " + dg.getLastUpdated() + " || " + dg.getFirstName());*/
				diagnoses.add(dg);
			} // end while
						
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return diagnoses;
	}
	// get diagnoses related to specific patient+doctor
	public List<Diagnosis> getDiagnoses2(int pId, int dId) { 
		List<Diagnosis> diagnoses = new ArrayList<Diagnosis>(); 
		// Also want to get some of the corresponding doctor info for a diagnosis such as Name. 
		// Hence we do an inner join with the User table
		
		try { 
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM Diagnosis"
					                           + " INNER JOIN User ON Diagnosis.DoctorID=User.UserID"
					                           + " WHERE Diagnosis.PatientID="+pId + " AND Diagnosis.DoctorID="+dId 
					                           + " ORDER BY Diagnosis.LastUpdated DESC");
			// get all the matching diagnoses that correspond to the current doctor id
			while (rs.next()) {
				Diagnosis dg = new Diagnosis();
				// get the whole diagnosis object
				dg.setDiagnosisId(rs.getInt("Diagnosis.DiagnosisID"));
				dg.setDoctorId(rs.getInt("Diagnosis.DoctorID"));
				dg.setPatientId(rs.getInt("Diagnosis.PatientID"));
				dg.setDiagnosisName(rs.getString("Diagnosis.DiagnosisName"));
				dg.setSymptoms(rs.getString("Diagnosis.Symptoms"));
				dg.setPrognosis(rs.getString("Diagnosis.Prognosis"));
				dg.setCreatedOn(rs.getDate("Diagnosis.CreatedOn"));
				dg.setLastUpdated(rs.getDate("Diagnosis.LastUpdated"));
				// set the doctor's first and last name 
				dg.setFirstName(rs.getString("User.FirstName"));
				dg.setLastName(rs.getString("User.LastName"));
		
				/*System.out.println("DIAG: "+ dg.getDiagnosisId() + " || " + dg.getLastUpdated() + " || " + dg.getFirstName());*/
				diagnoses.add(dg);
			} // end while
						
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return diagnoses;
	}
	
	public Diagnosis getDiagnosis (int dId){  
		Diagnosis dg = new Diagnosis(); 
		try { 
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM Diagnosis"
                    + " INNER JOIN User ON Diagnosis.PatientID=User.UserID"
                    + " WHERE Diagnosis.DiagnosisID="+dId);
			
			// the above query should return exactly one entry 
			if (rs.next()) {
				// set the diagnosis object + some patient attributes
				dg.setDiagnosisId(rs.getInt("Diagnosis.DiagnosisID"));
				dg.setDoctorId(rs.getInt("Diagnosis.DoctorID"));
				dg.setPatientId(rs.getInt("Diagnosis.PatientID"));
				dg.setDiagnosisName(rs.getString("Diagnosis.DiagnosisName"));
				dg.setSymptoms(rs.getString("Diagnosis.Symptoms"));
				dg.setPrognosis(rs.getString("Diagnosis.Prognosis"));
				dg.setCreatedOn(rs.getDate("Diagnosis.CreatedOn"));
				dg.setLastUpdated(rs.getDate("Diagnosis.LastUpdated"));
				// set the patient's first and last name 
				dg.setFirstName(rs.getString("User.FirstName"));
				dg.setLastName(rs.getString("User.LastName"));
			
			} // end if
						
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dg;	 
	}
	
	public void updateDiagnosis (int dId){
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("UPDATE Diagnosis SET Diagnosis.LastUpdated=? WHERE Diagnosis.diagnosisID=?");
		
			
			preparedStatement.setDate(1,new java.sql.Date(new Date().getTime()));
			preparedStatement.setInt(2,dId);
			preparedStatement.executeUpdate();
		} catch (SQLException e){
			e.printStackTrace(); 
		}
	}
	
	public List<Conversation> getComments (int dId){ // get the comments corresponding to a certain diagnosis
	
		List<Conversation> comments = new ArrayList<Conversation>();
		try { 
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT Conversation.*, User.FirstName FROM Conversation"
												+ " INNER JOIN User ON User.UserID=Conversation.From"
												+ " WHERE Conversation.DiagnosisID="+dId
												+ " ORDER BY Conversation.TimeStamp ASC");
			// the above query should find all the records in the Conversation table pertaining to the particular Diagnosis ID
			while (rs.next()) {
				Conversation comment = new Conversation(); 
				// set the entire comment object
				comment.setCommentId(rs.getInt("Conversation.CommentID"));
				comment.setDiagnosisId(rs.getInt("Conversation.DiagnosisID"));
				comment.setTo(rs.getInt("Conversation.To"));
				comment.setFrom(rs.getInt("Conversation.From"));
				comment.setPatientId(rs.getInt("Conversation.PatientID"));
				comment.setMessage(rs.getString("Conversation.Message"));
				comment.setTimeStamp(rs.getDate("Conversation.TimeStamp"));
				comment.setName(rs.getString("User.FirstName"));
				comments.add(comment);
			} // end while
						
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return comments;	 
	}
	
	public void addComment (Conversation comment){		
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("insert into Conversation(DiagnosisID,To,From,PatientID,Message,TimeStamp) values (?, ?, ?, ?, ?, ? )");
			// Parameters start with 1
			preparedStatement.setInt(1, comment.getDiagnosisId());
			preparedStatement.setInt(2, comment.getTo());
			preparedStatement.setInt(3, comment.getFrom());
			preparedStatement.setInt(4, comment.getPatientId());
			preparedStatement.setString(5, comment.getMessage());
			preparedStatement.setDate(6, new java.sql.Date(comment.getTimeStamp().getTime()));
			
			preparedStatement.executeUpdate(); // inser the new comment
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void removeComment (int cId){
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("DELETE FROM Conversation WHERE Conversation.commentId="+cId);
			preparedStatement.executeUpdate(); // delete the comment by executing the statement
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}