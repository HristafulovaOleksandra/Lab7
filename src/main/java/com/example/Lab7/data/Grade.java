package com.example.Lab7.data;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "grade")
@Getter
@Setter
@EqualsAndHashCode
@ToString
public class Grade {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String subject;
    private Integer score;

    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;
}
