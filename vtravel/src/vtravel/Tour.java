package vtravel;

public class Tour {
	private int ID;
	private String name;
	private String startDate;
	private String endDate;
	private String description;
	private int price;
	private String startPlace;
	private String image;
//	constructor
	
	public int getID() {
		return ID;
	}

	public Tour(int iD, String name, String startDate, String endDate, int price) {
		super();
		ID = iD;
		this.name = name;
		this.startDate = startDate;
		this.endDate = endDate;
		this.price = price;
	}
	
	public Tour(int iD, String name, String startDate, String endDate, String description, int price, String startPlace,
			String image) {
		super();
		ID = iD;
		this.name = name;
		this.startDate = startDate;
		this.endDate = endDate;
		this.description = description;
		this.price = price;
		this.startPlace = startPlace;
		this.image = image;
	}

	public void setID(int iD) {
		ID = iD;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getStartPlace() {
		return startPlace;
	}
	public void setStartPlace(String startPlace) {
		this.startPlace = startPlace;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	
}
