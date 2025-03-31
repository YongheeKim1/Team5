package com.example.jsonExam.community.post;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface PostMapper {
    List<PostDTO> getAllPosts();
    PostDTO getPostById(int id);
    void createPost(PostDTO post);
    void updatePost(PostDTO post);
    void deletePost(int id);
}
