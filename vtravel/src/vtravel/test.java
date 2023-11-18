package vtravel;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


/**
 * Servlet implementation class test
 */
@WebServlet("/test")
public class test extends HttpServlet {
	//Define datasource/ connection pool for Resource Jnjection
	@Resource(name="jdbc/web_travel_booking")
	private DataSource dataSource;
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public test() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//Step 1: set up the printwriter
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		
		//Step 2: Get a connection to the database
		Connection myConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		
		
		try {
			myConn = dataSource.getConnection();
			
			if( myConn == null) out.println("Cannot connect the database");
			else out.println("Connect database sucessfully");
			//Step 3: Create a SQL statements
			String sql = "select * from account";
			myStmt = myConn.createStatement();
			
			
			//Step 4: Execute SQL query
			myRs = myStmt.executeQuery(sql);
			
			//Step 5L Process the result set
			while (myRs.next()) {
				String email = myRs.getString("email");
				out.println(email);
			
			}
			
		}
		catch (Exception exc) {
			exc.printStackTrace();
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
