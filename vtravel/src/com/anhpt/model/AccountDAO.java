package com.anhpt.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO {
    public List<Account> getAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM account;";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Account account = new Account();
                account.setId(resultSet.getInt("id"));
                account.setUsername(resultSet.getString("username"));
                account.setEmail(resultSet.getString("email"));
                account.setPhone_number(resultSet.getString("phone_number"));
                account.setRole(resultSet.getString("role"));
                account.setStatus(resultSet.getString("status"));
                account.setFullname(resultSet.getString("fullname"));
                accounts.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }

    public Account getAccountByID(int userID) {
        Account account = new Account();
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM account where id = " + userID + ";";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                account.setId(resultSet.getInt("id"));
                account.setUsername(resultSet.getString("username"));
                account.setFullname(resultSet.getString("fullname"));
                account.setEmail(resultSet.getString("email"));
                account.setPhone_number(resultSet.getString("phone_number"));
                account.setRole(resultSet.getString("role"));
                account.setStatus(resultSet.getString("status"));
                account.setPassword(resultSet.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return account;
    }

    public boolean updateAccount(Account account) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String updateQuery = "UPDATE account SET " +
                    "username = ?, " +
                    "email = ?, " +
                    "phone_number = ?, " +
                    "password = ?, " +
                    "role = ?, " +
                    "status = ?, " +
                    "fullname = ? " +
                    "WHERE id = ?";

            PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
            preparedStatement.setString(1, account.getUsername());
            preparedStatement.setString(2, account.getEmail());
            preparedStatement.setString(3, account.getPhone_number());
            preparedStatement.setString(4, account.getPassword());
            preparedStatement.setString(5, account.getRole());
            preparedStatement.setString(6, account.getStatus());
            preparedStatement.setString(7, account.getFullname());
            preparedStatement.setInt(8, account.getId());

            int rowsUpdated = preparedStatement.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có dòng bị cập nhật (thành công)
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Cập nhật thất bại
        }
    }

    public void lockAccount(int id) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM account where id = " + id + ";";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String status = resultSet.getString("status");
                System.out.println(status);

                // Thực hiện cập nhật dựa trên giá trị status
                String updateQuery;
                if ("off".equals(status)) {
                    updateQuery = "UPDATE account SET status = 'on' WHERE id = ?";
                } else {
                    updateQuery = "UPDATE account SET status = 'off' WHERE id = ?";
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

    public void deleteAccount(int id) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "DELETE FROM account where id = " + id + ";";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            int a = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean addAccount(Account account) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String addQuery = "INSERT INTO account (username, email, phone_number, password, role, status, fullname) " +
                    "VALUES (?, ?, ?, ?, ?, ?,?)";

            PreparedStatement preparedStatement = connection.prepareStatement(addQuery);
            preparedStatement.setString(1, account.getUsername());
            preparedStatement.setString(2, account.getEmail());
            preparedStatement.setString(3, account.getPhone_number());
            preparedStatement.setString(4, account.getPassword());
            preparedStatement.setString(5, account.getRole());
            preparedStatement.setString(6, account.getStatus());
            preparedStatement.setString(7, account.getFullname());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
     // Trả về false nếu có lỗi xảy ra
        return false;
    }
}
