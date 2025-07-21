package com.aidconnect.servlet;

import com.aidconnect.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteDonationServlet")
public class DeleteDonationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM Donation WHERE donation_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            stmt.executeUpdate();
            conn.close();

            response.sendRedirect(request.getContextPath() + "/viewdonationspage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Delete error: " + e.getMessage());
        }
    }
}
