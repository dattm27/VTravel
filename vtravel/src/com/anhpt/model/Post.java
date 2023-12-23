package com.anhpt.model;

import java.sql.Timestamp;

public class Post {
    private int id;
    private int user_id;
    private String post_name;
    private String fullname;
    private String content;
    private String short_description;
	private String image;
    private Timestamp post_date;
    public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getPost_name() {
		return post_name;
	}

	public void setPost_name(String post_name) {
		this.post_name = post_name;
	}

	public String getfullname() {
		return fullname;
	}

	public void setfullname(String fullname) {
		this.fullname = fullname;
	}

	public String getShort_description() {
		return short_description;
	}

	public void setShort_description(String short_description) {
		this.short_description = short_description;
	}

	public Timestamp getPost_date() {
		return post_date;
	}

	public void setPost_date(Timestamp post_date) {
		this.post_date = post_date;
	}

    // Constructors, getters, and setters

    public Post() {
    }

    public Post(int id, int user_id, String content, String image, Timestamp post_date) {
        this.id = id;
        this.user_id = user_id;
        this.content = content;
        this.image = image;
        this.post_date = post_date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

	public Post(int id, int user_id, String post_name, String fullname, String content, String short_description,
			String image, Timestamp post_date) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.post_name = post_name;
		this.fullname = fullname;
		this.content = content;
		this.short_description = short_description;
		this.image = image;
		this.post_date = post_date;
	}

}
