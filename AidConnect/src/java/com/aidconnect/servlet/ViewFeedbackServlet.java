package com.aidconnect.servlet;

import com.aidconnect.dao.FeedbackDAO;
import com.aidconnect.model.Feedback;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewFeedbackServlet")
public class ViewFeedbackServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null ||
            !"administrator".equals(session.getAttribute("role"))) {
            response.getWriter().println("Access denied. Administrator only.");
            return;
        }

        FeedbackDAO dao = new FeedbackDAO();
        List<Feedback> feedbackList = dao.getAllFeedback();

        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher("viewfeedback.jsp").forward(request, response);
    }
}
