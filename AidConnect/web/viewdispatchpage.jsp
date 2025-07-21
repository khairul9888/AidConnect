<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>AidConnect - View Dispatches</title>
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
  </style>
</head>
<body>
  <div class="container">
    <h2>Dispatch Records</h2>

    <a href="dashboard.jsp" class="back-btn">Back to Dashboard</a>

    <table>
      <thead>
        <tr>
          <th>Dispatch ID</th>
          <th>Destination</th>
          <th>Item</th>
          <th>Quantity</th>
          <th>Dispatch Date</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
<%@ page import="java.sql.*, com.aidconnect.db.DBConnection" %>
<%
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT d.dispatch_id, d.destination, p.product_name, dn.quantity, d.dispatch_date, d.status " +
                     "FROM Dispatch d " +
                     "JOIN Donation dn ON d.donation_id = dn.donation_id " +
                     "JOIN Product p ON dn.product_id = p.product_id";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
%>
<tr>
    <td><%= rs.getInt("dispatch_id") %></td>
    <td><%= rs.getString("destination") %></td>
    <td><%= rs.getString("product_name") %></td>
    <td><%= rs.getInt("quantity") %></td>
    <td><%= rs.getDate("dispatch_date") %></td>
    <td><%= rs.getString("status") %></td>
    <td>
        <a href="editdispatchpage.jsp?id=<%= rs.getInt("dispatch_id") %>" class="btn btn-edit">Edit</a>
        <a href="DeleteDispatchServlet?id=<%= rs.getInt("dispatch_id") %>" class="btn btn-delete" onclick="return confirm('Are you sure to delete this dispatch?');">Delete</a>
    </td>
</tr>
<%
        }
        conn.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='7' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
      </tbody>
    </table>
  </div>
</body>
</html>
