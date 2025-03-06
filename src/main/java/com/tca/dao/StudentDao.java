package com.tca.dao;

import com.tca.entities.Student;

import java.util.List;

public interface StudentDao {

    public abstract Student getStudent(Student student);
    public abstract List<Student> getAllStudent();

    public abstract Boolean addStudent(Student student);

}
