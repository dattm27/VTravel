package vtravel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

public class TourDbUtil {

	private DataSource dataSource;

	public TourDbUtil(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	
	public void addProposalCustomTour(ProposalCustomTour proposalCustomTour) throws SQLException {
		Connection myConn = null;
		PreparedStatement myStmt = null;
		
		
		try {
			//thiết lập kết nối cơ sở dữ liệu
			myConn = dataSource.getConnection();
			
			//chuẩn bị SQL
			String sql = "insert into proposal_custom_tour(user_id, destination, start_date, end_date, number_of_travellers, note, status)"
					+ " values (? , ? , ?, ? , ?, ?, ?) ";
			
			myStmt = myConn.prepareStatement(sql);
			
			// đặt tham số
			myStmt.setInt(1, proposalCustomTour.getOrdererID());
			myStmt.setString(2, proposalCustomTour.getDestination());
			myStmt.setString(3, proposalCustomTour.getStartDate());
			myStmt.setString(4, proposalCustomTour.getEndDate() );
			myStmt.setInt(5, proposalCustomTour.getNumberOfTravellers());
			myStmt.setString(6, proposalCustomTour.getNote());
			myStmt.setString(7, proposalCustomTour.getStatus());
			
			//thực thi truy vấn
			myStmt.execute();
			
		}
		finally {
			close(myConn, myStmt, null);
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
