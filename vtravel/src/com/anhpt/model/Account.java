package com.anhpt.model;

public class Account {
    private int id;
    private String email;
    private String username;
    private String password;
    private String status;
    private String role;
    private String phone_number;
    private String fullname;

    public Account() {
    }
    public Account(int id, String username, String email, String phoneNumber, String password, String role, String status) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.phone_number = phoneNumber;
        this.password = password;
        this.role = role;
        this.status = status;
    }
    public Account(String username, String email, String phoneNumber, String password, String role, String status) {
        this.username = username;
        this.email = email;
        this.phone_number = phoneNumber;
        this.password = password;
        this.role = role;
        this.status = status;
    }
    public Account(String username,String fullname, String email, String phoneNumber, String password, String role, String status) {
        this.username = username;
        this.fullname = fullname;
        this.email = email;
        this.phone_number = phoneNumber;
        this.password = password;
        this.role = role;
        this.status = status;
    }
    public Account(int id, String email, String username, String password, String status, String role, String phone_number, String fullname) {
        this.id = id;
        this.email = email;
        this.username = username;
        this.password = password;
        this.status = status;
        this.role = role;
        this.phone_number = phone_number;
        this.fullname = fullname;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }
}
