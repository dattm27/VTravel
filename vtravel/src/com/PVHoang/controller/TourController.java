package com.PVHoang.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.PVHoang.model.Tours;
import com.PVHoang.service.TourService;

@WebServlet(urlPatterns = {"/tours"})
public class TourController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher requestDispatcher = req.getRequestDispatcher("TourDetail.jsp");
		// lay id tu Home.jsp
		int id = Integer.parseInt(req.getParameter("id"));
		// tim tour theo phuong thuc find trong TourService
		Tours tour = TourService.find(id);
		// set attribute de su dung trong TourDetail
		req.setAttribute("tour", tour);
		requestDispatcher.forward(req, resp);
	}
	
	
}
