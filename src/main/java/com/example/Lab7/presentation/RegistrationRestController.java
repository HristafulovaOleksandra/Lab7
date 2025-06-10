package com.example.Lab7.presentation;

import com.example.Lab7.data.User;
import com.example.Lab7.data.UserRepository;
import com.example.Lab7.data.Role;
import com.example.Lab7.dto.RegistrationRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/api")
public class RegistrationRestController {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public RegistrationRestController(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute RegistrationRequest registrationRequest,
                               Model model,
                               RedirectAttributes redirectAttributes) {

        // Перевірка на існування користувача
        if (userRepository.existsByUsername(registrationRequest.getUsername())) {
            model.addAttribute("error", "Користувач з таким іменем вже існує!");
            return "signup";
        }

        User newUser = new User();
        newUser.setUsername(registrationRequest.getUsername());
        newUser.setPassword(passwordEncoder.encode(registrationRequest.getPassword()));
        newUser.setRole(Role.USER); // Призначаємо роль за замовчуванням USER

        userRepository.save(newUser);

        System.out.println("Зареєстровано нового користувача: " + newUser.getUsername() + " з роллю: " + newUser.getRole());

        redirectAttributes.addFlashAttribute("registrationSuccess", "Реєстрація пройшла успішно! Тепер ви можете увійти.");
        return "redirect:/login";
    }
}