package vtravel;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/trangdangki")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// Define datasource/ connection pool for Resource Jnjection
	@Resource(name = "jdbc/web_travel_booking")
	private DataSource dataSource;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("validUsername", 0);
		req.setAttribute("validEmail", 0);
		req.setAttribute("validPassword", 0);
		req.setAttribute("validFormatPassword", 0);
		req.setAttribute("validPhone_number", 0);
		req.setAttribute("SuccessfullRegister", 0);
		RequestDispatcher requestDispatcher = req.getRequestDispatcher("register.jsp");
		requestDispatcher.forward(req, resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String ufullname = request.getParameter("fullname");
		System.out.println(ufullname);
		String uname = request.getParameter("username");
		String uemail = request.getParameter("email");
		String upwd = request.getParameter("password");
		String Reupwd = request.getParameter("re_password");
		String umobile = request.getParameter("phone_number");
		//System.out.println(ufullname + " " + umobile);
		int validUsername = 0;
		int validPassword = 0;
		int validPhone_numer = 0;
		int validFormatPassword = 0;
		int validemail = 0;
		if (!upwd.equals(Reupwd))
			validPassword = 1;
		if (umobile.length() != 10)
			validPhone_numer = -1;
		if (upwd.length() < 8) {
			validFormatPassword = 1;
		}
		int checkChar = 0;
		for (int i = 0; i < upwd.length(); i++)
			if (Character.isLetter(upwd.charAt(i))) {
				checkChar = 1; 
				break;
			}
		if (checkChar == 0) validFormatPassword = 1;
		AccountDbUtil accountDbUtil = new AccountDbUtil(dataSource);
		try {
			validUsername = accountDbUtil.numberOfUsername(uname);
			validemail = accountDbUtil.numberOfEmail(uemail);
			validPhone_numer = accountDbUtil.numberOfPhone_number(umobile);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Connection con = null;
		RequestDispatcher dispatcher = null;
		if (validFormatPassword != 0 || validUsername != 0 || validemail != 0 || validPhone_numer != 0 || validPassword != 0) {
			request.setAttribute("validUsername", validUsername);
			request.setAttribute("validEmail", validemail);
			request.setAttribute("validPassword", validPassword);
			request.setAttribute("validPhone_number", validPhone_numer);
			request.setAttribute("validFormatPassword", validFormatPassword);
			request.setAttribute("SuccessfullRegister", 0);
			dispatcher = request.getRequestDispatcher("register.jsp");
			dispatcher.forward(request, response);

		} else {
			try {
				con = dataSource.getConnection();
				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO account (email, fullname, username, password, status, role, phone_number) values(?,?,?,?,?,?,?)");
				pst.setString(1, uemail);
				System.out.println(ufullname);
				pst.setString(2, ufullname);
				pst.setString(3, uname);
				pst.setString(4, upwd);
				pst.setString(5, "active");
				pst.setString(6, "user");
				pst.setString(7, umobile);

				int rowCount = pst.executeUpdate();
				request.setAttribute("validUsername", 0);
				request.setAttribute("validEmail", 0);
				request.setAttribute("validPassword", 0);
				request.setAttribute("validPhone_number", 0);
				request.setAttribute("validFormatPassword", 0);
				request.setAttribute("SuccessfullRegister", rowCount);
				dispatcher = request.getRequestDispatcher("register.jsp");
				dispatcher.forward(request, response);


			} catch (Exception e) {
				e.printStackTrace();

			} finally {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}

			}
		}
	}

}