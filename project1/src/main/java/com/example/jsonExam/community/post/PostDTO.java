package com.example.jsonExam.community.post;

import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import java.util.List;

import com.example.jsonExam.community.comment.CommentDTO;

public class PostDTO {
    private int id;
    private String title;
    private String content;
    private String author;
    private LocalDateTime createdAt;
    private List<CommentDTO> comments;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getAuthor() { 
        return author == null || author.trim().isEmpty() ? "익명" : author; // ✅ 기본값 설정
    }
    public void setAuthor(String author) { this.author = author; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public void setComments(List<CommentDTO> comments) { this.comments = comments; }
    public List<CommentDTO> getComments() { return this.comments; }
    
    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        return createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
    
}
