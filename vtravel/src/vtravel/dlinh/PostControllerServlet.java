package vtravel.dlinh;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 * Servlet implementation class PostControllerServlet
 */
@WebServlet("/PostControllerServlet") // //Khai báo và định nghĩa class PostControllerServlet là 1 Servlet và cung cấp
										// URL mapping /PostControllerServlet cho nó
public class PostControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PostDbUtil postDbUtil; // Tương tác cơ sở dữ liệu về post
	private AccountDbUtil accountDbUtil; // Tương tác cơ sở dữ liệu về account
	private static final Logger logger = Logger.getLogger(PostControllerServlet.class.getName());
	// Định nghĩa data source/ connection pool cho nguồn Resource
	@Resource(name = "jdbc/tourweb")
	private DataSource dataSource;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PostControllerServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		try {
			postDbUtil = new PostDbUtil(dataSource);
			accountDbUtil = new AccountDbUtil(dataSource);
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html:;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		try {
			String theCommand = request.getParameter("command");
			switch (theCommand) {
			// Lấy ra danh sách tất cả các bài viết để hiển thị lên trang quản lý bài viết
			case "LIST_ALL_POST":
				listAllPost(request, response);
				break;
			case "POST_DETAIL":
				postDetail(request, response);
				break;
			}
		} catch (Exception exc) {
			throw new ServletException(exc);
		}
	}

	private void listAllPost(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		// Lấy danh sách các bài Post từ cơ sở dữ liệu
		List<Post> postList = postDbUtil.getPostList();

		// Thêm danh sách Post vừa lấy được vào request
		request.setAttribute("POST_LIST", postList);

		// Gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/Post.jsp");
		dispatcher.forward(request, response);
	}

	private void postDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		int ID = Integer.parseInt(request.getParameter("ID"));
		// logger.info("ID = " + ID);

		// Lấy chi tiết bài Post từ cơ sở dữ liệu
		Post post = postDbUtil.getPostDetail(ID);

		// Thêm chi tiết bài Post vừa lấy được vào request
		request.setAttribute("details", post);

		// Gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/PostDetail.jsp");
		dispatcher.forward(request, response);

	}

}
