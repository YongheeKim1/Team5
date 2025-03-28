package com.example.jsonExam.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;

@Service
public class UserService {
    @Autowired private UserMapper userMapper;
    

    public String regist(UserDTO user) {
        if (user == null) {
            return "잘못된 요청입니다. 회원 정보를 입력하세요.";
        }

        // 1. 아이디 중복 검사
        if (userMapper.getUserById(user.getId()) != null) {
            return "이미 존재하는 아이디입니다.";
        }

        // 2. 회원 정보 저장
        userMapper.insertUser(user);
        return "회원가입 성공!";
    }
    
    public void registerUser(UserDTO user) {
        userMapper.registerUser(user);
    }

    private HttpSession session;  // 🔹 세션 객체 주입

    public UserDTO login(String id, String password) {
        UserDTO user = userMapper.findUserByIdAndPassword(id, password);

        if (user == null) {
            System.out.println("로그인 실패: 아이디 또는 비밀번호 불일치");
            // 또는 throw new CustomLoginException("아이디 또는 비밀번호가 잘못되었습니다.");
        } else {
            System.out.println("로그인 성공: " + user.userName());
        }

        return user;
    }


    public boolean updateUser(UserDTO user) {
        int result = userMapper.updateUser(user); // 수정된 행의 수 반환
        return result > 0;
    }

    public boolean deleteUser(String id) {
        int result = userMapper.deleteUser(id); // 삭제된 행의 수 반환
        return result > 0;
    }

    public UserDTO getLoggedInUser(HttpSession session) {
        return (UserDTO) session.getAttribute("loginUser");
    }

	public void logout() {
		// TODO Auto-generated method stub
		
	}

	public UserDTO findById(String userId) {
	    return userMapper.getUserById(userId);
	}

    
}
