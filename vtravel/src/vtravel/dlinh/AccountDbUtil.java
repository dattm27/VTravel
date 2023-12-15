package vtravel.dlinh;

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

	// Lấy những thông tin chung của người dùng (bao gồm id, tên, số điện thoại, địa
	// chỉ email)
	public Account getGeneralInformation(int ID) throws SQLException {
		Account account = null;
		Connection myConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		
		try {
			// Thiết lập kết nối với database
			myConn = dataSource.getConnection();
			
			// Viết sql
			String sql = "select id, fullname, phone_number, email from account where id = ?";
			myStmt = myConn.prepareStatement(sql);
			
			// Đặt tham số
			myStmt.setInt(1, ID);
			
			// Thực thi truy vấn
			myRs = myStmt.executeQuery();
			
			// Lấy ra thông tin từ kết quả thực thi của sql
			while(myRs.next()) {
				String fullname = myRs.getString("fullname");
				int phoneNumber = myRs.getInt("phone_number");
				String email = myRs.getString("email");
				
				// Tạo ra đối tượng account để lưu trữ các thông tin thu được
				account = new Account(ID, fullname, phoneNumber, email);
			}
			// Trả về đối tượng là người dùng có id là ID
			return account;
		}
		finally {
			close(myConn, myStmt, myRs);
		}
	}
	
	private void close(Connection myConn, Statement myStmt, ResultSet myRs) {
		try {
			if(myRs != null) {
				myRs.close();
			}
			if(myStmt != null) {
				myStmt.close();
			}
			if(myConn != null) {
				myConn.close();
			}
		}
		catch(Exception exc){
			exc.printStackTrace();
		}
	}
}
