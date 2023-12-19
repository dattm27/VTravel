package vtravel;

public class Account {
	private int ID;
	private String fullname;
	private String username;
	private String phoneNumber;
	private String email;
	private String password;
	private String status;
	private String role;
	
	
	
	
	public Account(int iD, String fullname, String phoneNumber, String email) {
		super();
		ID = iD;
		this.fullname = fullname;
		this.phoneNumber = phoneNumber;
		this.email = email;
	}
	
	
	public Account(int iD, String fullname, String username, String phoneNumber, String email, String role) {
		super();
		ID = iD;
		this.fullname = fullname;
		this.username = username;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.role = role;
	}


	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	
}
