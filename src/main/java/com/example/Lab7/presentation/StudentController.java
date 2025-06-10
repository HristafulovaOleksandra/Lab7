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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.data.domain.Sort;

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
            @RequestParam(value = "sortBy", required = false) String sortBy,
            @RequestParam(value = "searchQuery", required = false) String searchQuery,
            Model model,
            CsrfToken csrfToken) {

        List<Student> students;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            students = studentRepository.findByNameContainingIgnoreCase(searchQuery.trim());
        } else if ("asc".equalsIgnoreCase(sortBy)) {
            students = studentRepository.findAll(Sort.by(Sort.Direction.ASC, "name"));
        } else if ("desc".equalsIgnoreCase(sortBy)) {
            students = studentRepository.findAll(Sort.by(Sort.Direction.DESC, "name"));
        } else {
            students = studentRepository.findAll();
        }

        model.addAttribute("students", students);
        if (successMessage != null) {
            model.addAttribute("successMessage", successMessage);
        }
        if (errorMessage != null) {
            model.addAttribute("errorMessage", errorMessage);
        }
        model.addAttribute("searchQuery", searchQuery);

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
    public String saveStudent(@ModelAttribute Student student, RedirectAttributes redirectAttributes) {
        studentRepository.save(student);
        redirectAttributes.addFlashAttribute("successMessage", "StudentSaved");
        return "redirect:/students";
    }

    @PostMapping("/students/{id}/delete")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteStudent(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Optional<Student> studentOptional = studentRepository.findById(id);
        if (studentOptional.isPresent()) {
            studentRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "StudentDeleted");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "StudentNotFound");
        }
        return "redirect:/students";
    }
}