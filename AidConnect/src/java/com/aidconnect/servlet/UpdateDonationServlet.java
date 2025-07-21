package com.aidconnect.servlet;

import com.aidconnect.dao.DonationDAO;
import com.aidconnect.model.Donation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/UpdateDonationServlet")
public class UpdateDonationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int donationId = Integer.parseInt(request.getParameter("donation_id"));
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int quantity = Integer.parseInt(request.getParameter("amount"));
            Date donationDate = Date.valueOf(request.getParameter("donationDate"));

            Donation donation = new Donation();
            donation.setDonationId(donationId);
            donation.setProductId(productId);
            donation.setQuantity(quantity);
            donation.setDonationDate(donationDate);

            DonationDAO dao = new DonationDAO();
            boolean success = dao.updateDonation(donation);

            if (success) {
                response.sendRedirect("viewdonationspage.jsp?update=success");
            } else {
                response.sendRedirect("viewdonationspage.jsp?update=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewdonationspage.jsp?update=error");
        }
    }
}
