package com.PVHoang.controller;

public class Posts {
	int id;
	int user_id;  
	String content;
	String post_date;
	
	public Posts() {
		super();
	}
	
	public Posts(int id, int user_id, String content, String post_date) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.content = content;
		this.post_date = post_date;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPost_date() {
		return post_date;
	}
	public void setPost_date(String post_date) {
		this.post_date = post_date;
	}
	
}
