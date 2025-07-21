package com.aidconnect.servlet;

import com.aidconnect.dao.DonationDAO;
import com.aidconnect.model.Donation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditDonationServlet")
public class EditDonationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int donationId = Integer.parseInt(request.getParameter("id"));

            Donation donation = new DonationDAO().getDonationById(donationId);

            if (donation != null) {
                request.setAttribute("donation", donation);
                request.getRequestDispatcher("editdonationpage.jsp").forward(request, response);
            } else {
                response.sendRedirect("viewdonationspage.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewdonationspage.jsp");
        }
    }
}
