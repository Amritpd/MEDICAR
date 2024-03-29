package com.mie.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
/*
 * This class provides a factory method that returns the object of Connection. 
 * Here, the driver class is loaded only once and the connection object gets 
 * memory only once because it is static.
 */

public class DbUtil {

	private static Connection connection = null;

	public static Connection getConnection() { // establish a connection with the database
		if (connection != null)
			return connection;
		else {
			try {
				Properties prop = new Properties();
				InputStream inputStream = DbUtil.class.getClassLoader()
						.getResourceAsStream("/db.properties");
				prop.load(inputStream);
				String driver = prop.getProperty("driver");
				String url = prop.getProperty("url");
				String user = prop.getProperty("user");
				String password = prop.getProperty("password");
				Class.forName(driver);
				connection = DriverManager.getConnection(url, user, password);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return connection;
		}

	}
}