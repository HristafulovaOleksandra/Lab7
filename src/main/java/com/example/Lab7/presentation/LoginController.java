package com.example.Lab7.presentation;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.security.web.csrf.CsrfToken;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String showLoginForm(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "logout", required = false) String logout,
            @RequestParam(value = "registrationSuccess", required = false) String registrationSuccess,
            Model model,
            CsrfToken csrfToken
    ) {
        if (error != null) {
            model.addAttribute("error", "Неправильне ім'я користувача або пароль.");
        }
        if (logout != null) {
            model.addAttribute("logout", "Ви успішно вийшли із системи.");
        }
        if (registrationSuccess != null) {
            model.addAttribute("registrationSuccess", "Реєстрація успішна! Тепер увійдіть.");
        }
        model.addAttribute("_csrf", csrfToken);
        return "login";
    }
}