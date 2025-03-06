package com.tca.dao;

import com.tca.Util.DBUtil;
import com.tca.entities.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDaoImpl implements StudentDao{

    @SuppressWarnings("finally")
	public Student getStudent(Student searchStudent){

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        Student student = null;


        try{
            connection = DBUtil.getConnection();
            preparedStatement = connection.prepareStatement("SELECT * FROM student WHERE rno=?");
            preparedStatement.setInt(1, searchStudent.getRno());
            resultSet = preparedStatement.executeQuery();

            if(resultSet.next()){
                student = new Student();
                student.setRno( resultSet.getInt("rno") );
                student.setName( resultSet.getString("name") );
                student.setPer( resultSet.getDouble("per") );
                student.setUsername( resultSet.getString("username") );
                student.setPassword( resultSet.getString("password") );

                System.out.println("Student Found!");
            }
            else {
                System.out.println("Student Not Found!");
            }

        } catch (Exception e) {
            System.out.println("\n\n\nException in StudentDaoImpl Class :" + e.getMessage() + "\n\n\n");
            e.printStackTrace();
        }
        finally {
            if(connection != null){
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println("\n\n\nException in StudentDaoImpl Class While Closing Connection:" + e.getMessage() + "\n\n\n");
                    e.printStackTrace();
                }
            }

            return student;
        }
    }




    @SuppressWarnings("finally")
	public List<Student> getAllStudent(){


        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        List<Student> students = null;


        try{
            connection = DBUtil.getConnection();
            statement = connection.createStatement();

            resultSet = statement.executeQuery("SELECT * FROM student");

            students = new ArrayList<>();

            while(resultSet.next()){

                Student student = new Student();
                student.setRno( resultSet.getInt("rno") );
                student.setName( resultSet.getString("name") );
                student.setPer( resultSet.getDouble("per") );
                student.setUsername( resultSet.getString("username") );
                student.setPassword( resultSet.getString("password") );

                students.add(student);

            }

        } catch (Exception e) {
            System.out.println("\n\n\nException in StudentDaoImpl Class :" + e.getMessage() + "\n\n\n");
            e.printStackTrace();
        }
        finally {
            if(connection != null){
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println("\n\n\nException in StudentDaoImpl Class While Closing Connection:" + e.getMessage() + "\n\n\n");
                    e.printStackTrace();
                }
            }
            if(students != null && students.isEmpty()) {
                return null;
            }
            
            if(students == null) {
            	List<Student> students1 = new ArrayList<>();
            	Student student = new Student();
                student.setRno( 1011 );
                student.setName( "jadoo" );
                student.setPer( 3.3);
                student.setUsername( "un" );
                student.setPassword("pass" );
            	students1.add(student);
            	return students1;
            }
            
            return students;
        }


    }






    public Boolean addStudent(Student student){


        Connection connection = null;
        PreparedStatement preparedStatement = null;

        Boolean savedSuccessful = false;



        try{
            connection = DBUtil.getConnection();
            connection.setAutoCommit(false);

            preparedStatement = connection.prepareStatement("INSERT INTO student(name,per,username,password) VALUES (?,?,?,?)");
            preparedStatement.setString(1,student.getName());
            preparedStatement.setDouble(2, student.getPer());
            preparedStatement.setString(3,student.getUsername());
            preparedStatement.setString(4,student.getPassword());

            if(preparedStatement.executeUpdate() != 0){
                savedSuccessful = true;
                connection.commit();
            }
            else {
                savedSuccessful = false;
                connection.rollback();
            }

        } catch (Exception e) {
            System.out.println("\n\n\nException in StudentDaoImpl Class :" + e.getMessage() + "\n\n\n");
            e.printStackTrace();
            if(connection != null){
                connection.rollback();
            }
        }
        finally {
            if(connection != null){
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println("\n\n\nException in StudentDaoImpl Class While Closing Connection:" + e.getMessage() + "\n\n\n");
                    e.printStackTrace();
                }
            }
            return savedSuccessful;
        }

    }





    public static void main(String[] args) {
        StudentDao studentDao = new StudentDaoImpl();
        Student student = new Student();
        student.setName("Omkar");
        student.setPer(95.88);
        student.setUsername("om");
        student.setPassword("123");

        if(studentDao.addStudent(student)){
            System.out.println("saved");
        }
        else {
            System.out.println("not saved");
        }

    }









}
