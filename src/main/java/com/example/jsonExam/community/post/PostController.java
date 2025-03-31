package com.example.jsonExam.community.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/post")
public class PostController {

    @Autowired 
    private PostService postService;

    /**
     * ✅ 게시글 목록 조회
     */
    @GetMapping("/list")
    public String list(Model model) {
        List<PostDTO> posts = postService.getAllPosts();
        
        // ✅ 가져온 게시글 개수 확인
        System.out.println("📢 컨트롤러 - 가져온 게시글 개수: " + posts.size());

        // ✅ requestScope에 데이터 저장
        model.addAttribute("posts", posts);

        return "community";  // ✅ JSP 경로 확인
    }

    /**
     * ✅ 특정 게시글 조회
     */
    @GetMapping("/view")
    public String view(@RequestParam("id") int id, Model model) {
        PostDTO post = postService.getPostById(id);
        if (post == null) {
            return "redirect:http://www.team5.click/project1/community";  // ✅ 게시글이 없을 경우 목록으로 리다이렉트
        }
        model.addAttribute("post", post);
        return "post-page";  // ✅ JSP 파일 경로 확인
    }

    /**
     * ✅ 게시글 생성
     */
    @PostMapping("/create")
    public String create(@ModelAttribute PostDTO post, RedirectAttributes redirectAttributes) {
        try {
            postService.createPost(post);
            redirectAttributes.addFlashAttribute("message", "게시글이 등록되었습니다.");
            return "redirect:http://www.team5.click/project1/post/list";  // ✅ 게시글 목록으로 이동
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "게시글 등록 중 오류 발생!");
            return "redirect:http://www.team5.click/project1/post/list";  // ✅ 다시 게시글 목록으로 이동
        }
    }

    /**
     * ✅ 게시글 수정
     */
    @PostMapping("/update")
    public String update(@ModelAttribute PostDTO post) {
        postService.updatePost(post);
        return "redirect:http://www.team5.click/project1/post/view?id=" + post.getId();
    }

    /**
     * ✅ 게시글 삭제
     */
    @PostMapping("/delete")
    public String deletePost(@RequestParam("id") int id) {
        postService.deletePost(id);
        return "redirect:/post/list";
    }
}