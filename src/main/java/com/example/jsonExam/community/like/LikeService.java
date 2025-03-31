package com.example.jsonExam.community.like;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikeService {
    @Autowired private LikeMapper likeMapper;

    public void likePost(LikeDTO like) {
        likeMapper.likePost(like);
    }

    public void unlikePost(LikeDTO like) {
        likeMapper.unlikePost(like);
    }

    public int getLikeCount(int postId) {
        return likeMapper.getLikeCount(postId);
    }
}
