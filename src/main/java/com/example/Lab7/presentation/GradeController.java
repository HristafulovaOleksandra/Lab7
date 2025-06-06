package com.example.Lab7.presentation;

import com.example.Lab7.data.Grade;
import com.example.Lab7.data.GradeRepository;
import com.example.Lab7.data.Student;
import com.example.Lab7.data.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
public class GradeController {

    private final GradeRepository gradeRepository;
    private final StudentRepository studentRepository;

    @Autowired
    public GradeController(GradeRepository gradeRepository, StudentRepository studentRepository) {
        this.gradeRepository = gradeRepository;
        this.studentRepository = studentRepository;
    }

    @GetMapping("/grades/add")
    public String showAddGradeForm(Model model) {
        List<Student> students = (List<Student>) studentRepository.findAll();
        model.addAttribute("students", students);
        return "add-grade";
    }

    @PostMapping("/grades/add")
    public String addGrade(@RequestParam("studentId") Long studentId,
                           @RequestParam("subject") String subject,
                           @RequestParam("score") Integer score,
                           RedirectAttributes redirectAttributes) {
        Optional<Student> studentOptional = studentRepository.findById(studentId);
        if (studentOptional.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Студента з таким ID не знайдено.");
            return "redirect:/grades/add";
        }

        Student student = studentOptional.get();
        Grade newGrade = new Grade();
        newGrade.setSubject(subject);
        newGrade.setScore(score);
        newGrade.setStudent(student);

        gradeRepository.save(newGrade);

        redirectAttributes.addFlashAttribute("successMessage", "Оцінку успішно додано!");
        return "redirect:/students";
    }
}