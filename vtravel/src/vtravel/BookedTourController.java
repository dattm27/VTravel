package vtravel;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import vtravel.Booking;
import vtravel.TourControllerServlet;


/**
 * Servlet implementation class BookedTourController
 */
@WebServlet(urlPatterns = {"/BookedTour"})
public class BookedTourController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public BookedTourController() {
        super();
    }
	@Resource(name = "jdbc/web_travel_booking")
	private DataSource dataSource;
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int user_id = Integer.parseInt(req.getParameter("ID"));
		int kieusapxep = 4;
		String sxtype = "";
		if (req.getParameter("kieusapxep") != null && req.getParameter("kieusapxep") != "") {
			kieusapxep = Integer.parseInt(req.getParameter("kieusapxep"));
			if (kieusapxep == 1) sxtype = "Dang thanh toan";
			if (kieusapxep == 2) sxtype = "Da thanh toan";
			if (kieusapxep == 3) sxtype = "Da huy";
		}
		
		ArrayList<Booking> booked_tours = new ArrayList<>();
		ArrayList<Tour> tours = new ArrayList<>();
		
		TourDbUtil tourUbUtil = new TourDbUtil(dataSource);
		try {
			booked_tours = tourUbUtil.getPersonalBooking(user_id, sxtype);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for(Booking tour: booked_tours) {
			try {
				tours.add(tourUbUtil.getDetailTour(tour.getTourID()));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		req.setAttribute("bookedTours", booked_tours);
		req.setAttribute("tours", tours);
		req.setAttribute("ksx", kieusapxep);
		RequestDispatcher requestDispatcher = req.getRequestDispatcher("ToursBooked.jsp");
		requestDispatcher.forward(req,resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int id = Integer.parseInt(req.getParameter("id"));
		resp.sendRedirect(req.getContextPath() + "/tours");
	}
}