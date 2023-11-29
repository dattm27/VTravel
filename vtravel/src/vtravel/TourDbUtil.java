package vtravel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

public class TourDbUtil {

	private DataSource dataSource;

	public TourDbUtil(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	
	//thêm ProposalCustomTour là yêu cầu đặt custom tour của khách đặt vào cơ sở dữ liệu
	public void addProposalCustomTour(ProposalCustomTour proposalCustomTour) throws SQLException {
		Connection myConn = null;
		PreparedStatement myStmt = null;
		
		
		try {
			//thiết lập kết nối cơ sở dữ liệu
			myConn = dataSource.getConnection();
			
			//chuẩn bị SQL
			String sql = "insert into proposal_custom_tour(user_id, destination, start_date, end_date, number_of_travellers, note, status, created_date)"
					+ " values (? , ? , ?, ? , ?, ?, ?, ?) ";
			
			myStmt = myConn.prepareStatement(sql);
			
			// đặt tham số
			myStmt.setInt(1, proposalCustomTour.getOrdererID());
			myStmt.setString(2, proposalCustomTour.getDestination());
			myStmt.setString(3, proposalCustomTour.getStartDate());
			myStmt.setString(4, proposalCustomTour.getEndDate() );
			myStmt.setInt(5, proposalCustomTour.getNumberOfTravellers());
			myStmt.setString(6, proposalCustomTour.getNote());
			myStmt.setString(7, proposalCustomTour.getStatus());
			myStmt.setString(8,proposalCustomTour.getCreatedDate());
			//thực thi truy vấn
			myStmt.execute();
			
		}
		finally {
			close(myConn, myStmt, null);
		}
		
		
	}
	// lấy ra danh sách tất cả các đơn đặt custom tour của khách
	public List<ProposalCustomTour> getAllProposalCustomTour() throws SQLException{
		List<ProposalCustomTour> proposalList = new ArrayList<>();
		
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		
		try {
			//thiết lập kết nối cơ sở dữ liệu
			myConn = dataSource.getConnection();
			
			//viết sql
			String sql = "select cus_tour.id, user_id ,fullname, destination, start_date, end_date,"
					+ " number_of_travellers, note, cus_tour.status, created_date"
					+ " from proposal_custom_tour as cus_tour join account on cus_tour.user_id = account.id";
			myStmt = myConn.createStatement();
			
			//thực thi truy vấn 
			myRs =  myStmt.executeQuery(sql);
			
			//xử lý bộ kết quả
			while (myRs.next()) {
				//lấy ra nội dung các trường trong từng bản ghi
				int ID = myRs.getInt("id");
				int ordererID = myRs.getInt("user_id");
				String ordererFullname = myRs.getString("fullname");
				String destination = myRs.getString("destination");
				String startDate = myRs.getString("start_date");
				String endDate = myRs.getString("end_date");
				int numberOfTravellers = myRs.getInt("number_of_travellers");
				String note = myRs.getString("note");
				String status = myRs.getString("status");
				String createdDate = myRs.getString("created_date");
				
				//tạo ra một đối tượng ProposalCustomTour
				ProposalCustomTour proposalCustomTour = 
						new ProposalCustomTour(ID, ordererID, ordererFullname, destination, startDate, endDate, numberOfTravellers, note, status, createdDate);
				
				//thêm đối tượng vào danh sách 
				proposalList.add(proposalCustomTour);
			}
			//trả về danh sách tất cả các đơn customTour
			return proposalList;
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
