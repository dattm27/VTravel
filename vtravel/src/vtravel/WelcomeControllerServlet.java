package vtravel;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

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
 * Servlet implementation class WelcomeControllerServlet
 */
@WebServlet("/WelcomeControllerServlet")
public class WelcomeControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PostDbUtil postDbUtil; // tương tác với cơ sở dữ liệu về post
	private TourDbUtil tourDbUtil; // tương tác với cơ sở dữ liệu về tour
	//Define datasource/ connection pool for Resource Jnjection
	@Resource(name="jdbc/web_travel_booking")
	private DataSource dataSource;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WelcomeControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
	@Override
	public void init() throws ServletException {
		super.init();
		tourDbUtil = new TourDbUtil(dataSource);
		postDbUtil = new PostDbUtil(dataSource);
		
	}


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Hiển thị các tour nổi bật và các bài viết mới lên trang chủ
	
		try {
			//lấy 5 bài viết trong cơ sở dữ liệu
			List<Post> postList = postDbUtil.getPostList(true);
			//lấy 8 tour nổi bật trong cơ sở dữ liệu
			List<Tour> tourList = tourDbUtil.getAllTour(true);
			
			
			//thêm danh sách tour và bài viết vào request
			request.setAttribute("TOUR_LIST", tourList);
			request.setAttribute("POST_LIST", postList);
			
			//gửi về JSP
			RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
			dispatcher.forward(request, response);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
