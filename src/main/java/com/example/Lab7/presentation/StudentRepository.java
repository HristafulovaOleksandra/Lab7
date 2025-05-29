package com.example.Lab7.presentation;

import com.example.Lab7.data.Student;
import org.springframework.data.repository.CrudRepository;

public interface StudentRepository extends CrudRepository<Student, Long>
{
}
