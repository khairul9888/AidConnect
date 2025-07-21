package com.aidconnect.servlet;

import com.aidconnect.dao.DonationDAO;
import com.aidconnect.model.Donation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/DonationServlet")
public class DonationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int userId = (int) session.getAttribute("user_id"); // safer way
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            Date donationDate = Date.valueOf(request.getParameter("donationDate"));

            Donation donation = new Donation();
            donation.setUserId(userId);
            donation.setProductId(productId);
            donation.setQuantity(quantity);
            donation.setDonationDate(donationDate);

            DonationDAO dao = new DonationDAO();
            boolean inserted = dao.insertDonation(donation);

            if (inserted) {
                response.sendRedirect("ViewDonationsServlet?success=1");
            } else {
                response.sendRedirect("donation.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("donation.jsp?error=2");
        }
    }
}
