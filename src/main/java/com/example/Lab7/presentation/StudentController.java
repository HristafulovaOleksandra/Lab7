package com.example.Lab7.presentation;

import com.example.Lab7.data.StudentRepository;
import com.example.Lab7.data.Student;
import com.example.Lab7.data.GradeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

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
    public String listStudents(
            @RequestParam(value = "successMessage", required = false) String successMessage,
            Model model) {
        List<Student> students = (List<Student>) studentRepository.findAll();
        model.addAttribute("students", students);
        if (successMessage != null) {
            model.addAttribute("successMessage", successMessage);
        }
        return "students";
    }
}