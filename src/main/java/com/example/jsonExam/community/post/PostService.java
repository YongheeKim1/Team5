package com.example.jsonExam.community.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.jsonExam.community.comment.CommentMapper;

import java.util.List;
import java.time.LocalDateTime;

@Service
public class PostService {
    @Autowired private PostMapper postMapper;
    @Autowired private CommentMapper commentMapper;
    public void createPost(PostDTO post) {
        if (post.getCreatedAt() == null) {
            post.setCreatedAt(LocalDateTime.now());  // ✅ 자동 생성
        }
        if (post.getAuthor() == null || post.getAuthor().trim().isEmpty()) {
            post.setAuthor("익명");  // ✅ 기본값 설정
        }
        postMapper.createPost(post);
    }

    public PostDTO getPostById(int id) {
        PostDTO post = postMapper.getPostById(id);
        post.setComments(commentMapper.getCommentsByPostId((post.getId())));
        return post;
    }

    public List<PostDTO> getAllPosts() {
        List<PostDTO> posts = postMapper.getAllPosts();
        
        // ✅ MyBatis에서 데이터 정상 조회 확인
        System.out.println("📢 서비스 - DB에서 가져온 게시글 개수: " + posts.size());

        // 댓글 불러오기
        for (PostDTO post : posts) {
          post.setComments(commentMapper.getCommentsByPostId((post.getId())));
        }

        return posts;
    }

    public void updatePost(PostDTO post) {
        postMapper.createPost(post);
    }

    public void deletePost(int id) {
        postMapper.deletePost(id);
    }
    
    

}
