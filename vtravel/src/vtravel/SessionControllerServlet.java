package vtravel;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 * Servlet implementation class SessionControllerServlet
 */
@WebServlet("/SessionControllerServlet")
public class SessionControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AccountDbUtil accountDbUtil; // tương tác với cơ sở dữ liệu về tài khoản
	//Define datasource/ connection pool for Resource Jnjection
	@Resource(name="jdbc/web_travel_booking")
	private DataSource dataSource;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SessionControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	@Override
	public void init() throws ServletException {
		
		super.init();
		try {
			
			accountDbUtil = new AccountDbUtil(dataSource);
		}
		catch (Exception exc) {
				throw new ServletException(exc);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String theCommand = request.getParameter("command");
		try {
			switch (theCommand) {
			case "LOG_OUT":
				logOut(request, response);
			default: 
				break;
			}
		}
		catch (Exception exc) {
			throw new ServletException( exc);
		}
	}

	private void logOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// In your logout servlet or method
		HttpSession session = request.getSession();

		// Invalidate the session to clear all session attributes
		session.invalidate();
		

		// Redirect the user to the login page or any other appropriate page
		response.sendRedirect("WelcomeControllerServlet"); 
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		String theCommand = request.getParameter("command");
		try {
			switch (theCommand) {
			case "SIGN_UP":
				
				break;
			case "LOG_IN":
				logIn(request, response);
				break;
			default: 
				break;
			}
		}
		catch (Exception exc) {
			throw new ServletException( exc);
		}
	}

	private void logIn(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ServletException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		int id = accountDbUtil.checkLoginInf(username, password);
		
		if (id != -1) { // tức đã đăng nhập thành công
			// tạo session
			HttpSession session = request.getSession();
			
			Account account = accountDbUtil.getAccountInf(id);
			//lưu thông tin đăng nhập vào session
			session.setAttribute("ID", id);
			session.setAttribute("username", account.getUsername());
			session.setAttribute("fullname", account.getFullname());
			session.setAttribute("role" ,account.getRole());
			session.setMaxInactiveInterval(30*60);
			//gửi lại jsp
			response.sendRedirect("WelcomeControllerServlet");
		}
		else {
			request.setAttribute("logInMessage", "fail");
			request.setAttribute("username", username);
			request.setAttribute("password", password);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
			dispatcher.forward(request, response);
		}
		
		PrintWriter out = response.getWriter();
		out.println(username +  " " + password +" " +id );
	}

}
