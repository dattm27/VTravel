package com.anhpt.model;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConnection {
    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Tạo một ngữ cảnh JNDI để truy cập cài đặt cơ sở dữ liệu
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            // Tìm nguồn dữ liệu (DataSource) trong tệp context.xml
            DataSource dataSource = (DataSource) envContext.lookup("jdbc/web_travel_booking");
            // Lấy kết nối từ nguồn dữ liệu
            connection = dataSource.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }
}
