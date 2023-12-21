package com.PVHoang.model;

public class BookedTour {
	int booked_ID;
	String booked_date;
	String tour_name;
	int price;
	String status;

	public BookedTour(int booked_ID, String booked_date, String tour_name, int price, String status) {
		this.booked_ID = booked_ID;
		this.booked_date = booked_date;
		this.tour_name = tour_name;
		this.price = price;
		if (status.equals("on"))
		this.status = "waiting transaction";
	}

	public int getBooked_ID() {
		return booked_ID;
	}

	public void setBooked_ID(int booked_ID) {
		this.booked_ID = booked_ID;
	}

	public String getBooked_date() {
		return booked_date;
	}

	public void setBooked_date(String booked_date) {
		this.booked_date = booked_date;
	}

	public String getTour_name() {
		return tour_name;
	}

	public void setTour_name(String tour_name) {
		this.tour_name = tour_name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}