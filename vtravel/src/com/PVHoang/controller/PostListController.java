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

import com.PVHoang.model.Posts;
import com.PVHoang.service.PostService;

@WebServlet(urlPatterns = {"/PostList"})
public class PostListController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//super.doGet(req, resp);
		RequestDispatcher requestDispatcher = req.getRequestDispatcher("PostList.jsp");
		// Dung phuong thuc all tao list tat ca cac post
		ArrayList<Posts> posts = PostService.all();
		// set attribute de co the su dung trong Post.jsp
		req.setAttribute("posts", posts);
		requestDispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Lay id tu trang post.jsp
		String id = req.getParameter("id");
		// chuyen huong sang PostDetail.jsp
		resp.sendRedirect(req.getContextPath() + "/posts");
	}
}
