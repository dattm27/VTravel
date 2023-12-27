package vtravel.dlinh;

public class Post {
	private int ID;
	private int userID;
	private String name;
	private String shortDescription;
	private String content;
	private String date;
	private String image;
	
	public Post(int ID, String name, String shortDescription, String image) {
		super();
		this.ID = ID;
		this.name = name;
		this.shortDescription = shortDescription;
		this.image = image;
	}

	public Post(String name, String shortDescription, String content, String date, String image) {
		super();
		this.name = name;
		this.shortDescription = shortDescription;
		this.content = content;
		this.date = date;
		this.image = image;
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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

}
