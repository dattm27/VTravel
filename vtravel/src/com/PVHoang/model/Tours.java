package com.PVHoang.model;

public class Tours {
	int id;
	int price;
	int max_number_tourist;
	String start_date;
	String end_date;
	String tour_name;
	int discount;
	String start_discount;
	String end_discount;
	String start_place;
	String status;
	String description;
	
	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getStart_discount() {
		return start_discount;
	}

	public void setStart_discount(String start_discount) {
		this.start_discount = start_discount;
	}

	public String getEnd_discount() {
		return end_discount;
	}

	public void setEnd_discount(String end_discount) {
		this.end_discount = end_discount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Tours() {
		super();
	}

	public Tours(int id, int price, int max_number_tourist, String tour_name, int discount, String start_place,
			String description) {
		super();
		this.id = id;
		this.price = price;
		this.max_number_tourist = max_number_tourist;
		this.tour_name = tour_name;
		this.discount = discount;
		this.start_place = start_place;
		this.description = description;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getMax_number_tourist() {
		return max_number_tourist;
	}
	public void setMax_number_tourist(int max_number_tourist) {
		this.max_number_tourist = max_number_tourist;
	}
	public String getTour_name() {
		return tour_name;
	}
	public void setTour_name(String tour_name) {
		this.tour_name = tour_name;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getStart_place() {
		return start_place;
	}
	public void setStart_place(String start_place) {
		this.start_place = start_place;
	}
	
}
