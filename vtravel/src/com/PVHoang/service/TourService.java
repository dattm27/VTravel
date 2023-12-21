package com.PVHoang.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.PVHoang.model.Tours;

public class TourService extends BaseService {

	public static ArrayList<Tours> all() { 
		ArrayList<Tours> tours = new ArrayList<Tours>();
		try {
			// connect database
			Connection connection = getConnection();
			// tao statement
			Statement stmt = connection.createStatement();
			// rs la ket qua cua viec thuc thi cau lenh SELECT * FROM available_tour
			ResultSet rs = stmt.executeQuery("SELECT * FROM available_tour");
			// di qua tung phan tu ma rs lay duoc
			while (rs.next()) {
				int id = rs.getInt("id");
				int price = rs.getInt("price");
				int max_number_tourist = rs.getInt("max_number_tourist");
				String tour_name = rs.getString("tour_name");
				int discount = rs.getInt("discount");
				String start_place = rs.getString("start_place");
				String description = rs.getString("description");
				// tao bien tour voi nhung thuoc tinh get duoc
				Tours tour = new Tours(id, price, max_number_tourist, tour_name, discount, start_place, description);
				// add tour vao list
				tours.add(tour);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return tours;
	}
	
	public static Tours find (int id) {
		Tours tour = new Tours();
		// truy van tim tour voi id la id
		String sql = "SELECT * FROM available_tour WHERE id = " + Integer.toString(id);
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception ex) {
			// TODO: handle exception
		}
		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			// tao statement 
			Statement stmt = conn.createStatement();
			// rs la ket qua khi thuc hien cau lenh sql	
			ResultSet rs = stmt.executeQuery(sql);) {
			// duyet tat ca cac ket qua tu rs
			if (rs.next()) {
				int price = rs.getInt("price");
				int max_number_tourist = rs.getInt("max_number_tourist");
				String tour_name = rs.getString("tour_name");
				int discount = rs.getInt("discount");
				String start_place = rs.getString("start_place");
				String description = rs.getString("description");
				String start_date = rs.getString("start_date");
				String end_date = rs.getString("end_date");
				String start_discount = rs.getString("start_discount");
				String end_discount = rs.getString("end_discount");
				String status = rs.getString("status");
				// set thuoc tinh ch tour de return
				tour.setId(id);
				tour.setPrice(price);
				tour.setMax_number_tourist(max_number_tourist);
				tour.setTour_name(tour_name);
				tour.setDiscount(discount);
				tour.setStart_place(start_place);
				tour.setDescription(description);
				tour.setStart_date(start_date);
				tour.setEnd_date(end_date);
				tour.setStart_discount(start_discount);
				tour.setEnd_discount(end_discount);
				tour.setStatus(status);
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}
		return tour;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
	}

}
