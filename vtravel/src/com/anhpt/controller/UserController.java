package com.anhpt.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.anhpt.model.Account;
import com.anhpt.model.AccountDAO;
import com.anhpt.model.DatabaseConnection;

/**
 * Servlet implementation class UIcontroller
 */
@WebServlet(urlPatterns={"/admin","/user-management","/update-user","/detail-user"})
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserController() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String command = request.getParameter("command");

        if (command == null) {
            command = "New"; 
        }

        switch (command) {
            case "LIST_ALL":
                handleList(request, response);
                break;
            case "LIST_USER":
                handleListUser(request, response);
                break;
            case "LIST_ADMIN":
                handleListAdmin(request, response);
                break;
            case "LOAD":
                handleLoad(request, response);
                break;
            case "UPDATE":
                handleUpdate(request, response);
                break;
            case "DETAIL":
            	handleDetail(request, response);
            	break;
            case "ADD":
            	addUser(request, response);
            	break;
            default:
                handleDefault(request, response);
        }
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		AccountDAO accountDAO = new AccountDAO();
        // Xử lý yêu cầu để hiển thị danh sách người dùng
        List<Account> accountList = accountDAO.getAllAccounts();
        request.setAttribute("accounts", accountList);
        request.getRequestDispatcher("user-management.jsp").forward(request, response);
    }
	protected void handleListUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		AccountDAO accountDAO = new AccountDAO();
        // Xử lý yêu cầu để hiển thị danh sách người dùng
        List<Account> accountList = accountDAO.getUserAccounts();
        request.setAttribute("accounts", accountList);
        request.getRequestDispatcher("user-management.jsp").forward(request, response);
    }
	protected void handleListAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		AccountDAO accountDAO = new AccountDAO();
        // Xử lý yêu cầu để hiển thị danh sách người dùng
        List<Account> accountList = accountDAO.getAdminAccounts();
        request.setAttribute("accounts", accountList);
        request.getRequestDispatcher("user-management.jsp").forward(request, response);
    }
	
	protected void handleLoad(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
	    System.out.println("sửa");

	    
    	AccountDAO accountDAOs = new AccountDAO();
        String userIDString = request.getParameter("userId");

        // Chuyển đổi chuỗi thành số nguyên (int)
        int userID = Integer.parseInt(userIDString);
        Account account = accountDAOs.getAccountByID(userID);
        
        if (account != null) {
            // Đưa dữ liệu vào request attribute
            request.setAttribute("accountUP", account);
            request.getRequestDispatcher("update-user.jsp").forward(request, response);
        } else {
            // Xử lý khi tài khoản không tồn tại
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

	protected void handleUpdate(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    System.out.println("1");

	    AccountDAO accountDAO = new AccountDAO();
	    System.out.println("1");

	    String userIdString = request.getParameter("userId");
	    String username = request.getParameter("username");
	    String email = request.getParameter("email");
	    String phoneNumber = request.getParameter("phoneNumber");
	    String password = request.getParameter("password");
	    String role = request.getParameter("role");
	    String status = request.getParameter("status");
	    System.out.println("1");

	    int userId = Integer.parseInt(userIdString);
	    System.out.println("1");
	    Account updatedAccount = new Account( userId,  username,  email,  phoneNumber,  password,  role,status);
	    System.out.println("1");

	    System.out.println("1");
	    
	    accountDAO.updateAccount(updatedAccount);
	    System.out.println("1");
	    handleList(request, response);
//	    request.getRequestDispatcher("user-management.jsp").forward(request, response);
	}
	protected void handleDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
	    System.out.println("sửa");

	    
    	AccountDAO accountDAOs = new AccountDAO();
        String userIDString = request.getParameter("userId");

        // Chuyển đổi chuỗi thành số nguyên (int)
        int userID = Integer.parseInt(userIDString);
        Account account = accountDAOs.getAccountByID(userID);
        
        if (account != null) {
            // Đưa dữ liệu vào request attribute
            request.setAttribute("accountUP", account);
            request.getRequestDispatcher("detail-user.jsp").forward(request, response);
        } else {
            // Xử lý khi tài khoản không tồn tại
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
	protected void handleLock(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIDString = request.getParameter("userId");

        // Chuyển đổi chuỗi thành số nguyên (int)
        int userID = Integer.parseInt(userIDString);
        AccountDAO accountDAO = new AccountDAO();
        accountDAO.lockAccount(userID);
        handleList(request, response);
        //request.getRequestDispatcher("user-management.jsp").forward(request, response);
        
    }
	
	protected void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIDString = request.getParameter("userId");

        // Chuyển đổi chuỗi thành số nguyên (int)
        int userID = Integer.parseInt(userIDString);
        AccountDAO accountDAO = new AccountDAO();
        accountDAO.deleteAccount(userID);
        handleList(request, response);
        //request.getRequestDispatcher("UI.jsp").forward(request, response);
        
    }
	protected void addUser(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {


	    AccountDAO accountDAO = new AccountDAO();
	    String username = request.getParameter("username");
	    String email = request.getParameter("email");
	    String phoneNumber = request.getParameter("phoneNumber");
	    String password = request.getParameter("password");
	    String role = request.getParameter("role");
	    String status = request.getParameter("status");

	    Account updatedAccount = new Account(username,  email,  phoneNumber,  password,  role,status);
	    accountDAO.addAccount(updatedAccount);
	    handleList(request, response);
//	    request.getRequestDispatcher("UI.jsp").forward(request, response);
	}
    private void handleDefault(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
	    request.getRequestDispatcher("user-management.jsp").forward(request, response);
    }
    
}

