package com.anhpt.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.anhpt.model.AccountDAO;
import com.anhpt.model.PostDAO;

@WebServlet("/lock")
public class LockServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		if(request.getParameter("userId") != null) {
        String userIDString = request.getParameter("userId");
        // Chuyển đổi chuỗi thành số nguyên (int)
        int userId = Integer.parseInt(userIDString);
        AccountDAO accountDAO = new AccountDAO();
        accountDAO.lockAccount(userId);
        
        // Sau khi thực hiện hành động "lock", bạn có thể gửi phản hồi về trình duyệt (ví dụ: "success")
        response.getWriter().write("success");
		}
	}
}
