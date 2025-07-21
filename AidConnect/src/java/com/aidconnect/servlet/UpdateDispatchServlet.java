package com.aidconnect.servlet;

import com.aidconnect.db.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdateDispatchServlet")
public class UpdateDispatchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("dispatch_id"));
        String destination = request.getParameter("destination");
        String handledBy = request.getParameter("dispatchedTo");
        String status = request.getParameter("status");
        Date dispatchDate = Date.valueOf(request.getParameter("dispatchDate"));

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE Dispatch SET destination=?, handled_by=?, status=?, dispatch_date=? WHERE dispatch_id=?"
            );
            ps.setString(1, destination);
            ps.setString(2, handledBy);
            ps.setString(3, status);
            ps.setDate(4, dispatchDate);
            ps.setInt(5, id);

            ps.executeUpdate();
            conn.close();

            response.sendRedirect("viewdispatchpage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Update failed: " + e.getMessage());
        }
    }
}
