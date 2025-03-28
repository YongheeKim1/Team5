package com.example.jsonExam.community.like;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/like")
public class LikeController {
    @Autowired private LikeService likeService;

    @PostMapping("/toggle")
    public String toggle(@ModelAttribute LikeDTO like) {
        likeService.likePost(like);
        return "redirect:/post/view?id=" + like.getPostId();
    }
}
