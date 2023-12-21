package com.PVHoang.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.PVHoang.model.Posts;
import com.PVHoang.service.PostService;

@WebServlet(urlPatterns = {"/posts"})
public class PostController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Lay id tu trang PostList
		RequestDispatcher requestDispatcher = req.getRequestDispatcher("PostDetail.jsp");
		int id = Integer.parseInt(req.getParameter("id"));
		// Tim bai post chi tiet bang phuong thuc find trong PostService
		Posts post = PostService.find(id);
		// Set attribute de co the su dung trong PostDetail.jsp 
		req.setAttribute("post", post);
		requestDispatcher.forward(req, resp);
	}
}
