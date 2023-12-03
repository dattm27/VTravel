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
                account.setId(resultSet.getInt("id_user"));
                account.setUsername(resultSet.getString("username"));
                account.setEmail(resultSet.getString("email"));
                account.setPhoneNumber(resultSet.getString("phone_number"));
                account.setRole(resultSet.getString("role"));
                account.setStatus(resultSet.getString("status"));
                accounts.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }

    public List<Account> getUserAccounts() {
        List<Account> accounts = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM account where role = 'user';";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Account account = new Account();
                account.setId(resultSet.getInt("id_user"));
                account.setUsername(resultSet.getString("username"));
                account.setEmail(resultSet.getString("email"));
                account.setPhoneNumber(resultSet.getString("phone_number"));
                account.setRole(resultSet.getString("role"));
                account.setStatus(resultSet.getString("status"));
                accounts.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }

    public List<Account> getAdminAccounts() {
        List<Account> accounts = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM account where role = 'admin';";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Account account = new Account();
                account.setId(resultSet.getInt("id_user"));
                account.setUsername(resultSet.getString("username"));
                account.setEmail(resultSet.getString("email"));
                account.setPhoneNumber(resultSet.getString("phone_number"));
                account.setRole(resultSet.getString("role"));
                account.setStatus(resultSet.getString("status"));
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
            String query = "SELECT * FROM account where id_user = " + userID + ";";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                account.setId(resultSet.getInt("id_user"));
                account.setUsername(resultSet.getString("username"));
                account.setEmail(resultSet.getString("email"));
                account.setPhoneNumber(resultSet.getString("phone_number"));
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
                    "username = '" + account.getUsername() + "', " +
                    "email = '" + account.getEmail() + "', " +
                    "phone_number = '" + account.getPhoneNumber() + "', " +
                    "password = '" + account.getPassword() + "', " +
                    "role = '" + account.getRole() + "', " +
                    "status = '" + account.getStatus() + "' " +
                    "WHERE id_user = " + account.getId();

            System.out.println(updateQuery);
            PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
            int rowsUpdated = preparedStatement.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có dòng bị cập nhật (thành công)
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Cập nhật thất bại
        }
    }

    public void lockAccount(int id) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM account where id_user = " + id + ";";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String status = resultSet.getString("status");
                System.out.println(status);

                // Thực hiện cập nhật dựa trên giá trị status
                String updateQuery;
                if ("lock".equals(status)) {
                    updateQuery = "UPDATE account SET status = 'unlock' WHERE id_user = ?";
                } else {
                    updateQuery = "UPDATE account SET status = 'lock' WHERE id_user = ?";
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
            String query = "DELETE FROM account where id_user = " + id + ";";
            System.out.println(query);
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            int a = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addAccount(Account account) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String addQuery = "INSERT INTO account (username, email, phone_number, password, role, status) " +
                    "VALUES ('" + account.getUsername() + "', '" + account.getEmail() + "', '" +
                    account.getPhoneNumber() + "', '" + account.getPassword() + "', '" + account.getRole() + "', '" + account.getStatus() + "')";

            System.out.println(addQuery);
            PreparedStatement preparedStatement = connection.prepareStatement(addQuery);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
