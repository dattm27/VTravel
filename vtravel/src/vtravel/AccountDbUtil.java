package vtravel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

public class AccountDbUtil {
	private DataSource dataSource;

	public AccountDbUtil(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}

	//lấy những thông tin chung của người dùng (bao gồm ID, tên, số điện thoại, địa chỉ email)
	public Account getAccountInf(int ID) throws SQLException {
		Account account = null;
		Connection myConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		try {
			//thiết lập kết nối cơ sở dữ liệu
			myConn = dataSource.getConnection();
			
			//viết SQL
			String sql = "select ID, username, fullname, phone_number, email, role from account where ID = ?";
			myStmt = myConn.prepareStatement(sql);
			
			//đặt tham số
			myStmt.setInt(1, ID);
			
			//thực thi truy vấn
			myRs = myStmt.executeQuery();
					
			//lấy ra thông tin từ kết quả và tạo ra đối tượng account
			while (myRs.next()) {
				
				String fullname = myRs.getString("fullname");
				String phonenumber = myRs.getString("phone_number");
				String email = myRs.getString("email");
				String username = myRs.getString("username");
				String role = myRs.getString("role");
				account = new Account(ID,  fullname,username, phonenumber, email, role);
				
			}
			//trả về đối tượng là người dùng có ID là ID
			return account;
			
		}
		finally {
			close(myConn, myStmt, myRs);
		}
	}
	public int checkLoginInf(String username, String password) throws SQLException {
			
			Connection myConn = null;
			PreparedStatement myStmt = null;
			ResultSet myRs = null;
			try {
				//thiết lập kết nối cơ sở dữ liệu
				myConn = dataSource.getConnection();
				
				//chuẩn bị sql
				String sql = "SELECT id from account where username = ? AND password = ?";
				myStmt = myConn.prepareStatement(sql);
				
				//đặt tham số
				myStmt.setString(1, username);
				myStmt.setString(2, password);
				
				//thực thi truy vấn
				myRs = myStmt.executeQuery();
				int result = -1;
				while(myRs.next()) {
					result = myRs.getInt("id");
				}	
				return result;
			}
			finally {
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
				myConn.close(); // doesn't really close
			}
		}
		catch (Exception exc){
			exc.printStackTrace();
		}
		
	}

	
	
	
}
