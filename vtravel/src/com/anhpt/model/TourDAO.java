package com.anhpt.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TourDAO {
    public List<Tour> getAllTours() {
        List<Tour> tours = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM tourdefault;";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Tour tour = new Tour();
                tour.setId_tour(resultSet.getInt("id_tour"));
                tour.setTourName(resultSet.getString("tourName"));
                tour.setPrice(resultSet.getInt("price"));
                tour.setNumber_left(resultSet.getInt("number_left"));
                tour.setDate_begin(resultSet.getString("date_begin"));
                tour.setLast(resultSet.getInt("last"));
                tour.setDate_end(resultSet.getString("date_end"));
                tour.setUrl(resultSet.getString("url"));
                tour.setDiscount(resultSet.getInt("discount"));
                tour.setDiscount_period(resultSet.getInt("discount_period"));
                tour.setStatus(resultSet.getString("status"));
                tours.add(tour);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tours;
    }
    public Tour getTourByID(int tourID) {
        Tour tour = new Tour();
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM tourdefault WHERE id_tour = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, tourID);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                tour.setId_tour(resultSet.getInt("id_tour"));
                tour.setTourName(resultSet.getString("tourName"));
                tour.setPrice(resultSet.getInt("price"));
                tour.setNumber_left(resultSet.getInt("number_left"));
                tour.setDate_begin(resultSet.getString("date_begin"));
                tour.setLast(resultSet.getInt("last"));
                tour.setDate_end(resultSet.getString("date_end"));
                tour.setUrl(resultSet.getString("url"));
                tour.setDiscount(resultSet.getInt("discount"));
                tour.setDiscount_period(resultSet.getInt("discount_period"));
                tour.setStatus(resultSet.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tour;
    }
    public boolean updateTour(Tour tour) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String updateQuery = "UPDATE tourdefault SET " +
                    "tourName = '" + tour.getTourName() + "', " +
                    "price = " + tour.getPrice() + ", " +
                    "number_left = " + tour.getNumber_left() + ", " +
                    "date_begin = '" + tour.getDate_begin() + "', " +
                    "last = " + tour.getLast() + ", " +
                    "date_end = '" + tour.getDate_end() + "', " +
                    "url = '" + tour.getUrl() + "', " +
                    "discount = " + tour.getDiscount() + ", " +
                    "discount_period = " + tour.getDiscount_period() + ", " +
                    "status = '" + tour.getStatus() + "' " +
                    "WHERE id_tour = " + tour.getId_tour();

            System.out.println(updateQuery);
            PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
            int rowsUpdated = preparedStatement.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có dòng bị cập nhật (thành công)
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Cập nhật thất bại
        }
    }
    public void lockTour(int id) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM tourdefault where id_tour = " + id + ";";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String status = resultSet.getString("status");
                System.out.println(status);

                // Thực hiện cập nhật dựa trên giá trị status
                String updateQuery;
                if ("on".equals(status)) {
                    updateQuery = "UPDATE tourdefault SET status = 'off' WHERE id_tour = ?";
                } else {
                    updateQuery = "UPDATE tourdefault SET status = 'on' WHERE id_tour = ?";
                }

                PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                updateStatement.setInt(1, id);
                int updatedRows = updateStatement.executeUpdate();

                if (updatedRows > 0) {
                    System.out.println("Cập nhật thành công!");
                } else {
                    System.out.println("Cập nhật không thành công!");
                }
            } else {
                System.out.println("Không tìm thấy tài khoản với ID " + id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void deleteTour(int id) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "DELETE FROM tourdefault where id_tour = " + id + ";";
            System.out.println(query);
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            int a = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void addTour(Tour tour) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String addQuery = "INSERT INTO tourdefault (tourName, price, number_left, date_begin, date_end, url, discount, discount_period, status,last) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
            
            PreparedStatement preparedStatement = connection.prepareStatement(addQuery);
            preparedStatement.setString(1, tour.getTourName());
            preparedStatement.setDouble(2, tour.getPrice());
            preparedStatement.setInt(3, tour.getNumber_left());
            preparedStatement.setString(4, tour.getDate_begin());
            preparedStatement.setString(5, tour.getDate_end());
            preparedStatement.setString(6, tour.getUrl());
            preparedStatement.setDouble(7, tour.getDiscount());
            preparedStatement.setInt(8, tour.getDiscount_period());
            preparedStatement.setString(9, tour.getStatus());
            preparedStatement.setInt(10, tour.getLast());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
