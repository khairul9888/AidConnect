package com.aidconnect.servlet;

import com.aidconnect.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteDispatchServlet")
public class DeleteDispatchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM Dispatch WHERE dispatch_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            stmt.executeUpdate();
            conn.close();

            response.sendRedirect("viewdispatchpage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Delete error: " + e.getMessage());
        }
    }
}
