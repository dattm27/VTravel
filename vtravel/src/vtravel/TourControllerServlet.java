package vtravel;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;



import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 * Servlet implementation class TourControllerServlet
 */
@WebServlet("/TourControllerServlet")
// Khắc phục không sử dụng được getParamter khi gửi form dưới dạng multipart/form-data
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50) // 50MB
public class TourControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TourDbUtil tourDbUtil; // tương tác với cơ sở dữ liệu về tour
	private AccountDbUtil accountDbUtil; // tương tác với cơ sở dữ liệu về tài khoản
	private static final Logger logger = Logger.getLogger(TourControllerServlet.class.getName());
	// Define datasource/ connection pool for Resource Jnjection
	@Resource(name = "jdbc/web_travel_booking")
	private DataSource dataSource;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TourControllerServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		try {
			tourDbUtil = new TourDbUtil(dataSource);
			accountDbUtil = new AccountDbUtil(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		try {
			String theCommand = request.getParameter("command");
			switch (theCommand) {
			// lấy danh sách tất cả các yêu cầu đặt custom tour (proposal) lên trang quản lý
			// của admin
			case "LIST_ALL_CUSTOM_TOUR_REQUEST":
				listProposalCustomTour(request, response);
				break;
			//tải danh sách các tour lên trang quản lý của admin
			case "TOURS_MANAGEMENT":
				listAllTourAdmin(request, response);
				break;
			case "BOOKING_LIST_OF_A_TOUR":
				listBookingOfTour(request, response);
				break;
			// khi admin bấm vào chi tiết một proposal
			case "DETAIL_PROPOSAL":
				getDetailProposal(request, response);
				break;
			//khi admin muốn tạo một tour phổ thông mới
			case "CREATE_NEW_TOUR":
				createNewTour(request, response);
				break;
			// hiển thị chi tiết về tour trong danh sách và cho phép admin chỉnh sửa thông tin				
			case "DETAIL_AND_UPDATE_TOUR":
				detailAndUpdateTour(request, response);
				break;
			// lấy danh sách tất cả các tour phổ thông hiển thị lên trang tour
			case "LIST_ALL_TOURS":
				listAllTours(request, response);
				break;
			case "LIST_HOT_TOURS":
				listHotTours(request, response);
				break;
			//xem trang thông tin chi tiết của một tour 
			case "DETAIL_TOUR_PAGE":
				detailTourPage(request, response);
				break;
			// khi người dùng ấn vào đặt vé -> Tạo form đặt chuyến cho người dùng nhâp thông tin
			case "CREATE_BOOKING_FORM":
				createBooking(request, response);	
				break;
			default:
				break;
			}
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}

	private void listBookingOfTour(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		// lấy ID của tour cần hiẻn thị danh sách khách đặt
		int tourID = Integer.parseInt(request.getParameter("tourID"));
		
		//lấy danh sách khách đặt của tour đó
		List<Booking> bookingList = tourDbUtil.getBookingOfTour(tourID);
		Tour tour = tourDbUtil.getDetailTour(tourID);
		//thêm vào request
		request.setAttribute("BOOKING_LIST", bookingList);
		request.setAttribute("tour", tour);
		//gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/booking_list.jsp");
		dispatcher.forward(request, response);
		logger.info("TourControllerServlet list Bookings of tour" + tourID);
		
	}

	private void createBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		//lấy ID tour và ID user
		int tourID = Integer.parseInt(request.getParameter("tourID"));
		if (request.getParameter("userID")=="") {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
			dispatcher.forward(request, response);
		}
		else {
			int userID = Integer.parseInt(request.getParameter("userID"));
			
			
			
			//lấy ra thông tin đối tượng tour và user tương ứng với ID vừa lấy được
			Account user = accountDbUtil.getAccountInf(userID);
			Tour tour = tourDbUtil.getDetailTour(tourID);
			
			//thêm vào request
			request.setAttribute("tour", tour);
			request.setAttribute("user", user);
			
			//Gửi đến JSP
			RequestDispatcher dispatcher = request.getRequestDispatcher("/confirm_tour_booking.jsp");
			dispatcher.forward(request, response);
		}
		
	}

	private void createNewTour(HttpServletRequest request, HttpServletResponse response) {
		
		
	}

	private void detailAndUpdateTour(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		
		// lấy ID từ tour được chọn
		int ID =  Integer.parseInt(request.getParameter("ID"));
		logger.info("TourControllerServlet detail tour" + ID);
		//Lấy tour từ ID
		Tour tour = tourDbUtil.getDetailTour(ID);
		//thêm vào request
		request.setAttribute("tour", tour);
		//Gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/update_detail_tour.jsp");
		dispatcher.forward(request, response);
		
		
		
	}

	private void detailTourPage(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		//lấy ID gửi từ yêu cầu
		int ID = Integer.parseInt(request.getParameter("ID"));
		//Lấy tour từ ID
		Tour tour = tourDbUtil.getDetailTour(ID);
		//thêm vào request
		request.setAttribute("tour", tour);
		//Gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/detail_tour_page.jsp");
		dispatcher.forward(request, response);
	}

	private void listAllTourAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		//lấy danh sách các tour từ cơ sở dữ liệu
		List<Tour> tourList = tourDbUtil.getAllTour(false);
		
		// them danh sach vua lay duoc vao request
		request.setAttribute("TOUR_LIST", tourList);
		
		// gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/tours_management.jsp");
		dispatcher.forward(request, response);
	}

	// lấy tất cả các tours từ cơ sở dữ liệu hiển thị lên trang tour
	private void listAllTours(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		// lay du lieu tu bo loc
		String diemmuonden = request.getParameter("diemmuonden");
		if (diemmuonden == null || diemmuonden == "")
			diemmuonden = "";

		String ngaybatdau = request.getParameter("ngay_bat_dau");
		if (ngaybatdau == null || ngaybatdau == "")
			ngaybatdau = "1-01-01";

		String giamongmuonString = request.getParameter("gia_mong_muon");
		int minMoney = 0;
		int maxMoney = 1000000000;
		int wantPrice;

		if (giamongmuonString == null || giamongmuonString == "")
			giamongmuonString = "0";
		else {
			wantPrice = Integer.parseInt(giamongmuonString);
			minMoney = Math.max(0, wantPrice - 1000000);
			maxMoney = wantPrice + 1000000;
		}
		String orderFeature = request.getParameter("kieu_sap_xep");

		int kieusapxep = 1;
		if (orderFeature != null) {
			if (orderFeature.equals("1"))
				kieusapxep = 1;
			if (orderFeature.equals("2"))
				kieusapxep = 2;
			if (orderFeature.equals("3"))
				kieusapxep = 3;
		}

		// lay danh sach tour tu co so du lieu
		List<Tour> tourList = tourDbUtil.getFitlerTour(diemmuonden, kieusapxep, minMoney, maxMoney, ngaybatdau);

		// them danh sach vua lay duoc vao request
		request.setAttribute("TOUR_LIST", tourList);

		// gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/tours_page.jsp");
		dispatcher.forward(request, response);

	}

	// lấy 8 tour từ cơ sở dữ liệu hiển thị lên trang chủ
	private void listHotTours(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		// lay danh sach tour tu co so du lieu
		List<Tour> tourList = tourDbUtil.getAllTour(true);

		// them danh sach vua lay duoc vao request
		request.setAttribute("TOUR_LIST", tourList);

		// gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
	}

	private void getDetailProposal(HttpServletRequest request, HttpServletResponse response) {
		// lấy ID người dùng gửi yêu cầu
		int ordererID = Integer.parseInt(request.getParameter("ordererID"));

		// lấy ID Proposal Custom Tour
		int ID = Integer.parseInt(request.getParameter("ID"));

		// lấy thông tin người dùng có ordererID
		try {
			Account orderer = accountDbUtil.getAccountInf(ordererID);
			ProposalCustomTour proposal = tourDbUtil.getProposalCustomTour(ID);
			request.setAttribute("ORDERER", orderer);
			request.setAttribute("PROPOSAL", proposal);

			// gửi đến JSP
			RequestDispatcher dispatcher = request.getRequestDispatcher("/detail_and_response_proposal.jsp");
			dispatcher.forward(request, response);

		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	private void listProposalCustomTour(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		// tạo danh sách các ProposalCustomTour lấy được từ cơ sở dữ liệu
		List<ProposalCustomTour> proposalList = tourDbUtil.getAllProposalCustomTour();

		// thêm danh sách vừa tạo vào request
		request.setAttribute("PROPOSAL_LIST", proposalList);

		// gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/custom_tour_management.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		request.setCharacterEncoding("UTF-8");
		try {
			String theCommand = request.getParameter("command");
			switch (theCommand) {
			// xử lý yêu cầu đặt custom tour mà khách gửi
			case "REQUEST_CUSTOM_TOUR":
				save_proposal_custom_tour(request, response);
				break;
			// admin sắp xếp, phản hồi lại yêu cầu đặt tour của khách
			case "REPONSE_TO_PROPOSAL":
				accept_custom_tour(request, response);
				break;
			// khi admin xác nhận một đơn custom tour đã được thanh toán
			case "PURCHASED_CUSTOM_TOUR":
				purchased_custom_tour(request, response);
				break;
			case "CANCEL_CUSTOM_TOUR":
				cancel_custom_tour(request, response);
				break;
			case "UPDATE_DETAIL_TOUR":
				updateDetailTour(request, response);
				break;
			// Khi người dùng gửi form đặt tour phổ thông
			case "BOOKING":
				bookingTour(request, response);
				break;
			// khi admin xác nhận một đơn tour phổ thông đã được thanh toán
			case "PURCHASED_BOOKING":
				purchased_booking(request, response);
				break;
			//huỷ booking của một tour phổ thông
			case "CANCEL_BOOKING":
				cancel_booking(request, response);
				break;
			default:
				break;
			}
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}
	//huỷ booking của một tour phổ thông
	private void cancel_booking(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		// lấy ID của proposal custom tour cần huỷ
		int ID = Integer.parseInt(request.getParameter("ID"));
		tourDbUtil.cancelBooking(ID);
		logger.info("Cancelled booking" + ID);
		
	}

	//xác nhận khách đã thanh toán một tour phổ thông 
	private void purchased_booking(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		// lấy ID tour được thanh toán
		int ID = Integer.parseInt(request.getParameter("ID"));
		tourDbUtil.confirmPurchasedBooking(ID);
		logger.info("Purchased booking" + ID);
		
	}

	private void bookingTour(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		//lấy thông tin đặt tour từ form
		int userID = Integer.parseInt(request.getParameter("userID"));
		int tourID = Integer.parseInt(request.getParameter("tourID"));
		int numberOfTourists = Integer.parseInt(request.getParameter("number_of_tourists"));
		String note = request.getParameter("pick_up_location");
		
		//tạo đối tượng booking mới
		Booking booking = new Booking(userID, tourID, numberOfTourists, note);
		
		//thêm đơn booking vào cơ sở dữ liệu
		tourDbUtil.addBooking(booking);
		
		// gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/booking_successfully.jsp");
		dispatcher.forward(request, response);
		
	}

	private void updateDetailTour(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, Exception {
		
		PrintWriter out = response.getWriter();
		//lấy các thông tin từ form ra
		int ID = Integer.parseInt(getValue(request.getPart("id")));
		logger.info("TourControllerServlet update tour" + ID );
		String name = getValue(request.getPart("name"));
	    String price = getValue(request.getPart("price"));
	    String startDate = getValue(request.getPart("start_date"));
	    String endDate = getValue(request.getPart("end_date"));
	    String startPlace = getValue(request.getPart("start_place"));
	   out.print(name);
	    //Xử lý phần ảnh
	    Part filePart = request.getPart("image");
	    String uniqueFileName = null;
	    //Kiểm tra nếu người dùng có nhập ảnh mới
	    if (filePart != null && filePart.getSize() > 0) {
	        String fileName = filePart.getSubmittedFileName();
		    
		    //Tạo tên độc nhất cho file ảnh, tránh trúng lặp
	        uniqueFileName = "images/tour/" + UUID.randomUUID().toString() + "_" + fileName;

		    String appPath = request.getServletContext().getRealPath("");
		   
		    
		    String imagePath = appPath +  uniqueFileName;
		    out.print(imagePath);
		    //Ghi file ảnh vào thư mục 
		    filePart.write(imagePath);
	    
		    //xoá file ảnh cũ
		    String oldImage = getValue(request.getPart("oldImage"));
		    imagePath =  appPath + oldImage;
		    
		    out.print("Old file: \n"+ imagePath);
		    File oldImageFile = new File(imagePath);
		    
		    // kiểm tra nếu file đó có tồn tại trong kho thì xoá đi
		    if ( oldImage.length() > 0  && oldImageFile.exists()  ) {
		    	out.print("Old file existed");
		    	//oldImageFile.delete();
		    }
		    else out.print("Old file not found");
		    
	    }
	    
	    else {
	    	// nếu người dùng không cập nhật ảnh mới, tên file ảnh cũ giữ nguyên
	    	String oldImage = getValue(request.getPart("oldImage"));
	    	if (oldImage.length()==0)   uniqueFileName = ""; // chứng tỏ chưa có ảnh cũ
	    	else uniqueFileName = oldImage;
	    	out.print("Image path: " + uniqueFileName);
	    }
	    
	    
	    // Mô tả chi tiết
	    String description = getValue(request.getPart("description"));
		
	    // Tạo tour object
	    //Trip theTrip = new Trip(id, name, Integer.parseInt(price), start_date, end_date, description, address, "images/" + uniqueFileName);
	    Tour tour = new Tour(ID, name,  startDate,  endDate,  description, Integer.parseInt(price),  startPlace,   uniqueFileName);
	    
	    // thêm tour vào cơ sở dữ liệu
	    try {
	    	tourDbUtil.updateTourDetail(tour);
	    	request.setAttribute("tour", tour);
	    	request.setAttribute("message", "update_OK");
	    	RequestDispatcher dispatcher = request.getRequestDispatcher("/update_detail_tour.jsp");
			dispatcher.forward(request, response);
	    }
	    
	    catch (Exception exc) {
	    	exc.printStackTrace();
	    }
	
		
	}

	private void cancel_custom_tour(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		// lấy ID của proposal custom tour cần huỷ
		int ID = Integer.parseInt(request.getParameter("ID"));
		tourDbUtil.cancelCustomTour(ID);
		logger.info("Cancelled custom tour" + ID);
	}

	// cập nhật trạng thái custom Tour thành đã được thanh toán
	private void purchased_custom_tour(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// lấy ID tour được thanh toán
		int ID = Integer.parseInt(request.getParameter("ID"));
		tourDbUtil.confirmPurchasedCustomTour(ID);
		logger.info("Purchased custom tour" + ID);
	}

	// admin xử lý yêu cầu đặt custom tour, sắp xếp, chỉnh sửa lại proposal và lưu
	// thông tin custom tour chính thức
	private void accept_custom_tour(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// lấy thông tin từ form xử lý custom tour của admin
		int ID = Integer.parseInt(request.getParameter("ID"));
		String destination = request.getParameter("destination");
		String startDate = request.getParameter("start_date");
		String endDate = request.getParameter("end_date");
		int numberOfTravellers = Integer.parseInt(request.getParameter("number_of_traveller"));
		int price = Integer.parseInt(request.getParameter("price"));
		String description = request.getParameter("description");
		String createdDate = request.getParameter("created_date");
		// tạo ra đối tượng customTour (ProposalCustomTour sau khi được xử lý)
		ProposalCustomTour customTour = new ProposalCustomTour(ID, destination, startDate, endDate, numberOfTravellers,
				price, description, "Chờ thanh toán", createdDate);
		// thay đổi thông tin vào cơ sở dữ liệu
		tourDbUtil.acceptCustomTour(customTour);
		
		PrintWriter out = response.getWriter();
//		response.setContentType("text/plain;charset=UTF-8");
//		out.println(ID);
//		out.println(destination);
//		out.println(startDate);
//		out.println(endDate);
//		out.println(customTour.getNumberOfTravellers());
//		out.println(customTour.getPrice();
//		out.println(customTour.getNote());
//		out.println(customTour.getStatus());
//		out.close();
		//thêm tour và thông điệp phản hồi
		
		request.setAttribute("PROPOSAL", customTour);
		//lấy ra đối tượng người đặt custom tour
		Account orderer = accountDbUtil.getAccountInf(Integer.parseInt(request.getParameter("userID")));
		request.setAttribute("ORDERER",orderer );
		request.setAttribute("Message", "update_OK");
		// gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/detail_and_response_proposal.jsp");
		dispatcher.forward(request, response);
	}

	// lưu đơn đặt custom tour vào cơ sở dữ liệu
	private void save_proposal_custom_tour(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// lấy các thông tin từ form đặt custom tour
		int ordererID = Integer.parseInt(request.getParameter("userID"));
		String destination = request.getParameter("destination");
		String otherDestination = request.getParameter("otherDestination");
		// nếu như nhập địa điểm khác thì gán lại destination thành địa điểm khác
		if (otherDestination != "")
			destination = otherDestination;
		String startDate = request.getParameter("start_date");
		String endDate = request.getParameter("end_date");
		int numberOfTravellers = Integer.parseInt(request.getParameter("number_of_traveller"));
		String note = request.getParameter("note");

		// tạo thời điểm tạo đơn đặt custom tour
		// Tạo đối tượng Date đại diện cho thời điểm hiện tại
		Date currentDate = new Date();

		// Định dạng chuỗi theo yêu cầu (yyyy-MM-dd HH:mm:ss)
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		// Chuyển đối tượng Date thành chuỗi
		String formattedDate = dateFormat.format(currentDate);

		// tạo đối tượng ProposalCustomTour mới với các thông tin trên
		ProposalCustomTour proposalCustomTour = new ProposalCustomTour(ordererID, destination, startDate, endDate,
				numberOfTravellers, note, "Đang chờ", formattedDate);

		// ghi proposal mới tạo vào cơ sở dữ liệu
		tourDbUtil.addProposalCustomTour(proposalCustomTour);

		// thông báo đặt tour thành công
//		PrintWriter out = response.getWriter();
//		response.setContentType("text/plain;charset=UTF-8");
//
//		out.println("Đặt tour thành công");
//		out.println(destination);
		response.sendRedirect("WelcomeControllerServlet"); 
	}
	
	//lấy giá trị từ các Part trong form được gửi ở dạng multipart/form-data
	String getValue(Part namePart)  throws Exception  {
			
			String value = null;  
			if (namePart != null) {
			        value = new BufferedReader(new InputStreamReader(namePart.getInputStream()))
			                .lines().collect(Collectors.joining());
			}
			return value ;
		}

}
