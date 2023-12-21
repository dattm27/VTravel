package com.PVHoang.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class BaseService {
	static final String DB_URL = "jdbc:mysql://localhost/web_travel_booking";
	static final String USER = "root";
	static final String PASS = "hong13102003";
	
	public static Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO: handle exception
			e1.printStackTrace();
		}
		// connect den database
		Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
		return conn;
	}
}
