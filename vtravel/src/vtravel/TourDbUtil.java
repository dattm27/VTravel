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
					+ " from proposal_custom_tour as cus_tour join account on cus_tour.user_id = account.id order by created_date desc";
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
	
	public ProposalCustomTour getProposalCustomTour(int ID) throws SQLException {
		ProposalCustomTour proposal = null;
		Connection myConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		try {
			//thiết lập kết nối cơ sở dữ liệu
			myConn = dataSource.getConnection();
			
			//viết sql 
			String sql = "select * from proposal_custom_tour where ID = ?";
			myStmt = myConn.prepareStatement(sql);
			
			//đặt tham số
			myStmt.setInt(1, ID);
			
			//thực thi truy vấn
			myRs = myStmt.executeQuery();
			
			while (myRs.next()) {
				//lấy ra thông tin từ kết quả và tạo đối tượng ProposalCustomTour
				int ordererID = myRs.getInt("user_id");
				String destination = myRs.getString("destination");
				String startDate = myRs.getString("start_date");
				String endDate = myRs.getString("end_date");
				int numberOfTravellers = myRs.getInt("number_of_travellers");
				String note = myRs.getString("note");
				String status = myRs.getString("status");
				String createdDate = myRs.getString("created_date");
				int price = (int)myRs.getDouble("price");
				//tạo ra một đối tượng ProposalCustomTour
				proposal = 
						new ProposalCustomTour(ID,ordererID,  destination, startDate, endDate, numberOfTravellers, price,  note, status, createdDate);
				
				
			}
			
			return proposal;
		}
		finally {
			close(myConn, myStmt, myRs);
		}
	}
	//khi admin xử lý và chấp nhận một yêu cầu customTour 
	//-> thay đổi thông tin trong cơ sở dữ liệu để trở thành customTour chính thức
	public void acceptCustomTour(ProposalCustomTour customTour) throws SQLException {
		Connection myConn = null;
		PreparedStatement myStmt = null;
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị SQL
			String sql = "update proposal_custom_tour "
					+ "set destination = ?, start_date = ?, end_date = ?, number_of_travellers = ?, note = ? , status = ? , price = ? "
					+ "where id = ?";
			myStmt = myConn.prepareStatement(sql);
			
			//đặt tham số
			myStmt.setString(1, customTour.getDestination());
			myStmt.setString(2, customTour.getStartDate());
			myStmt.setString(3, customTour.getEndDate());
			myStmt.setInt(4, customTour.getNumberOfTravellers());
			myStmt.setString(5, customTour.getNote());
			myStmt.setString(6, customTour.getStatus());
			myStmt.setDouble(7, customTour.getPrice());
			myStmt.setInt(8, customTour.getID());
			
			//thực thi truy vấn
			myStmt.execute();
			
		}
		finally {
			close (myConn, myStmt, null);
		}
		
	}
	
	//cập nhật trạng thái cho một custom tour là đã thanh toán
	public void confirmPurchasedCustomTour(int ID) throws SQLException {
		Connection myConn = null;
		Statement myStmt = null;
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị SQL
			String sql = "update proposal_custom_tour "
					+ "set status = 'Đã thanh toán' "
					+ "where ID = " + ID;
			myStmt = myConn.createStatement();
			
			//thực thi truy vấn
			myStmt.execute(sql);
		}
		finally {
			close (myConn, myStmt, null);
		}
		
	}
	
	public void confirmPurchasedBooking(int ID) throws SQLException {
		Connection myConn = null;
		Statement myStmt = null;
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị SQL
			String sql = "update booking "
					+ "set status = 'Đã thanh toán' "
					+ "where ID = " + ID;
			myStmt = myConn.createStatement();
			
			//thực thi truy vấn
			myStmt.execute(sql);
		}
		finally {
			close (myConn, myStmt, null);
		}
		
	}
	
	//cập nhật trạng thái một custom tour là đã bị huỷ
	public void cancelCustomTour(int ID) throws SQLException{
		Connection myConn = null;
		Statement myStmt = null;
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị SQL
			String sql = "update proposal_custom_tour "
					+ "set status = 'Đã huỷ' "
					+ "where ID = " + ID;
			myStmt = myConn.createStatement();
			
			//thực thi truy vấn
			myStmt.execute(sql);
		}
		finally {
			close (myConn, myStmt, null);
		}
		
	}
	
	//huỷ một booking của tour phổ thông
	public void cancelBooking(int ID) throws SQLException {
		Connection myConn = null;
		Statement myStmt = null;
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị SQL
			String sql = "update booking "
					+ "set status = 'Đã huỷ' "
					+ "where ID = " + ID;
			myStmt = myConn.createStatement();
			
			//thực thi truy vấn
			myStmt.execute(sql);
		}
		finally {
			close (myConn, myStmt, null);
		}
		
	}
	
	// hiển thị tất cả các tour lên tour page
	public List<Tour> getAllTour(boolean limmited) throws SQLException {
		List<Tour> tourList = new ArrayList<>();
		
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị sql
			String sql = "select * from available_tour";
			myStmt = myConn.createStatement();
			
			//thực thi truy vấn
			myRs = myStmt.executeQuery(sql);
			
			while (myRs.next()) {
				int ID = myRs.getInt("id");
				String name = myRs.getString("tour_name");
				String startDate = myRs.getString("start_date");
				String endDate = myRs.getString("end_date");
				int price = myRs.getInt("price");
				String image = myRs.getString("image");
				int booked = myRs.getInt("booked");
				///tao ra mot doi tuong Tour
				Tour tour = new Tour(ID, name, startDate, endDate, price, image, booked);
				//them vao danh sach
				tourList.add(tour);	
				if (limmited ==true && tourList.size() >= 8) break;
			}
				
			return tourList;
		}
		
		finally {
			close(myConn, myStmt, myRs);
		}
	
	}
	public List<Tour> getFitlerTour(String diemmuonden, int orderFeature, int minMoney, 
			 int maxMoney, String date_start) throws SQLException {
		List<Tour> tourList = new ArrayList<>();
		
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		// khoi tao gia tri cho sql
		String minMoneyString = Integer.toString(minMoney);
		String maxMoneyString = Integer.toString(maxMoney);
		String orderFeatureString = "price";
		
		if (orderFeature == 1) {
			
		}
		if (orderFeature == 2) {
			orderFeatureString = "price DESC";
		}
		
		if (orderFeature == 3) {
			orderFeatureString = "start_date";
		}
		
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị sql
			String sql = "SELECT * FROM available_tour where tour_name LIKE \"%" + diemmuonden + "%\""
					+ "and price >= " + minMoneyString + " and price <= " + maxMoneyString + " and start_date >= \""
					+ date_start + "\" " + " ORDER BY " + orderFeatureString;
			myStmt = myConn.createStatement();
			
			//thực thi truy vấn
			myRs = myStmt.executeQuery(sql);
			
			while (myRs.next()) {
				int ID = myRs.getInt("id");
				String name = myRs.getString("tour_name");
				String startDate = myRs.getString("start_date");
				String endDate = myRs.getString("end_date");
				int price = myRs.getInt("price");
				String image = myRs.getString("image");
				int booked = myRs.getInt("booked");
				
				///tao ra mot doi tuong Tour
				Tour tour = new Tour(ID, name, startDate, endDate, price, image, booked);
				//them vao danh sach
				tourList.add(tour);	
			}
				
			return tourList;
		}
		
		finally {
			close(myConn, myStmt, myRs);
		}
	
	}
	
	public Tour getDetailTour(int ID) throws SQLException {
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị sql 
			String sql = "select * from available_tour where ID = " + ID;
			myStmt = myConn.createStatement();
			//execute query
			myRs = myStmt.executeQuery(sql);
			
			while (myRs.next()) {
				String name = myRs.getString("tour_name");
				String startDate = myRs.getString("start_date");
				String endDate = myRs.getString("end_date");
				int price = myRs.getInt("price");
				int maxNumOfTourists = myRs.getInt("max_number_tourist");
				String startPlace = myRs.getString("start_place");
				String description = myRs.getString("description");
				String image =  myRs.getString("image");
				int booked  = myRs.getInt("booked");
				//tạo ra đối tượng tour mưới
				Tour tour = new Tour(ID, name,  startDate,  endDate,  description, price,  startPlace, image, booked);
				return tour;
			}
		}
		finally {
			close(myConn, myStmt, myRs);
		}
		return null;
	}

	public void updateTourDetail(Tour tour) throws SQLException {
		Connection myConn = null;
		PreparedStatement myStmt = null;
	
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị sql
			String sql = "update available_tour "
					+ "set tour_name = ?, start_date = ?, end_date = ?, description = ?, price = ?, start_place = ?, image = ? "
					+ "where id = ? " ;
			myStmt = myConn.prepareStatement(sql);
			
			//set tham số
			myStmt.setString(1, tour.getName());
			myStmt.setString(2, tour.getStartDate());
			myStmt.setString(3, tour.getEndDate());
			myStmt.setString(4, tour.getDescription());
			myStmt.setInt(5, tour.getPrice());
			myStmt.setString(6, tour.getStartPlace());
			myStmt.setString(7, tour.getImage());
			myStmt.setInt(8, tour.getID());
			
			//execute
			myStmt.execute();
		}
		finally {
			close (myConn, myStmt, null );
		}
		
	}
	
	//thêm đơn đặt tour phổ thông vào cơ sở dữ liệu
	public void addBooking(Booking booking) throws SQLException {
		Connection myConn = null;
		PreparedStatement myStmt = null;
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị sql 
			String sql = "insert into booking(user_id, tour_id, number_tourist, note) "
					+ " values (? , ? , ?, ?) ";
			myStmt = myConn.prepareStatement(sql);
			
			//đặt tham số
			myStmt.setInt(1, booking.getUserID());
			myStmt.setInt(2, booking.getTourID());
			myStmt.setInt(3, booking.getNumberOfTourists());
			myStmt.setString(4, booking.getNote());
			
			//execute
			myStmt.execute();
			
		}
		finally {
			close (myConn, myStmt, null);
		}
		
	}
	
	// Trả về danh sách booking của một tour theo ID cho admin
	public List<Booking> getBookingOfTour(int tourID) throws SQLException {
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		List<Booking> bookingList = new ArrayList<>();
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị sql 
			String sql = "select user_id, tour_id, number_tourist, note, booking.id, fullname, booking.status, created_date, phone_number "
					+ "from booking join account on booking.user_id = account.id "
					+ "where booking.tour_id = " + tourID;
			myStmt = myConn.createStatement();
			
			//execute
			myRs = myStmt.executeQuery(sql);
			
			while (myRs.next()) {
				int ID = myRs.getInt("id");
				int userID = myRs.getInt("user_id");
				int numberOfTourists = myRs.getInt("number_tourist");
				String note = myRs.getString("note");
				String userFullname = myRs.getString("fullname");
				String status = myRs.getString("status");
				String createdDate = myRs.getString("created_date");
				String userPhoneNumber = myRs.getString("phone_number");
				Booking booking = new Booking(ID, userID, tourID, numberOfTourists, note, userFullname, status, createdDate, userPhoneNumber);
				bookingList.add(booking);
			}
			
			return bookingList;
		}
		finally {
			close (myConn, myStmt, null );
		}
	
	}
	/// lay ra danh sach booking cua 1 nguoi
	public ArrayList<Booking> getPersonalBooking(int user_ID, String sxtype) throws SQLException {
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		ArrayList<Booking> bookingList = new ArrayList<>();
		try {
			//thiết lập kết nối
			myConn = dataSource.getConnection();
			
			//chuẩn bị sql 
			String sql = "select user_id, booking.tour_id, booking.number_tourist, note, booking.id, booking.status, created_date "
					+ "from booking join available_tour on booking.tour_id = available_tour.id "
					+ "where booking.user_id = " + user_ID + " and booking.status like \"%" + sxtype + "%\"" 
				    + " order by " + "created_date";
			//System.out.println(sql);
			myStmt = myConn.createStatement();			
			//execute
			myRs = myStmt.executeQuery(sql);
			
			while (myRs.next()) {
				int ID = myRs.getInt("id");
				int userID = myRs.getInt("user_id");
				int tourID = myRs.getInt("tour_id");
				int numberOfTourists = myRs.getInt("number_tourist");
				String note = myRs.getString("note");
				//String userFullname = myRs.getString("");
				String status = myRs.getString("status");
				String createdDate = myRs.getString("created_date");
				//String userPhoneNumber = myRs.getString("phone_number");
				Booking booking = new Booking(ID, userID, tourID, numberOfTourists, note, "", status, createdDate, "");
				bookingList.add(booking);
			}
			
			return bookingList;
		}
		finally {
			close (myConn, myStmt, null );
		}
	
	}
	// admin thêm tour phổ thông mới 
	public void addTour(Tour tour) {
		Connection myConn = null;
		PreparedStatement myStmt = null;
		
		
		try {
			// get connection to db
			myConn = dataSource.getConnection();
			
			//create sql for insert
			String sql = "insert into available_tour(tour_name, price, start_date, end_date, start_place, image, description) "
					+ "values (?, ? , ?, ?, ?, ?,?) ";
			myStmt = myConn.prepareStatement(sql);
			
			//set params
			myStmt.setString(1, tour.getName());
			myStmt.setInt(2, tour.getPrice());
			myStmt.setString(3, tour.getStartDate());
			myStmt.setString(4, tour.getEndDate());
			myStmt.setString(5,tour.getStartPlace());
			myStmt.setString(6, tour.getImage());
			myStmt.setString(7, tour.getDescription());

			//execute the sql
			myStmt.execute();
			
		}
		catch (Exception exc){
			exc.printStackTrace();
		}
		finally {
			//close the JDBC objects
			close(myConn, myStmt, null);
		}
		
	}
	//xoá mộtt tour phổ thông
	public void deleteTour(int ID) {
		Connection myConn = null;
		Statement myStmt = null;
		
		
		try {
			// get connection to db
			myConn = dataSource.getConnection();
			
			//create sql for insert
			String sql = "delete from available_tour where id = " + ID;
			myStmt = myConn.createStatement();
		

			//execute the sql
			myStmt.execute(sql);
			
		}
		catch (Exception exc){
			exc.printStackTrace();
		}
		finally {
			//close the JDBC objects
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
