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
  <title>Dispatch - AidConnect</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f4f9fb;
    }

    .navbar {
      background: linear-gradient(135deg, #3a9bdc, #45c67d);
      padding: 20px 30px;
      color: white;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    }

    .container {
      max-width: 650px;
      margin: 40px auto;
      background: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 25px;
      color: #2a5d8f;
    }

    form label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
      color: #333;
    }

    form input, form select, form textarea {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border-radius: 6px;
      border: 1px solid #ccc;
      font-size: 14px;
    }

    form textarea {
      resize: vertical;
      min-height: 80px;
    }

    .submit-btn {
      margin-top: 25px;
      width: 100%;
      padding: 12px;
      background: #3a9bdc;
      color: white;
      font-size: 16px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    .submit-btn:hover {
      background: #3182c4;
    }

    /* Back button style */
    .back-btn {
      display: inline-block;
      background-color: #3498db;
      color: white;
      text-decoration: none;
      padding: 10px 20px;
      border-radius: 6px;
      font-weight: bold;
      margin-bottom: 20px;
      margin-left: 30px;
    }
    .back-btn:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>

  <div class="navbar">
    <h1>AidConnect</h1>
  </div>

  <div class="container">
    <a href="dashboard.jsp" class="back-btn">Back to Dashboard</a>
    <h2>Dispatch Relief Supplies</h2>
    <form action="DispatchServlet" method="post">
      <label for="dispatchID">Dispatch ID</label>
      <input type="text" id="dispatchID" name="dispatchID" placeholder="e.g. D12345" required />

      <%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
      <label for="donationID">Related Donation</label>
      <select id="donationID" name="donationID" required>
        <option value="">-- Select Donation --</option>
        <%
          Connection conn = com.aidconnect.db.DBConnection.getConnection();
          PreparedStatement ps = conn.prepareStatement(
            "SELECT dn.donation_id, u.full_name, p.product_name " +
            "FROM Donation dn " +
            "JOIN Users u ON dn.user_id = u.user_id " +
            "JOIN Product p ON dn.product_id = p.product_id"
          );
          ResultSet rs = ps.executeQuery();
          while (rs.next()) {
        %>
          <option value="<%= rs.getInt("donation_id") %>">
            Donation #<%= rs.getInt("donation_id") %> - <%= rs.getString("product_name") %> by <%= rs.getString("full_name") %>
          </option>
        <%
          }
          conn.close();
        %>
      </select>

      <label for="destination">Destination</label>
      <input type="text" id="destination" name="destination" placeholder="Relief center / shelter name" required />

      <label for="dispatchedTo">Dispatched To</label>
      <input type="text" id="dispatchedTo" name="dispatchedTo" placeholder="NGO, person in charge, etc." required />

      <label for="status">Status</label>
      <select id="status" name="status" required>
        <option value="">-- Select Status --</option>
        <option value="Preparing">Preparing</option>
        <option value="In Transit">In Transit</option>
        <option value="Delivered">Delivered</option>
      </select>

      <label for="dispatchDate">Dispatch Date</label>
      <input type="date" id="dispatchDate" name="dispatchDate" required />

      <button type="submit" class="submit-btn">Submit Dispatch</button>
    </form>
  </div>

</body>
</html>
