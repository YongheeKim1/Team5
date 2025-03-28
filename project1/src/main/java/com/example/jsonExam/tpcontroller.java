package com.example.jsonExam;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.jsonExam.community.post.PostDTO;
import com.example.jsonExam.community.post.PostService;
import com.example.jsonExam.member.UserDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class tpcontroller {

  @Autowired 
  private PostService postService;

	@RequestMapping("template")
	public String template() {
		return "template";
	}
	
	@GetMapping("regist")
	public String regist() {
		System.out.println("nancao");
		return "regist";
	}
	
	@GetMapping("login")
	public String login() {
		return "login";
	}
	
	@GetMapping("community")
	public String community(Model model) {
    List<PostDTO> posts = postService.getAllPosts();
    model.addAttribute("posts", posts);
		return "community";
	}
	
	@GetMapping("news")
	public String news() {
		return "news";
	}
	
	
	@GetMapping("weather_write")
	public String weather_write() {
		return "weather_write";
	}
	
	@GetMapping("Mypage")
	public String Mypage() {
		return "Mypage";
	}
	
	@GetMapping("MyPageUpdate")
	public String MyPageUpdate() {
		
		return "MyPageUpdate";
	}
	
}
