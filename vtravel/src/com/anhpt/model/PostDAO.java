package com.anhpt.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {
    
    public List<Post> getAllPosts() {
        List<Post> postList = new ArrayList<>();

        // Truy vấn lấy thông tin từ bảng post
        String sql = "SELECT post.id, post.user_id, post.post_name, post.content, post.image, post.post_date, account.fullname " +
                     "FROM post " +
                     "JOIN account ON post.user_id = account.id";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Post post = new Post();
                post.setId(resultSet.getInt("id"));
                post.setUser_id(resultSet.getInt("user_id"));
                post.setPost_name(resultSet.getString("post_name"));
                post.setContent(resultSet.getString("content"));
                post.setImage(resultSet.getString("image"));
                post.setPost_date(resultSet.getTimestamp("post_date"));
                post.setfullname(resultSet.getString("fullname")); // Thêm thông tin fullname
                postList.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return postList;
    }

    
    public String getPostContentFromDatabase(int postId) {
        String content = "";

        // Sử dụng trực tiếp chuỗi SQL trong preparedStatement
        String sql = "SELECT content FROM post WHERE id = ?";
        System.out.println(sql);
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, postId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    content = resultSet.getString("content");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return content;
    }
    
    public boolean savePost(Post post) {
        String sql = "INSERT INTO post (user_id, post_name, short_description, content, image, post_date) VALUES (?, ?, ?, ?, ?, NOW())";
        System.out.println(sql);
        try (
            Connection connection = DatabaseConnection.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)
        ) {
//            // Lấy fullname từ bảng account dựa trên user_id
//            String fullname = getfullnameById(post.getUser_id());

            // Thiết lập các tham số cho câu lệnh SQL
            statement.setInt(1, post.getUser_id());
            statement.setString(2, post.getPost_name());
            statement.setString(3, post.getShort_description());
            statement.setString(4, post.getContent());
            statement.setString(5, post.getImage());
    	    System.out.println(sql);
            // Thực hiện câu lệnh SQL
            int rowsAffected = statement.executeUpdate();

            // Trả về true nếu một hoặc nhiều dòng đã được thêm vào database
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            // Xử lý ngoại lệ SQL tại đây
        }

        // Trả về false nếu có lỗi xảy ra
        return false;
    }
    
    // Add other methods as needed, such as addPost, updatePost, deletePost, etc.
    public void deletePost(int id) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "DELETE FROM post where id = " + id + ";";
            System.out.println(query);
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            int a = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public Post getPostById(int postId) {
        Post post = new Post();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM post WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, postId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        post.setId(resultSet.getInt("id"));
                        post.setUser_id(resultSet.getInt("user_id"));
                        post.setPost_name(resultSet.getString("post_name"));
                        post.setShort_description(resultSet.getString("short_description"));
                        post.setContent(resultSet.getString("content"));
                        post.setImage(resultSet.getString("image"));
                        post.setPost_date(resultSet.getTimestamp("post_date"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return post;
    }

    public boolean editPost(Post post) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "UPDATE post SET post_name=?, short_description=?, content=?, image=? WHERE id=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, post.getPost_name());
                preparedStatement.setString(2, post.getShort_description());
                preparedStatement.setString(3, post.getContent());
                preparedStatement.setString(4, post.getImage());
                preparedStatement.setInt(5, post.getId());

                int rowsUpdated = preparedStatement.executeUpdate();
                return rowsUpdated > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    public static boolean updatePost(int postId, String postName, String shortDescription, String newImagePart, String content) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        boolean updateSuccess = false;

        try {
            connection = DatabaseConnection.getConnection();

            // Xây dựng câu truy vấn SQL
            String updateQuery = "UPDATE post SET " +
                    "post_name = ?, " +
                    "short_description = ?, " +
                    "content = ?";

            // Nếu có ảnh mới, thêm cột image vào câu truy vấn
            if (newImagePart != null && newImagePart.length() > 0) {
                updateQuery += ", image = ?";
            }

            updateQuery += " WHERE id = ?";

            preparedStatement = connection.prepareStatement(updateQuery);
            preparedStatement.setString(1, postName);
            preparedStatement.setString(2, shortDescription);
            preparedStatement.setString(3, content);

            // Nếu có ảnh mới, thiết lập giá trị cho cột image
            if (newImagePart != null && newImagePart.length() > 0) {
                // Thực hiện lưu trữ ảnh mới và lấy tên file
                preparedStatement.setString(4, newImagePart);
                preparedStatement.setInt(5, postId);
            } else {
                // Nếu không có ảnh mới, chỉ cần thiết lập giá trị cho cột image và id
                preparedStatement.setInt(4, postId);
            }

            // Thực hiện cập nhật
            int rowsUpdated = preparedStatement.executeUpdate();
            updateSuccess = rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Đóng các tài nguyên
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return updateSuccess;
    }
}
