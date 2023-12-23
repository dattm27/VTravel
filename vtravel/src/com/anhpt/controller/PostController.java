package com.anhpt.controller;

import com.anhpt.model.Account;
import com.anhpt.model.AccountDAO;
import com.anhpt.model.Post;
import com.anhpt.model.PostDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(urlPatterns={"/post-management","/add-post"})
public class PostController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PostDAO postDAO;

    public void init() {
        postDAO = new PostDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        String command = request.getParameter("command");
        System.out.println(command);

        switch (command) {
            // Các trường hợp khác ...

            case "UPDATE":
                updatePost(request, response);
                break;

            // Các trường hợp khác ...
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
            throws ServletException, IOException {
        // Lấy thông tin từ request
        int postId = Integer.parseInt(request.getParameter("id"));
        String postName = request.getParameter("post_name");
        String shortDescription = request.getParameter("short_description");
        String newImagePart = request.getParameter("image"); // Đối với file ảnh
        String content = request.getParameter("content");

        // Thực hiện cập nhật dữ liệu trong database
        boolean updateSuccess = PostDAO.updatePost(postId, postName, shortDescription, newImagePart, content);

        // Trả về kết quả
        if (updateSuccess) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }
    }
}
