package com.PVHoang.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.jasper.tagplugins.jstl.core.If;

import com.PVHoang.model.*;

public class BookedTourService extends BaseService {
	public static ArrayList<BookedTour> BookedTours(int user_id, int kieusapxep, int limit, int page) {
		int offset = (page - 1) * limit;
		
		
		/*String sql = "SELECT * FROM available_tour where tour_name LIKE \"%" + diemmuonden + "%\""
				+ "and price >= " + minMoneyString + " and price <= " + maxMoneyString + " and start_date >= \""
				+ date_start + "\" " + " ORDER BY " + orderFeatureString
				+ " LIMIT " + Integer.toString(limit) + " OFFSET " + Integer.toString(offset);*/
		String orderFeatureString = "status";
		if (kieusapxep == 1) orderFeatureString = "price";
		if (kieusapxep == 2) orderFeatureString = "start_date";
		String user_idString = Integer.toString(user_id);
		String sql = "SELECT tour_id, start_date, tour_name, price, status " +  
				"FROM booking bk JOIN available_tour at ON bk.tour_id = at.id" + 
				" WHERE bk.user_id = " + user_idString + " ORDER BY " + orderFeatureString
				+ " LIMIT " + Integer.toString(limit) + " OFFSET " + Integer.toString(offset);		
		
		System.out.println(sql);
		ArrayList<BookedTour> booked_tours = new ArrayList<>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
		try (Connection conn = BaseService.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);) {
			while (rs.next()) {
				int id = rs.getInt("tour_id");
				int price = rs.getInt("price");
				String tour_name = rs.getString("tour_name");
				String start_date = rs.getString("start_date");
				String status = rs.getString("status");
				BookedTour bTour = new BookedTour(id, start_date, tour_name, price, status);
				booked_tours.add(bTour);
				
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return booked_tours;
	}
	public static int count(int user_id, int kieusapxep, int limit, int page) {
		//String sql = "SELECT count(*) as total FROM available_tour where tour_name LIKE \"%" + diemmuonden + "%\"";
		
		String user_idString = Integer.toString(user_id);
		String sql = "SELECT count(*) as total " +  
				"FROM booking bk JOIN available_tour at ON bk.tour_id = at.id" + 
				" WHERE bk.user_id = " + user_idString;	
		
		System.out.println(sql);
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
		try (Connection conn = BaseService.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);) {
				rs.next();
				
				return rs.getInt("total");
			}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
}