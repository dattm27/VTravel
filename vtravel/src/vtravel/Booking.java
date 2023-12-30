package vtravel;

public class Booking {
	private int ID;
	private int userID;
	private int tourID;
	private int numberOfTourists;
	private String note;
	private String userFullname;
	private String status;
	private String createdDate; 
	private String userPhoneNumber;
	
	//constructor khi user confirm booking 
	public Booking(int userID, int tourID, int numberOfTourists, String note) {
		super();
		this.userID = userID;
		this.tourID = tourID;
		this.numberOfTourists = numberOfTourists;
		this.note = note;
	}
	
	//constructor khi load danh sách booking
	public Booking(int iD, int userID, int tourID, int numberOfTourists, String note, String userFullname, String status, String createdDate, String userPhoneNumber) {
		super();
		ID = iD;
		this.userID = userID;
		this.tourID = tourID;
		this.numberOfTourists = numberOfTourists;
		this.note = note;
		this.userFullname = userFullname;
		this.status = status;
		this.createdDate = createdDate;
		this.userPhoneNumber = userPhoneNumber;
	}
	
	public String getUserFullname() {
		return userFullname;
	}
	

	public void setUserFullname(String userFullname) {
		this.userFullname = userFullname;
	}
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public int getTourID() {
		return tourID;
	}
	public void setTourID(int tourID) {
		this.tourID = tourID;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getNumberOfTourists() {
		return numberOfTourists;
	}
	public void setNumberOfTourists(int numberOfTourists) {
		this.numberOfTourists = numberOfTourists;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}

	public void setUserPhoneNumber(String userPhoneNumber) {
		this.userPhoneNumber = userPhoneNumber;
	}
	
	
}
