package com.example.jsonExam.community.like;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LikeMapper {
    void likePost(LikeDTO like);
    void unlikePost(LikeDTO like);
    int getLikeCount(int postId);
}
