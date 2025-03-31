package com.example.jsonExam.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.HashMap;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.jsonExam.member.UserDTO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;


// Controller Layer
@Controller
@RequestMapping("/member")
public class UserController {
    @Autowired private UserService userService;
    @Autowired private HttpSession session;

    @PostMapping("/regist") // 등록 경로 변경
    public String regist( UserDTO user, RedirectAttributes ra) {
    	
    	 System.out.println("🔍 받은 유저 정보: " + user.getId());
    	    System.out.println("🔍 이름: " + user.getUserName());
    	    System.out.println("🔍 비밀번호 확인: " + user.getConfirm());
        String msg = userService.regist(user); // user.registProc → userService.regist 변경

        ra.addFlashAttribute("msg", msg);

        if (msg.equals("회원가입 성공!")) {
            return "redirect:http://www.team5.click/project1/login"; // 로그인 페이지로 이동
        }
        return "redirect:http://www.team5.click/project1/template"; // 실패하면 다시 회원가입 폼으로 이동
    }
    
    
    
    @PostMapping("/login")
    public String login(@RequestParam(value = "id", required = false) String id, 
                        @RequestParam(value = "password", required = false) String password, 
                        RedirectAttributes ra,
                        HttpSession session) {

        if (id == null || password == null || id.isEmpty() || password.isEmpty()) {
            ra.addFlashAttribute("msg", "아이디와 비밀번호를 입력하세요.");
            return "redirect:http://www.team5.click/project1/login"; // 🔁 여기로 리다이렉트 됨
        }

        UserDTO user = userService.login(id, password);

        if (user == null) {
            ra.addFlashAttribute("msg", "아이디 또는 비밀번호가 틀렸습니다.");
            return "redirect:/login";  // 🔁 여기로 리다이렉트 됨
        }

        session.setAttribute("id", user.getId());
        return "redirect:/template";
    }





    
    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response) {
        session.invalidate();

        Cookie cookie = new Cookie("JSESSIONID", null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // ✅ 로그아웃 후 메인 페이지로 이동
        return "redirect:/template";
    }
    
   
    
    @GetMapping("/session")
    @ResponseBody
    public Map<String, Object> getSession(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        String userId = (String) session.getAttribute("id"); // ✅ 세션에서 사용자 ID 가져오기

        if (userId != null) {
            response.put("loggedIn", true);
            response.put("userId", userId);
        } else {
            response.put("loggedIn", false);
        }
        return response;
    }
    
    
    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("id");

        if (userId == null) {
            return "redirect:/login"; // 로그인 안 된 경우
        }

        UserDTO user = userService.findById(userId); // DB에서 유저 정보 가져오기
        model.addAttribute("user", user);
        return "mypage"; // mypage.jsp
    }


    
    
    @PostMapping("/update")
    public String updateUser(UserDTO user, RedirectAttributes redirectAttrs) {
        try {
            userService.updateUser(user);
            redirectAttrs.addFlashAttribute("successMessage", "회원 정보가 수정되었습니다.");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "정보 수정 실패: " + e.getMessage());
        }
        return "redirect:/MyPageUpdate";
    }
    
    // 회원 탈퇴
    @PostMapping("/delete")
    public String deleteUser(HttpSession session, RedirectAttributes redirectAttrs) {
        String userId = (String) session.getAttribute("id");
        if (userId == null) return "redirect:/login";

        try {
            userService.deleteUser(userId);
            session.invalidate(); // 로그아웃 처리
            redirectAttrs.addFlashAttribute("successMessage", "회원 탈퇴가 완료되었습니다.");
            return "redirect:/template";
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "회원 탈퇴 실패: " + e.getMessage());
            return "redirect:/MyPageUpdate";
        }
    }
    
    
    @GetMapping("/MyPageUpdate")
    public String showMyPageUpdate(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("id");

        if (userId == null) {
            return "redirect:/login";
        }

        UserDTO user = userService.findById(userId);
        model.addAttribute("user", user);
        return "mypageupdate";
    }

}
