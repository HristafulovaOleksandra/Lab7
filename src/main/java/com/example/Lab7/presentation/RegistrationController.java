package com.example.Lab7.presentation;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.security.web.csrf.CsrfToken;

@Controller
public class RegistrationController {

    @GetMapping("/register")
    public String showRegistrationForm(Model model, CsrfToken csrfToken) {
        model.addAttribute("_csrf", csrfToken);
        return "signup";
    }
}