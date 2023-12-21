package com.PVHoang.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.PVHoang.model.Posts;

public class PostService extends BaseService {
	public static ArrayList<Posts> all() { 
		ArrayList<Posts> Posts = new ArrayList<Posts>();
		try {
			// connect database
			Connection connection = getConnection();
			// tao statement
			Statement stmt = connection.createStatement();
			// rs la ket qua cua viec thuc thi cau lenh SELECT * FROM post
			ResultSet rs = stmt.executeQuery("SELECT * FROM post");
			// di qua tung phan tu ma rs lay duoc
			while (rs.next()) {
				int id = rs.getInt("id");
				int user_id = rs.getInt("user_id");  
				String content = rs.getString("content");
				String post_date = rs.getString("post_date");
				// tao bien bai viet voi nhung thuoc tinh get duoc
				Posts post = new Posts(id, user_id, content, post_date);
				// add post vao list
				Posts.add(post);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return Posts;
	}
	
	public static Posts find (int id) {
		Posts post = new Posts();
		// truy van de tim post co id la id 
		String sql = "SELECT * FROM post WHERE id = " + Integer.toString(id);
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
				int user_id = rs.getInt("user_id");  
				String content = rs.getString("content");
				String post_date = rs.getString("post_date");
				// set thuoc tinh cho post de return
				post.setId(id);
				post.setUser_id(user_id);
				post.setContent(content);
				post.setPost_date(post_date);
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}
		return post;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
