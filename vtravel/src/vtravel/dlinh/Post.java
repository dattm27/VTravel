package vtravel.dlinh;

public class Post {
	private int ID;
	private int userID;
	private String name;
	private String shortDescription;
	private String content;
	private String date;
	
	public Post(String name, String shortDescription) {
		super();
		this.name = name;
		this.shortDescription = shortDescription;
	}

	public Post(int iD, int userID, String name, String shortDescription, String content, String date) {
		super();
		ID = iD;
		this.userID = userID;
		this.name = name;
		this.shortDescription = shortDescription;
		this.content = content;
		this.date = date;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}
