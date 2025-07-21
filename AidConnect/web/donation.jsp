<%@ page import="java.sql.*, com.aidconnect.db.DBConnection" %>
<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (session.getAttribute("user_id") instanceof Integer)
               ? (Integer) session.getAttribute("user_id")
               : Integer.parseInt(session.getAttribute("user_id").toString());
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Donation - AidConnect</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f4f9fb;
    }

    .container {
      max-width: 600px;
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

    form input, form select {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border-radius: 6px;
      border: 1px solid #ccc;
      font-size: 14px;
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
    }
    .back-btn:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>

  <div class="container">
    <a href="dashboard.jsp" class="back-btn">Back to Dashboard</a>
    <h2>Make a Donation</h2>
    
    <form action="DonationServlet" method="post">

      <label for="product_id">Select Product</label>
      <select id="product_id" name="product_id" required>
        <option value="">-- Select Product --</option>
        <%
          Connection conn = DBConnection.getConnection();
          PreparedStatement ps = conn.prepareStatement("SELECT product_id, product_name FROM Product");
          ResultSet rs = ps.executeQuery();
          while (rs.next()) {
        %>
          <option value="<%= rs.getInt("product_id") %>"><%= rs.getString("product_name") %></option>
        <%
          }
          conn.close();
        %>
      </select>

      <label for="quantity">Quantity</label>
      <input type="number" id="quantity" name="quantity" required />

      <label for="donationDate">Donation Date</label>
      <input type="date" id="donationDate" name="donationDate" required />

      <button type="submit" class="submit-btn">Submit Donation</button>
    </form>
  </div>

</body>
</html>
