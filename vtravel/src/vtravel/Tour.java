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
	private int booked;
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
	
	//hiển thị lên danh sách ở trang index và trang tours page
	public Tour(int iD, String name, String startDate, String endDate, int price, String image, int booked) {
		super();
		ID = iD;
		this.name = name;
		this.startDate = startDate;
		this.endDate = endDate;
		this.price = price;
		this.image = image;
		this.booked = booked;
	}
	
	// khi lấy lên thông tin tour để cho vào trang detail tour page 
	public Tour(int iD, String name, String startDate, String endDate, String description, int price, String startPlace,
			String image, int booked) {
		super();
		ID = iD;
		this.name = name;
		this.startDate = startDate;
		this.endDate = endDate;
		this.description = description;
		this.price = price;
		this.startPlace = startPlace;
		this.image = image;
		this.booked = booked;
	}
	
	//khi tạo ra đối tượng tour để update
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

	public int getBooked() {
		return booked;
	}

	public void setBooked(int booked) {
		this.booked = booked;
	}
	
	
}
