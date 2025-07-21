package com.aidconnect.servlet;

import com.aidconnect.dao.DonationDAO;
import com.aidconnect.model.Donation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewDonationsServlet")
public class ViewDonationsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fix: Instantiate DonationDAO
        DonationDAO dao = new DonationDAO();
        List<Donation> donations = dao.getAllDonations(); // call method on the object

        request.setAttribute("donationList", donations);
        request.getRequestDispatcher("viewdonationspage.jsp").forward(request, response);
    }
}
