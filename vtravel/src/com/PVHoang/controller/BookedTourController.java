package com.PVHoang.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.PVHoang.model.*;
import com.PVHoang.service.*;


/**
 * Servlet implementation class BookedTourController
 */
@WebServlet(urlPatterns = {"/BookedTour"})
public class BookedTourController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookedTourController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int user_id = Integer.parseInt(req.getParameter("ID"));
		int limit = 3;
		int page = 1;
		int kieusapxep = 0;
		if (req.getParameter("kieusapxep") != null && req.getParameter("kieusapxep") != "") {
			kieusapxep = Integer.parseInt(req.getParameter("kieusapxep"));
		}
		System.out.println("DAY adsfasd: " + kieusapxep);
		if (req.getParameter("page") != null && req.getParameter("page") != "") {
			page = Integer.parseInt(req.getParameter("page"));
		}
		ArrayList<BookedTour> booked_tours = new ArrayList<>();
		int totalRecord = BookedTourService.count(user_id, kieusapxep, limit, page);
		
		int totalPage = (int) Math.ceil((float) totalRecord / limit);

		
		booked_tours = BookedTourService.BookedTours(user_id, kieusapxep, limit, page);
	
		req.setAttribute("bookedTours", booked_tours);
		req.setAttribute("totalRecord", totalRecord);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("page", page);
		
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