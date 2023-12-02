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



/**
 * Servlet implementation class TourControllerServlet
 */
@WebServlet("/TourControllerServlet")
public class TourControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TourDbUtil tourDbUtil; // tương tác với cơ sở dữ liệu về tour
	private AccountDbUtil accountDbUtil; // tương tác với cơ sở dữ liệu về tài khoản
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
			// xử lý yêu cầu đặt custom tour
			case "REQUEST_CUSTOM_TOUR":	
				save_proposal_custom_tour(request, response);
			default:
				break;
			}
		}
		catch (Exception exc) {
			throw new ServletException( exc);
		}
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
