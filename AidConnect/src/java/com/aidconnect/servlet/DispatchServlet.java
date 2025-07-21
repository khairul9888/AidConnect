package com.aidconnect.servlet;

import com.aidconnect.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DispatchServlet")
public class DispatchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String donationIdStr = request.getParameter("donationID");
        String destination = request.getParameter("destination");
        String handledBy = request.getParameter("dispatchedTo");
        String status = request.getParameter("status");
        Date dispatchDate = Date.valueOf(request.getParameter("dispatchDate"));

        try {
            int donationId = Integer.parseInt(donationIdStr);

            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO Dispatch (donation_id, destination, dispatch_date, handled_by, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, donationId);
            stmt.setString(2, destination);
            stmt.setDate(3, dispatchDate);
            stmt.setString(4, handledBy);
            stmt.setString(5, status);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("dashboard.jsp");
            } else {
                response.getWriter().println("Failed to save dispatch.");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
