package com.anhpt.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.anhpt.model.Account;
import com.anhpt.model.AccountDAO;

@WebServlet(urlPatterns = { "/admin", "/user-management", "/update-user", "/detail-user" })
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String command = request.getParameter("command");

        if (command == null) {
            command = "LIST_ALL";
        }

        switch (command) {
            case "LIST_ALL":
                handleList(request, response);
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO accountDAO = new AccountDAO();
        List<Account> accountList = accountDAO.getAllAccounts();
        request.setAttribute("accountList", accountList);
        request.getRequestDispatcher("user-management.jsp").forward(request, response);
    }


    protected void handleLoad(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO accountDAO = new AccountDAO();
        String userIDString = request.getParameter("userId");

        int userID = Integer.parseInt(userIDString);
        Account account = accountDAO.getAccountByID(userID);

        if (account != null) {
            request.setAttribute("accountUP", account);
            request.getRequestDispatcher("update-user.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO accountDAO = new AccountDAO();
        String userIdString = request.getParameter("id");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone_number");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String status = request.getParameter("status");
        String fullname = request.getParameter("fullname");

        int userId = Integer.parseInt(userIdString);
        Account updatedAccount = new Account(userId, email, username, password, status, role, phoneNumber,fullname);

        boolean updateSuccess = accountDAO.updateAccount(updatedAccount);
        // Trả về kết quả
        if (updateSuccess) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }
    }

    protected void handleDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO accountDAO = new AccountDAO();
        String userIDString = request.getParameter("userId");

        int userID = Integer.parseInt(userIDString);
        Account account = accountDAO.getAccountByID(userID);

        if (account != null) {
            request.setAttribute("accountUP", account);
            request.getRequestDispatcher("detail-user.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.getRequestDispatcher("addUser.jsp").forward(request, response);
    }

    private void handleDefault(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("user-management.jsp").forward(request, response);
    }
}
