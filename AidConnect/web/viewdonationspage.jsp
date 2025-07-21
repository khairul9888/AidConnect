<%@ page import="java.util.List" %>
<%@ page import="com.aidconnect.model.Donation" %>
<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Donation> donationList = (List<Donation>) request.getAttribute("donationList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>AidConnect - View Donations</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet"/>
  <style>
    * {
      box-sizing: border-box;
      font-family: 'Inter', sans-serif;
    }
    body {
      margin: 0;
      padding: 0;
      background: #f2f6fa;
    }
    .container {
      max-width: 1100px;
      margin: 50px auto;
      background: #fff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
    }
    h2 {
      text-align: center;
      color: #2c3e50;
      margin-bottom: 30px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      padding: 12px 16px;
      border: 1px solid #e1e4e8;
      text-align: center;
    }
    th {
      background-color: #2980b9;
      color: white;
    }
    tr:nth-child(even) {
      background-color: #f9f9f9;
    }
    .btn {
      padding: 8px 14px;
      border: none;
      border-radius: 6px;
      font-weight: bold;
      cursor: pointer;
      text-decoration: none;
      display: inline-block;
    }
    .btn-edit {
      background-color: #27ae60;
      color: white;
    }
    .btn-delete {
      background-color: #e74c3c;
      color: white;
    }
    .btn-edit:hover {
      background-color: #219150;
    }
    .btn-delete:hover {
      background-color: #c0392b;
    }

    /* Unified Back button style */
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
    .back-btn:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Donation Records</h2>
    <a href="dashboard.jsp" class="back-btn">Back to Dashboard</a>
    <div style="background-color: #fff3cd; color: #856404; padding: 15px; border: 1px solid #ffeeba; border-radius: 6px; margin-bottom: 20px;">
      <strong>Note:</strong> Donations that are already linked to a dispatch <u>cannot be deleted</u>. Please delete the related dispatch record first if needed.
    </div>

    <table>
      <thead>
        <tr>
          <th>Donation ID</th>
          <th>Donor Name</th>
          <th>Item</th>
          <th>Quantity</th>
          <th>Date</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <%
          if (donationList != null && !donationList.isEmpty()) {
              for (Donation d : donationList) {
        %>
        <tr>
          <td><%= d.getDonationId() %></td>
          <td><%= d.getFullName() %></td>
          <td><%= d.getProductName() %></td>
          <td><%= d.getQuantity() %></td>
          <td><%= d.getDonationDate() %></td>
          <td>
            <a href="editdonationpage.jsp?id=<%= d.getDonationId() %>" class="btn btn-edit">Edit</a>
            <a href="DeleteDonationServlet?id=<%= d.getDonationId() %>" class="btn btn-delete" onclick="return confirm('Are you sure to delete this donation?');">Delete</a>
          </td>
        </tr>
        <%
              }
          } else {
        %>
        <tr>
          <td colspan="6" style="color: gray;">No donations found.</td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
</body>
</html>
