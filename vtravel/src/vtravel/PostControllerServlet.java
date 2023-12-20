package vtravel;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import vtravel.dlinh.Post;

/**
 * Servlet implementation class PostControllerServlet
 */
@WebServlet(name = "PostController", urlPatterns = { "/PostController" })
public class PostControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PostDbUtil postDbUtil;
	private static final Logger logger = Logger.getLogger(TourControllerServlet.class.getName());
	//Define datasource/ connection pool for Resource Jnjection
	@Resource(name="jdbc/web_travel_booking")
	private DataSource dataSource;
  
    /**  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	@Override
	public void init() throws ServletException {
		super.init();
		postDbUtil = new PostDbUtil(dataSource);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		logger.info("PostControllerServlet called");
		try {
			String theCommand = request.getParameter("command");
			switch(theCommand) {
			//lấy danh sách tất cả các yêu cầu đặt custom tour (proposal) lên trang quản lý của admin
			case "LIST_NEW_POSTS":
				listNewPosts(request, response);
				break;
			default:
				break;
			}
		} catch(Exception exc) {
			throw new ServletException(exc);
		}
	}
	
	//hiển thị 8 bài viết mới lên trang chủ 
	private void listNewPosts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		logger.info("listNewPosts called");
		//lấy các 8 bài viết trong cơ sở dữ liệu
		List<Post> postList = postDbUtil.getPostList();
		
		//thêm danh sách bài viết vào request
		request.setAttribute("POST_LIST", postList);
		
		//gửi đến JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
