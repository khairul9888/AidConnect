package com.aidconnect.servlet;

import com.aidconnect.dao.UserDAO;
import com.aidconnect.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String role = "donor";
        Date registrationDate = new Date(System.currentTimeMillis());

        User user = new User(fullName, email, password, phone, role, registrationDate);
        UserDAO userDAO = new UserDAO();

        if (userDAO.registerUser(user)) {
            response.sendRedirect("login.jsp");
        } else {
            response.getWriter().println("Registration failed. Try again.");
        }
    }
}
