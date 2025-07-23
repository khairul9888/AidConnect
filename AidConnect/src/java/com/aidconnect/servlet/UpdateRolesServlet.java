package com.aidconnect.servlet;

import com.aidconnect.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Enumeration;

@WebServlet("/UpdateRolesServlet")
public class UpdateRolesServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String currentRole = (String) session.getAttribute("role");
        if (!"administrator".equals(currentRole)) {
            response.getWriter().println("Access denied. Administrator only.");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Iterate over parameters like role_1, role_2, etc.
            Enumeration<String> params = request.getParameterNames();

            while (params.hasMoreElements()) {
                String paramName = params.nextElement();
                if (paramName.startsWith("role_")) {
                    String userIdStr = paramName.substring(5);
                    int userId = Integer.parseInt(userIdStr);
                    String newRole = request.getParameter(paramName);

                    String sql = "UPDATE Users SET role = ? WHERE user_id = ?";
                    try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, newRole);
                        ps.setInt(2, userId);
                        ps.executeUpdate();
                    }
                }
            }
            response.sendRedirect("roles.jsp?update=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("roles.jsp?update=fail");
        }
    }
}
