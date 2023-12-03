package vtravel;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.util.logging.Logger;


/**
 * Servlet implementation class TourControllerServlet
 */
@WebServlet("/TourControllerServlet")
public class TourControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TourDbUtil tourDbUtil; // tương tác với cơ sở dữ liệu về tour
	private AccountDbUtil accountDbUtil; // tương tác với cơ sở dữ liệu về tài khoản
	private static final Logger logger = Logger.getLogger(TourControllerServlet.class.getName());
	//Define datasource/ connection pool for Resource Jnjection
	@Resource(name="jdbc/web_travel_booking")
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
		}
		catch (Exception exc) {
				throw new ServletException(exc);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		try {
			String theCommand = request.getParameter("command");
			switch(theCommand) {
			//lấy danh sách tất cả các yêu cầu đặt custom tour (proposal) lên trang quản lý của admin
			case "LIST_ALL_CUSTOM_TOUR_REQUEST":
				listProposalCustomTour(request, response);
				break;
			// khi admin bấm vào chi tiết một proposal
			case "DETAIL_PROPOSAL":
				getDetailProposal(request, response);
				break;
			default:
				break;
			}
		} catch(Exception exc) {
			throw new ServletException(exc);
		}
	}


	private void getDetailProposal(HttpServletRequest request, HttpServletResponse response) {
		//lấy ID người dùng gửi yêu cầu
		int ordererID = Integer.parseInt(request.getParameter("ordererID"));
		
		//lấy ID Proposal Custom Tour
		int ID = Integer.parseInt(request.getParameter("ID"));
		
		//lấy thông tin người dùng có ordererID
		try {
			Account orderer = accountDbUtil.getGeneralInformation(ordererID);
			ProposalCustomTour proposal = tourDbUtil.getProposalCustomTour(ID);
			request.setAttribute("ORDERER", orderer);
			request.setAttribute("PROPOSAL", proposal);
			
			//gửi đến JSP
			RequestDispatcher dispatcher = request.getRequestDispatcher("/detail_and_response_proposal.jsp");
			dispatcher.forward(request, response);
			
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	private void listProposalCustomTour(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		//tạo danh sách các ProposalCustomTour lấy được từ cơ sở dữ liệu
		List<ProposalCustomTour> proposalList = tourDbUtil.getAllProposalCustomTour();
		
		//thêm danh sách vừa tạo vào request
		request.setAttribute("PROPOSAL_LIST", proposalList);
		
		//gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/custom_tour_management.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		try {
			String theCommand = request.getParameter("command");
			switch (theCommand) {
			// xử lý yêu cầu đặt custom tour mà khách gửi
			case "REQUEST_CUSTOM_TOUR":	
				save_proposal_custom_tour(request, response);
				break;
			//admin sắp xếp, phản hồi lại yêu cầu đặt tour của khách
			case "REPONSE_TO_PROPOSAL":
				accept_custom_tour(request, response);
				break;
			//khi admin xác nhận một đơn custom tour đã được thanh toán
			case "PURCHASED_CUSTOM_TOUR":
				purchased_custom_tour(request, response);
				break;
			case "CANCEL_CUSTOM_TOUR":
				cancel_custom_tour(request, response);
				break;
			default:
				break;
			}
		}
		catch (Exception exc) {
			throw new ServletException( exc);
		}
	}
	
	private void cancel_custom_tour(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		//lấy ID của proposal custom tour cần huỷ
		int ID = Integer.parseInt(request.getParameter("ID"));
		tourDbUtil.cancelCustomTour(ID);
		logger.info("Cancelled tour" + ID);
	}

	//cập nhật trạng thái custom Tour thành đã được thanh toán
	private void purchased_custom_tour(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//lấy ID tour được thanh toán
		int ID = Integer.parseInt(request.getParameter("ID"));
		tourDbUtil.confirmPurchasedCustomTour(ID);
		logger.info("Purchased tour" + ID);
	}

	//admin xử lý yêu cầu đặt custom tour, sắp xếp, chỉnh sửa lại proposal và lưu thông tin custom tour chính thức
	private void accept_custom_tour(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//lấy thông tin từ form xử lý custom tour của admin 
		int ID = Integer.parseInt(request.getParameter("ID"));
		String destination =  request.getParameter("destination");
		String startDate = request.getParameter("start_date");
		String endDate = request.getParameter("end_date");
		int numberOfTravellers = Integer.parseInt(request.getParameter("number_of_traveller"));
		double price = Integer.parseInt(request.getParameter("price"));
		String description = request.getParameter("description");
		
		//tạo ra đối tượng customTour (ProposalCustomTour sau khi được xử lý)
		ProposalCustomTour customTour = new ProposalCustomTour(ID, destination, startDate, endDate, numberOfTravellers, price, description, "Chờ thanh toán");
		//thay đổi thông tin vào cơ sở dữ liệu
		tourDbUtil.acceptCustomTour(customTour);
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain;charset=UTF-8");
		out.println(ID);
		out.println(destination);
		out.println(startDate);
		out.println(endDate);
		out.println(customTour.getNumberOfTravellers());
		out.println(customTour.getPrice());
		out.println(customTour.getNote());
		out.println(customTour.getStatus());
		out.close();
		//gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/custom_tour_management.jsp");
		dispatcher.forward(request, response);
	}

	//lưu đơn đặt custom tour vào cơ sở dữ liệu
	private void save_proposal_custom_tour(HttpServletRequest request, HttpServletResponse response) throws Exception{
		//lấy các thông tin từ form đặt custom tour
		int ordererID = Integer.parseInt(request.getParameter("userID"));
		String destination =  request.getParameter("destination");
		String otherDestination = request.getParameter("otherDestination");
		//nếu như nhập địa điểm khác thì gán lại destination thành địa điểm khác 
		if(otherDestination != "") destination = otherDestination;
		String startDate = request.getParameter("start_date");
		String endDate = request.getParameter("end_date");
		int numberOfTravellers = Integer.parseInt(request.getParameter("number_of_traveller"));
		String note = request.getParameter("note");
		
		//tạo thời điểm tạo đơn đặt custom tour
		// Tạo đối tượng Date đại diện cho thời điểm hiện tại
        Date currentDate = new Date();

        // Định dạng chuỗi theo yêu cầu (yyyy-MM-dd HH:mm:ss)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        // Chuyển đối tượng Date thành chuỗi
        String formattedDate = dateFormat.format(currentDate);
		
		//tạo đối tượng ProposalCustomTour mới với các thông tin trên
		ProposalCustomTour proposalCustomTour = new ProposalCustomTour(ordererID, destination, startDate, endDate, numberOfTravellers, note, "Đang chờ" , formattedDate);
		
		//ghi proposal mới tạo vào cơ sở dữ liệu
		tourDbUtil.addProposalCustomTour(proposalCustomTour);
		
		//thông báo đặt tour thành công
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain;charset=UTF-8");
		
		out.println("Đặt tour thành công");
		out.println(destination);
	}

}
