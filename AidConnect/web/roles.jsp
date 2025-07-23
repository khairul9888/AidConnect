<%@ page import="java.sql.*, com.aidconnect.db.DBConnection" %>
<%
    // Check if logged in and admin role
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String role = (String) session.getAttribute("role");
    if (!"administrator".equals(role)) {
        response.getWriter().println("Access denied. Administrator only.");
        return;
    }

    String updateStatus = request.getParameter("update");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Roles and Permissions - AidConnect</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet"/>
  <style>
    body {
      font-family: 'Inter', sans-serif;
      background: #f2f6fa;
      margin: 0; padding: 0;
    }
    .container {
      max-width: 900px;
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
    select {
      padding: 6px 10px;
      border-radius: 6px;
      border: 1px solid #ccc;
      font-size: 14px;
    }
    .btn-save {
      margin-top: 20px;
      background-color: #2980b9;
      color: white;
      padding: 10px 18px;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      float: right;
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
    .message {
      text-align: center;
      padding: 10px;
      margin-bottom: 20px;
      border-radius: 6px;
      font-weight: 600;
    }
    .success {
      background-color: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }
    .fail {
      background-color: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Roles and Permissions</h2>
    <a href="dashboard.jsp" class="back-btn">Back to Dashboard</a>

    <% if ("success".equals(updateStatus)) { %>
      <div class="message success">Roles updated successfully.</div>
    <% } else if ("fail".equals(updateStatus)) { %>
      <div class="message fail">Failed to update roles. Please try again.</div>
    <% } %>

    <form action="UpdateRolesServlet" method="post">
      <table>
        <thead>
          <tr>
            <th>User ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Role</th>
          </tr>
        </thead>
        <tbody>
          <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
              Class.forName("org.apache.derby.jdbc.ClientDriver");
              conn = DBConnection.getConnection();
              String sql = "SELECT user_id, full_name, email, role FROM Users ORDER BY full_name";
              ps = conn.prepareStatement(sql);
              rs = ps.executeQuery();
              while (rs.next()) {
                int userId = rs.getInt("user_id");
                String fullName = rs.getString("full_name");
                String email = rs.getString("email");
                String userRole = rs.getString("role");
          %>
          <tr>
            <td><%= userId %></td>
            <td><%= fullName %></td>
            <td><%= email %></td>
            <td>
              <select name="role_<%= userId %>">
                <option value="donor" <%= "donor".equals(userRole) ? "selected" : "" %>>Donor</option>
                <option value="administrator" <%= "administrator".equals(userRole) ? "selected" : "" %>>Administrator</option>
              </select>
            </td>
          </tr>
          <%      }
            } catch (Exception e) {
              out.println("<tr><td colspan='4' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
              if (rs != null) rs.close();
              if (ps != null) ps.close();
              if (conn != null) conn.close();
            }
          %>
        </tbody>
      </table>
      <button class="btn-save" type="submit">Save Changes</button>
    </form>
  </div>
</body>
</html>
