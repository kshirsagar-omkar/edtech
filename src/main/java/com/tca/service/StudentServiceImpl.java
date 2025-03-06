package com.tca.service;

import com.tca.dao.StudentDao;
import com.tca.dao.StudentDaoImpl;
import com.tca.entities.Student;

import java.util.List;

public class StudentServiceImpl implements StudentService{

    public Student getStudent(Student student){
        StudentDao studentDao = new StudentDaoImpl();
        return studentDao.getStudent(student);
    }

    public List<Student> getAllStudent(){
        StudentDao studentDao = new StudentDaoImpl();
        return studentDao.getAllStudent();
    }



    public Boolean addStudent(Student student){
        StudentDao studentDao = new StudentDaoImpl();
        return studentDao.addStudent(student);
    }










    public static void main(String[] args) {
        StudentDao studentDao = new StudentDaoImpl();
        Student student = new Student();
        student.setName("vaibhav");
        student.setPer(78.45);
        student.setUsername("vaibhav");
        student.setPassword("123");

        if(studentDao.addStudent(student)){
            System.out.println("saved");
        }
        else {
            System.out.println("not saved");
        }

    }



}
