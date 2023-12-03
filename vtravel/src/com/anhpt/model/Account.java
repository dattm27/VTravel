package com.anhpt.model;

public class Account {
    private int id;
    private String username;
    private String email;
    private String phoneNumber;
    private String role;
    private String status;
    private String password;
    // Các phương thức getter và setter cho các trường
    public Account() {
    	
    }
    public Account(int id,String username) {
    	this.id=id;
    	this.username=username;
    }
    public Account( String username, String email, String phoneNumber, String password, String role) {

        this.username = username;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
        this.status = status;
    }
    public Account( String username, String email, String phoneNumber, String password, String role, String status) {

        this.username = username;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
        this.status = status;
    }
    public Account(int userId, String username, String email, String phoneNumber, String password, String role, String status) {
        this.id = userId;
        this.username = username;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
        this.status = status;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}