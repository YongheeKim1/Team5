package com.example.jsonExam.member;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper  // ✅ MyBatis 매퍼 어노테이션 추가 (반드시 있어야 함!)
public interface UserMapper {

    void registerUser(UserDTO user);

    @Select("SELECT * FROM users WHERE id = #{id} AND pw = #{pw}") // ✅ SQL 직접 작성
    UserDTO findUserByIdAndPassword(@Param("id") String id, @Param("pw") String password);

    UserDTO login(@Param("id") String id, @Param("pw") String password);
    UserDTO getUserById(String id);
    UserDTO getUserByPw(String pw);
    int updateUser(UserDTO user);
    int deleteUser(String id);
    void insertUser(UserDTO user);
}



