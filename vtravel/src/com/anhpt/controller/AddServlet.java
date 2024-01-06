package com.anhpt.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.anhpt.model.Account;
import com.anhpt.model.AccountDAO;
import com.anhpt.model.Post;
import com.anhpt.model.PostDAO;


@WebServlet("/add")
//Khắc phục không sử dụng được getParamter khi gửi form dưới dạng multipart/form-data
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AddServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html;charset=UTF-8");		
		request.setCharacterEncoding("UTF-8");
		try {
			String command =null ;
			if(request.getParameter("command") != null) {
				command = request.getParameter("command");
			}else command = getValue(request.getPart("command"));
			
			if(command.equals("add-post")) {
				int userId = Integer.parseInt(getValue(request.getPart("user_id")));
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
		        
		        // Lấy thêm thông tin khác cần thiết từ request, ví dụ như ngày đăng bài
		        // (Để đơn giản, bạn cần kiểm tra và chuyển đổi kiểu dữ liệu nếu cần)
		        Timestamp postDate = new Timestamp(System.currentTimeMillis()); // Lấy ngày hiện tại
		        
		        Post post = new Post();
		        post.setUser_id(userId);
		        post.setPost_name(postName);
		        post.setShort_description(shortDescription);
		        post.setContent(content);
		        post.setImage(uniqueFileName);
		        post.setPost_date(postDate);
		        
		        PostDAO postDAO = new PostDAO();
		        
		        // Thực hiện thêm bài viết vào bảng post
		        boolean success = postDAO.savePost(post);
		        
		        try {        	
		        	request.getRequestDispatcher("post-management.jsp").forward(request, response);

		        }catch (Exception exc) {
			    	exc.printStackTrace();
			    }
		        
		        
			} else if(command.equals("add-user")) {
		        AccountDAO accountDAO = new AccountDAO();
		        String username = request.getParameter("username");
		        String fullname = request.getParameter("fullname");
		        String email = request.getParameter("email");
		        String phoneNumber = request.getParameter("phone_number");
		        String password = request.getParameter("password");
		        String role = request.getParameter("role");
		        String status = request.getParameter("status");
	
		        Account newAccount = new Account(username, fullname, email, phoneNumber, password, role, status);
		        boolean success = accountDAO.addAccount(newAccount);
		        if (success) {
		            // Gửi phản hồi về trình duyệt (ví dụ: "success")
		            response.getWriter().write("success");
		        } else {
		            // Gửi phản hồi lỗi về trình duyệt (ví dụ: "error")
		            response.getWriter().write("error");
		        }
			}
		}catch (Exception exc) {
			throw new ServletException(exc);
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
