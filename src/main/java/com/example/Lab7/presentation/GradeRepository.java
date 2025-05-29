package com.example.Lab7.presentation;

import com.example.Lab7.data.Grade;
import org.springframework.data.repository.CrudRepository;

public interface GradeRepository extends CrudRepository<Grade, Long>
{
}
