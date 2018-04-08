package com.mie.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mie.model.Conversation;
import com.mie.model.Diagnosis;
import com.mie.model.File;
import com.mie.util.DbUtil;
/*
 * The Diagnosis DAO is used to represent and interact with diagnoses in the system.
 */
public class FileDao { // Diagnosis Data Access Object (extends patient since a lot of that class's attributes is used  

	private static Connection connection;

	public FileDao() {
		connection = DbUtil.getConnection(); // establish connection with the database
	}

	public List<File> getFiles(int pId) { // get all the patient's diagnoses by their id  
		List<File> files = new ArrayList<File>(); 
		// Also want to get some of the corresponding doctor info for a diagnosis such as Name. 
		// Hence we do an inner join with the User table
		
		try { 
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM File"
					                           + " WHERE File.PatientID="+pId
					                           + " ORDER BY File.TimeStamp DESC");
			// get all the matching diagnoses that correspond to the current doctor id
			while (rs.next()) {
				File f = new File();
				// get the whole diagnosis object
				f.setPatientId(rs.getInt("File.PatientID"));
				f.setTimeStamp(rs.getDate("File.TimeStamp"));
				f.setFileId(rs.getInt("File.FileID"));
				f.setBpDiast(rs.getInt("BpDiast"));
				f.setBpSyst(rs.getInt("BpSyst"));
				f.setChol(rs.getInt("Cholesterol"));
				f.setRHR(rs.getInt("RHR"));
				files.add(f);
			} // end while
						
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return files;
	}
	
	public void addRecord(File file){		
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("insert into File(PatientID,TimeStamp,BpDiast,BpSyst,RHR,Cholesterol) values (?, ?, ?, ?, ?, ? )");
			// Parameters start with 1
			preparedStatement.setInt(1, file.getPatientId());
			preparedStatement.setDate(2, new java.sql.Date(file.getTimeStamp().getTime()));
			preparedStatement.setInt(3, file.getBpDiast());
			preparedStatement.setInt(4, file.getBpSyst());
			preparedStatement.setInt(5, file.getRHR());
			preparedStatement.setInt(6, file.getChol());
			
			preparedStatement.executeUpdate(); // insert the new record
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}