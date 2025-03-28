package com.example.jsonExam.community.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/comment")
public class CommentController {
	    @Autowired private CommentService commentService;

	    @PostMapping("/add")
	    public String add(@ModelAttribute CommentDTO comment) {
	        commentService.addComment(comment);
	        return "redirect:/post/view?id=" + comment.getPostId();
	    }

	    @PostMapping("/delete")
	    public String delete(@RequestParam("id") int id, @RequestParam("postId") int postId) {
	        commentService.deleteComment(id);
	        return "redirect:/post/view?id=" + postId;
	    }
}
