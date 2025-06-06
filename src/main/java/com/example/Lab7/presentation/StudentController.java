package com.example.Lab7.presentation;

import com.example.Lab7.data.StudentRepository;
import com.example.Lab7.data.Student;
import com.example.Lab7.data.GradeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.csrf.CsrfToken;

import java.util.List;
import java.util.Optional;

@Controller
public class StudentController {

    private final StudentRepository studentRepository;
    private final GradeRepository gradeRepository;

    @Autowired
    public StudentController(StudentRepository studentRepository, GradeRepository gradeRepository) {
        this.studentRepository = studentRepository;
        this.gradeRepository = gradeRepository;
    }

    @GetMapping("/students")
    @PreAuthorize("isAuthenticated()")
    public String listStudents(
            @RequestParam(value = "successMessage", required = false) String successMessage,
            @RequestParam(value = "errorMessage", required = false) String errorMessage,
            Model model,
            CsrfToken csrfToken) {
        List<Student> students = studentRepository.findAll();
        model.addAttribute("students", students);
        if (successMessage != null) {
            model.addAttribute("successMessage", successMessage);
        }
        if (errorMessage != null) {
            model.addAttribute("errorMessage", errorMessage);
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAdmin = authentication != null && authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"));
        model.addAttribute("isAdmin", isAdmin);

        model.addAttribute("_csrf", csrfToken);

        return "students";
    }

    @GetMapping("/students/create")
    @PreAuthorize("hasRole('ADMIN')")
    public String showCreateForm(Model model, CsrfToken csrfToken) {
        model.addAttribute("student", new Student());
        model.addAttribute("_csrf", csrfToken);
        return "student-form";
    }

    @GetMapping("/students/{id}/edit")
    @PreAuthorize("hasRole('ADMIN')")
    public String showEditForm(@PathVariable Long id, Model model, CsrfToken csrfToken) {
        Optional<Student> studentOptional = studentRepository.findById(id);
        if (studentOptional.isEmpty()) {
            return "redirect:/students?errorMessage=StudentNotFound";
        }
        model.addAttribute("student", studentOptional.get());
        model.addAttribute("_csrf", csrfToken);
        return "student-form";
    }

    @PostMapping("/students")
    @PreAuthorize("hasRole('ADMIN')")
    public String saveStudent(@ModelAttribute Student student) {
        studentRepository.save(student);
        return "redirect:/students?successMessage=StudentSaved";
    }

    @GetMapping("/students/{id}/delete")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteStudent(@PathVariable Long id) {
        studentRepository.deleteById(id);
        return "redirect:/students?successMessage=StudentDeleted";
    }
}