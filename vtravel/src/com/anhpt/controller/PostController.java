package com.anhpt.controller;


import com.anhpt.model.Post;
import com.anhpt.model.PostDAO;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@WebServlet(urlPatterns={"/post-management","/add-post"})
//Khắc phục không sử dụng được getParamter khi gửi form dưới dạng multipart/form-data
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50) // 50MB
public class PostController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PostDAO postDAO;

    public void init() {
        postDAO = new PostDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html;charset=UTF-8");		
		request.setCharacterEncoding("UTF-8");
		
        String command = request.getParameter("command");
        if(command == null) command  = "false";
        switch (command) {
            case "GET_ALL_POSTS":
                getAllPosts(request, response);
                break;
            case "GET_POST_CONTENT":
                getPostContent(request, response);
                break;
            case "ADD":
                addPost(request, response);
                break;
            case "EDIT":
                editPost(request, response);
                break;
            default:
                getAllPosts(request, response);
                break;
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html;charset=UTF-8");		
		request.setCharacterEncoding("UTF-8");
        try {
            String command = getValue(request.getPart("command"));
            System.out.println(command);
	        switch (command) {
	            // Các trường hợp khác ...
	            case "UPDATE":
	                updatePost(request, response);
	                
	                break;
	
	            // Các trường hợp khác ...
	        }
        }catch (Exception exc) {
			throw new ServletException(exc);
		}
    }
    
    private void getAllPosts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Post> postList = postDAO.getAllPosts();
        request.setAttribute("postList", postList);
        request.getRequestDispatcher("post-management.jsp").forward(request, response);
    }

    private void getPostContent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));
        String content = postDAO.getPostContentFromDatabase(postId);

        // Trả về nội dung bài viết dưới dạng plain text
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(content);
        out.flush();
    }

    // Add other methods as needed
    private void addPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String user_id = request.getParameter("user_id");
        request.setAttribute("user_id", user_id);
        request.getRequestDispatcher("/add-post.jsp").forward(request, response);
    }
	protected void editPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
	    System.out.println("sửa");

	    
	    // Lấy ID bài viết từ request parameter
        String postIdString = request.getParameter("id");
        int postId = Integer.parseInt(postIdString);

        // Gọi hàm getPostById từ PostDAO để lấy thông tin bài viết cần sửa
        Post post = postDAO.getPostById(postId);

        // Đưa thông tin bài viết vào request attribute
        request.setAttribute("post", post);

        // Chuyển hướng đến trang edit-post.jsp để hiển thị form sửa thông tin bài viết
        RequestDispatcher dispatcher = request.getRequestDispatcher("edit-post.jsp");
        dispatcher.forward(request, response);
    }
	
    private void updatePost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException, Exception {
        // Lấy thông tin từ request
        int postId = Integer.parseInt(getValue(request.getPart("id")));
        String postName = getValue(request.getPart("post_name"));
        String shortDescription = getValue(request.getPart("short_description"));
        String content = getValue(request.getPart("content"));
        
        PrintWriter out = response.getWriter();
        //Xử lý phần ảnh
	    Part filePart = request.getPart("image");
	    String uniqueFileName = null;
	    //Kiểm tra nếu người dùng có nhập ảnh mới
	    if (filePart != null && filePart.getSize() > 0) {
	        String fileName = filePart.getSubmittedFileName();
		    
		    //Tạo tên độc nhất cho file ảnh, tránh trúng lặp
	        uniqueFileName = "images/post/" + UUID.randomUUID().toString() + "_" + fileName;

		    String appPath = request.getServletContext().getRealPath("");
		   
		    
		    String imagePath = appPath +  uniqueFileName;
		    out.print(imagePath);
		    //Ghi file ảnh vào thư mục 
		    filePart.write(imagePath);
	    
		    //xoá file ảnh cũ
		    String oldImage = getValue(request.getPart("oldImage"));
		    imagePath =  appPath + oldImage;
		    
		    out.print("Old file: \n"+ imagePath);
		    File oldImageFile = new File(imagePath);
		    
		    // kiểm tra nếu file đó có tồn tại trong kho thì xoá đi
		    if ( oldImage.length() > 0  && oldImageFile.exists()  ) {
		    	out.print("Old file existed");
		    	//oldImageFile.delete();
		    }
		    else out.print("Old file not found");
		    
	    }
	    
	    else {
	    	// nếu người dùng không cập nhật ảnh mới, tên file ảnh cũ giữ nguyên
	    	String oldImage = getValue(request.getPart("oldImage"));
	    	if (oldImage.length()==0)   uniqueFileName = ""; // chứng tỏ chưa có ảnh cũ
	    	else uniqueFileName = oldImage;
	    	out.print("Image path: " + uniqueFileName);
	    }
        // Thực hiện cập nhật dữ liệu trong database
        boolean updateSuccess = PostDAO.updatePost(postId, postName, shortDescription, uniqueFileName, content);

        try {        	
        	getAllPosts(request, response);

        }catch (Exception exc) {
	    	exc.printStackTrace();
	    }
    }
    
	//lấy giá trị từ các Part trong form được gửi ở dạng multipart/form-data
	String getValue(Part namePart)  throws Exception  {
			
			String value = null;  
			if (namePart != null) {
			        value = new BufferedReader(new InputStreamReader(namePart.getInputStream()))
			                .lines().collect(Collectors.joining());
			}
			return value ;
	}
}
