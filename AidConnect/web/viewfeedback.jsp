<%@ page import="java.util.List" %>
<%@ page import="com.aidconnect.model.Feedback" %>
<%
    if (session == null || session.getAttribute("user_id") == null ||
        !"administrator".equals(session.getAttribute("role"))) {
        response.getWriter().println("Access denied. Administrator only.");
        return;
    }

    List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Feedback Records - AidConnect</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f9f9f9;
      margin: 0; padding: 0;
    }
    .container {
      max-width: 900px;
      margin: 50px auto;
      background: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    h2 {
      text-align: center;
      margin-bottom: 25px;
      color: #2a5d8f;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      padding: 12px 16px;
      border: 1px solid #ddd;
      text-align: left;
    }
    th {
      background-color: #2980b9;
      color: white;
    }
    tr:nth-child(even) {
      background-color: #f9f9f9;
    }
    .back-btn {
      display: inline-block;
      background-color: #3498db;
      color: white;
      text-decoration: none;
      padding: 10px 20px;
      border-radius: 6px;
      font-weight: bold;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Feedback Records</h2>
    <a href="dashboard.jsp" class="back-btn">Back to Dashboard</a>

    <table>
      <thead>
        <tr>
          <th>Feedback ID</th>
          <th>User</th>
          <th>Message</th>
          <th>Submitted At</th>
        </tr>
      </thead>
      <tbody>
        <%
          if (feedbackList != null && !feedbackList.isEmpty()) {
              for (Feedback fb : feedbackList) {
        %>
        <tr>
          <td><%= fb.getFeedbackId() %></td>
          <td><%= fb.getUserFullName() %></td>
          <td><%= fb.getMessage() %></td>
          <td><%= fb.getSubmittedAt() %></td>
        </tr>
        <%
              }
          } else {
        %>
        <tr>
          <td colspan="4" style="text-align:center; color:gray;">No feedback found.</td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
</body>
</html>
