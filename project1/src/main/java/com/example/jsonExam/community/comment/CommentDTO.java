package com.example.jsonExam.community.comment;

public class CommentDTO {
    private int id;
    private int postId;
    private String author;
    private String content;
    private String createdAt;
    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public int getPostId() {
		return this.postId;
	}

    // Getter & Setter
}