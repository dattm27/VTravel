package com.anhpt.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.anhpt.model.Account;
import com.anhpt.model.AccountDAO;
import com.anhpt.model.Tour;
import com.anhpt.model.TourDAO;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns={"/tour","/update-tour","/detail-tour"})
public class TourController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public TourController() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String command = request.getParameter("command");

        if (command == null) {
            command = "New"; 
        }

        switch (command) {
            case "LIST":
                handleList(request, response);
                break;
            case "LOAD":
                handleLoad(request, response);
                break;
            case "UPDATE":
				try {
					handleUpdate(request, response);
				} catch (ServletException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
                break;
            case "DETAIL":
            	handleDetail(request, response);
            	break;
            case "ADD":
            	addTour(request, response);
            	break;
            default:
                handleDefault(request, response);
        }
    }
	protected void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		TourDAO TourDAO = new TourDAO();
        // Xử lý yêu cầu để hiển thị danh sách người dùng
        List<Tour> tourList = TourDAO.getAllTours();
        request.setAttribute("tours", tourList);
        request.getRequestDispatcher("Tour.jsp").forward(request, response);
    }
	protected void handleLoad(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
	    System.out.println("sửa");
    	TourDAO tourDAOs = new TourDAO();
        String tourIDString = request.getParameter("tourId");

        // Chuyển đổi chuỗi thành số nguyên (int)
        int tourID = Integer.parseInt(tourIDString);
        Tour tour = tourDAOs.getTourByID(tourID);
        
        if (tour != null) {
            // Đưa dữ liệu vào request attribute
            request.setAttribute("tour", tour);
            request.getRequestDispatcher("update-tour.jsp").forward(request, response);
        } else {
            // Xử lý khi tài khoản không tồn tại
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
	protected void handleUpdate(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException, ParseException {
	    TourDAO tourDAO = new TourDAO();
	    System.out.println("11111");
	    String tourIdString = request.getParameter("tourId");
	    String tourName = request.getParameter("tourName");
	    String priceString = request.getParameter("price");
	    String numberLeftString = request.getParameter("number_left");
	    String dateBeginString = request.getParameter("date_begin");
	    String lastString = request.getParameter("last");
	    String dateEndString = request.getParameter("date_end");
	    String url = request.getParameter("url");
	    String discountString = request.getParameter("discount");
	    String discountPeriodString = request.getParameter("discount_period");
	    String status = request.getParameter("status");

	    int tourId = Integer.parseInt(tourIdString);
	    int price = Integer.parseInt(priceString);
	    int numberLeft = Integer.parseInt(numberLeftString);
	    int last = Integer.parseInt(lastString);
	    int discount = Integer.parseInt(discountString);
	    int discountPeriod = Integer.parseInt(discountPeriodString);


	    Tour updatedTour = new Tour(tourId, tourName, price, numberLeft, dateBeginString, last, dateEndString, url, discount, discountPeriod, status);

	    tourDAO.updateTour(updatedTour);

	    handleList(request, response);
//	    request.getRequestDispatcher("Tour.jsp").forward(request, response);
	}

	protected void handleDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
	    System.out.println("sửa");

	    
    	TourDAO tourDAOs = new TourDAO();
        String tourIDString = request.getParameter("tourId");

        // Chuyển đổi chuỗi thành số nguyên (int)
        int tourID = Integer.parseInt(tourIDString);
        Tour tour = tourDAOs.getTourByID(tourID);
        
        if (tour != null) {
            // Đưa dữ liệu vào request attribute
            request.setAttribute("tour", tour);
            request.getRequestDispatcher("detail-tour.jsp").forward(request, response);
        } else {
            // Xử lý khi tài khoản không tồn tại
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
	protected void addTour(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    TourDAO tourDAO = new TourDAO();
	    String tourName = request.getParameter("tourName");
	    int price = Integer.parseInt(request.getParameter("price"));
	    int numberLeft = Integer.parseInt(request.getParameter("numberLeft"));
	    String dateBegin = request.getParameter("dateBegin");
	    String dateEnd = request.getParameter("dateEnd");
	    int discount = Integer.parseInt(request.getParameter("discount"));
	    int discountPeriod = Integer.parseInt(request.getParameter("discountPeriod"));
	    String status = request.getParameter("status");
	    int last = Integer.parseInt(request.getParameter("last"));
	    String url = request.getParameter("url");

	    // Tạo một đối tượng Tour từ thông tin đã nhận
	    Tour newTour = new Tour(tourName, price, numberLeft, dateBegin,last, dateEnd, url, discount, discountPeriod, status);

	    // Gọi phương thức thêm tour trong lớp DAO
	    tourDAO.addTour(newTour);

	    // Sau khi thêm tour, chuyển hướng hoặc xử lý tiếp theo tại đây
	    handleList(request, response);
	}



    private void handleDefault(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
	    request.getRequestDispatcher("Tour.jsp").forward(request, response);
    }
}
