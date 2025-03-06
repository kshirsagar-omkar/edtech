package com.tca.controller;

import com.tca.entities.Student;
import com.tca.service.StudentService;
import com.tca.service.StudentServiceImpl;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "register", value = "/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1l;



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle POST requests here

        String name = request.getParameter("name");
        Double per = Double.parseDouble(request.getParameter("per"));
        String userName = request.getParameter("username");
        String password = request.getParameter("password");


        if(ifUsernameExist(userName)){
            handleError("Username Already exist", request, response);
            return;
        }



        Student student = new Student();
        student.setName(name);
        student.setPer(per);
        student.setUsername(userName);
        student.setPassword(password);


        if(addStudent(student)){
            response.sendRedirect("login.jsp?registered=true");
        }
        else {
            handleError("Unable to register", request, response);
        }

    }


    private void handleError(String message, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setAttribute("error", message);
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }




    private Boolean addStudent(Student student){
        StudentService studentService = new StudentServiceImpl();
        return studentService.addStudent(student);
    }



    private Boolean ifUsernameExist(String username){
        List<Student> students = null;

        StudentService studentService = new StudentServiceImpl();

        students = studentService.getAllStudent();

        for (Student student : students){

            if( student.getUsername().equals(username) ){
                return true;
            }

        }
        return false;
    }


}
