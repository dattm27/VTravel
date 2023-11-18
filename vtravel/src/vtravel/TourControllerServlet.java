package vtravel;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
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
	private TourDbUtil tourDbUtil; // tương tác với cơ sở dữ liệu 
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
		}
		catch (Exception exc) {
				throw new ServletException(exc);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
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
		String startDate = request.getParameter("start_date");
		String endDate = request.getParameter("end_date");
		int numberOfTravellers = Integer.parseInt(request.getParameter("number_of_traveller"));
		String note = request.getParameter("note");
		//tạo đối tượng ProposalCustomTour mới với các thông tin trên
		ProposalCustomTour proposalCustomTour = new ProposalCustomTour(ordererID, destination, startDate, endDate, numberOfTravellers, note, "pending" );
		
		//ghi proposal mới tạo vào cơ sở dữ liệu
		tourDbUtil.addProposalCustomTour(proposalCustomTour);
		
		//thông báo đặt tour thành công
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain;charset=UTF-8");
		
		out.println("Đặt tour thành công");
		out.println(destination);
	}

}
