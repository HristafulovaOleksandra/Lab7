package com.example.Lab7.presentation;

import com.example.Lab7.data.Grade;
import com.example.Lab7.data.GradeRepository;
import com.example.Lab7.data.Student;
import com.example.Lab7.data.StudentRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.web.csrf.CsrfToken;

import java.util.List;

@Controller
public class GradeController {

    private final GradeRepository gradeRepository;
    private final StudentRepository studentRepository;

    public GradeController(GradeRepository gradeRepository, StudentRepository studentRepository) {
        this.gradeRepository = gradeRepository;
        this.studentRepository = studentRepository;
    }

    @GetMapping("/grades/add")
    @PreAuthorize("hasRole('ADMIN')")
    public String showAddGradeForm(Model model, CsrfToken csrfToken) {
        List<Student> students = studentRepository.findAll();
        model.addAttribute("students", students);
        model.addAttribute("_csrf", csrfToken);
        return "add-grade";
    }

    @PostMapping("/grades")
    @PreAuthorize("hasRole('ADMIN')")
    public String addGrade(@RequestParam Long studentId,
                           @RequestParam String subject,
                           @RequestParam Integer score) {
        Student student = studentRepository.findById(studentId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid student Id:" + studentId));
        Grade grade = new Grade();
        grade.setStudent(student);
        grade.setSubject(subject);
        grade.setScore(score);
        gradeRepository.save(grade);
        return "redirect:/students?successMessage=GradeAdded";
    }
}