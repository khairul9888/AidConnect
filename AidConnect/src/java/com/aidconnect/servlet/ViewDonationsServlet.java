package com.aidconnect.servlet;

import com.aidconnect.dao.DonationDAO;
import com.aidconnect.model.Donation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/ViewDonationsServlet")
public class ViewDonationsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DonationDAO dao = new DonationDAO();
        List<Donation> donations = dao.getAllDonations();

        Set<Integer> linkedDonationIds = new HashSet<>();
        for (Donation d : donations) {
            if (dao.hasDispatches(d.getDonationId())) {
                linkedDonationIds.add(d.getDonationId());
            }
        }

        request.setAttribute("donationList", donations);
        request.setAttribute("linkedDonationIds", linkedDonationIds);
        request.getRequestDispatcher("viewdonationspage.jsp").forward(request, response);
    }
}
