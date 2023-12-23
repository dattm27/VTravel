package com.anhpt.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.anhpt.model.AccountDAO;
import com.anhpt.model.PostDAO;


@WebServlet("/delete")
public class DeleteServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		if(request.getParameter("userId") != null) {
	        int userId = Integer.parseInt(request.getParameter("userId"));
	        AccountDAO accountDAO = new AccountDAO();
	        accountDAO.deleteAccount(userId);
	        
	        // Sau khi thực hiện hành động "xóa", bạn có thể gửi phản hồi về trình duyệt (ví dụ: "success")
	        response.getWriter().write("success");
		}else if(request.getParameter("id") != null)  {
			 int id = Integer.parseInt(request.getParameter("id"));
	        PostDAO postDAO = new PostDAO();
	        postDAO.deletePost(id);
	        
	        // Sau khi thực hiện hành động "xóa", bạn có thể gửi phản hồi về trình duyệt (ví dụ: "success")
	        response.getWriter().write("success");
		}
	}
}
