package com.tca.service;

import com.tca.entities.Student;

import java.util.List;

public interface StudentService {

    public abstract Student getStudent(Student student);
    public abstract List<Student> getAllStudent();

    public abstract Boolean addStudent(Student student);
}
