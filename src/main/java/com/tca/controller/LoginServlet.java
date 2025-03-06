package com.tca.controller;

import java.io.*;
import java.util.List;

import com.tca.dao.StudentDao;
import com.tca.dao.StudentDaoImpl;
import com.tca.entities.Student;
import com.tca.service.StudentService;
import com.tca.service.StudentServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@SuppressWarnings("unused")
@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1l;



    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String userName = request.getParameter("username");
        String password = request.getParameter("password");

        if( validateUser(userName, password) ){

            HttpSession session = request.getSession(true);
            session.setAttribute("username", userName);

            response.sendRedirect("dashboard.jsp");

        }
        else{
            request.setAttribute("error", "Invalid Username Or Password");
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }

    }


    private Boolean validateUser(String userName, String password){

//        return ( userName.equals("om") && password.equals("123") );

        List<Student> students = null;

        StudentService studentService = new StudentServiceImpl();

        students = studentService.getAllStudent();

//        if(students != null) System.out.println("\n\n\n\n Yes It Works\n\n\n\n\n");

        for (Student student : students){

            if( student.getUsername().equals(userName) && student.getPassword().equals(password) ){
                return true;
            }

        }
        return false;
    }







}