package com.aidconnect.servlet;

import com.aidconnect.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        String message = request.getParameter("message");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO Feedback (user_id, message, submitted_at) VALUES (?, ?, CURRENT_TIMESTAMP)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, message);
            ps.executeUpdate();

            response.sendRedirect("dashboard.jsp?feedback=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("feedback.jsp?error=1");
        }
    }
}
