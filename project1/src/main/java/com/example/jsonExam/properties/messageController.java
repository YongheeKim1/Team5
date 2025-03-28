package com.example.jsonExam.properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Locale;


@Controller
public class messageController {

    @Autowired
    private MessageSource messageSource;

    @GetMapping("/login-message")
    public String loginMessage(Locale locale) {
        return messageSource.getMessage("login.success", null, locale);
    }
}