package com.anhpt.controller;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.anhpt.model.Account;
import com.anhpt.model.AccountDAO;
import com.anhpt.model.Post;
import com.anhpt.model.PostDAO;


@WebServlet("/add")
public class AddServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		String command = request.getParameter("command");
		if(command.equals("add-post")) {
			int userId = Integer.parseInt(request.getParameter("user_id"));
	        String postName = request.getParameter("post_name");
	        String shortDescription = request.getParameter("short_description");
	        String content = request.getParameter("content");
	        String image = request.getParameter("image");
	        
	        // Lấy thêm thông tin khác cần thiết từ request, ví dụ như ngày đăng bài
	        // (Để đơn giản, bạn cần kiểm tra và chuyển đổi kiểu dữ liệu nếu cần)
	        Timestamp postDate = new Timestamp(System.currentTimeMillis()); // Lấy ngày hiện tại
	        
	        Post post = new Post();
	        post.setUser_id(userId);
	        post.setPost_name(postName);
	        post.setShort_description(shortDescription);
	        post.setContent(content);
	        post.setImage(image);
	        post.setPost_date(postDate);
	        
	        PostDAO postDAO = new PostDAO();
	        
	        // Thực hiện thêm bài viết vào bảng post
	        boolean success = postDAO.savePost(post);
	        
	        if (success) {
	            // Gửi phản hồi về trình duyệt (ví dụ: "success")
	            response.getWriter().write("success");
	        } else {
	            // Gửi phản hồi lỗi về trình duyệt (ví dụ: "error")
	            response.getWriter().write("error");
	        }
		} else if(command.equals("add-user")) {
	        AccountDAO accountDAO = new AccountDAO();
	        String username = request.getParameter("username");
	        String fullname = request.getParameter("fullname");
	        String email = request.getParameter("email");
	        String phoneNumber = request.getParameter("phone_number");
	        String password = request.getParameter("password");
	        String role = request.getParameter("role");
	        String status = request.getParameter("status");

	        Account newAccount = new Account(username, fullname, email, phoneNumber, password, role, status);
	        boolean success = accountDAO.addAccount(newAccount);
	        if (success) {
	            // Gửi phản hồi về trình duyệt (ví dụ: "success")
	            response.getWriter().write("success");
	        } else {
	            // Gửi phản hồi lỗi về trình duyệt (ví dụ: "error")
	            response.getWriter().write("error");
	        }
		}
	}
}
