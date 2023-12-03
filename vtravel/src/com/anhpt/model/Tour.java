package com.anhpt.model;

import java.util.Date;

public class Tour {

	private int id_tour;
    private String tourName;
    private int price;
    private int number_left;
    private String date_begin;
    private int last;
    private String date_end;
    private String url;
    private int discount;
    private int discount_period;
    private String status;
    
    public Tour() {

    }
    public Tour(String tourName, int price, int number_left, String date_begin, int last, String date_end, String url,
			int discount, int discount_period, String status) {
		super();
		this.tourName = tourName;
		this.price = price;
		this.number_left = number_left;
		this.date_begin = date_begin;
		this.last = last;
		this.date_end = date_end;
		this.url = url;
		this.discount = discount;
		this.discount_period = discount_period;
		this.status = status;
	}
    public Tour(int id_tour, String tourName, int price, int number_left, String date_begin, int last, String date_end, String url, int discount, int discount_period, String status) {
        this.id_tour = id_tour;
        this.tourName = tourName;
        this.price = price;
        this.number_left = number_left;
        this.date_begin = date_begin;
        this.last = last;
        this.date_end = date_end;
        this.url = url;
        this.discount = discount;
        this.discount_period = discount_period;
        this.status = status;
    }

    public int getId_tour() {
        return id_tour;
    }

    public void setId_tour(int id_tour) {
        this.id_tour = id_tour;
    }

    public String getTourName() {
        return tourName;
    }

    public void setTourName(String tourName) {
        this.tourName = tourName;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getNumber_left() {
        return number_left;
    }

    public void setNumber_left(int number_left) {
        this.number_left = number_left;
    }

    public String getDate_begin() {
        return date_begin;
    }

    public void setDate_begin(String date_begin) {
        this.date_begin = date_begin;
    }

    public int getLast() {
        return last;
    }

    public void setLast(int last) {
        this.last = last;
    }

    public String getDate_end() {
        return date_end;
    }

    public void setDate_end(String date_end) {
        this.date_end = date_end;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getDiscount_period() {
        return discount_period;
    }

    public void setDiscount_period(int discount_period) {
        this.discount_period = discount_period;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
