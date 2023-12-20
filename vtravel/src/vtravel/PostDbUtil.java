package vtravel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import vtravel.dlinh.Post;

public class PostDbUtil {
	private DataSource dataSource;

	public PostDbUtil(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}

	// Lấy tất cả thông tin của 1 bài Post và lưu trữ dưới dạng List
	public List<Post> getPostList() throws SQLException {
		List<Post> postList = new ArrayList<>();
		
		Connection myConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;

		try {
			// Thiết lập kết nối đến database
			myConn = dataSource.getConnection();

			// Viết câu lệnh sql
			String sql = "select post_name, short_description from post";
			myStmt = myConn.prepareStatement(sql);

			// Thực thi truy vấn
			myRs = myStmt.executeQuery();

			// Lấy các trường thông tin kết quả thu được từ thực thi truy vấn bao gồm tên Post và Short_Description
			while (myRs.next()) {
				String name = myRs.getString("post_name");
				String shortDescription = myRs.getString("short_description");

				// Tạo ra đối tượng post để lưu trữ các thông tin lấy được
				Post post = new Post(name, shortDescription);

				// Thêm đối tượng post vào postList
				postList.add(post);
			}
			// Trả về đối tượng post chứa các thông tin lấy được
			return postList;
		} finally {
			close(myConn, myStmt, myRs);
		}
	}
	
	private void close(Connection myConn, Statement myStmt, ResultSet myRs) {
		try {
			if (myRs != null) {
				myRs.close();
			}
			if (myStmt != null) {
				myStmt.close();
			}
			if (myConn != null) {
				myConn.close();
			}
		} catch (Exception exc) {
			exc.printStackTrace();
		}
	}
}
