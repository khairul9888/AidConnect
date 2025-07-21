<%@ page import="java.util.List" %>
<%@ page import="com.aidconnect.model.Donation" %>
<%@ page import="java.sql.*, com.aidconnect.db.DBConnection" %>

<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Donation donation = (Donation) request.getAttribute("donation");
    if (donation == null) {
        response.sendRedirect("viewdonationspage.jsp");
        return;
    }

    int donationId = donation.getDonationId();
    int productId = donation.getProductId();
    int quantity = donation.getQuantity();
    java.sql.Date donationDate = donation.getDonationDate();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Donation</title>
  <style>
    body {
      font-family: Arial;
      background: #f9f9f9;
      padding: 40px;
    }
    .form-container {
      background: white;
      padding: 30px;
      border-radius: 10px;
      max-width: 500px;
      margin: auto;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
    }
    input, select {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border-radius: 6px;
      border: 1px solid #ccc;
    }
    button {
      margin-top: 25px;
      width: 100%;
      padding: 12px;
      background: #27ae60;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      cursor: pointer;
    }
  </style>
</head>
<body>
  <div class="form-container">
    <h2>Edit Donation</h2>
    <form action="UpdateDonationServlet" method="post">
      <input type="hidden" name="donation_id" value="<%= donationId %>" />

      <label for="product_id">Product</label>
      <select name="product_id" id="product_id" required>
        <%
          Connection conn = DBConnection.getConnection();
          PreparedStatement ps = conn.prepareStatement("SELECT product_id, product_name FROM Product");
          ResultSet rs = ps.executeQuery();
          while (rs.next()) {
              int pid = rs.getInt("product_id");
              String pname = rs.getString("product_name");
        %>
          <option value="<%= pid %>" <%= (pid == productId) ? "selected" : "" %>><%= pname %></option>
        <%
          }
          conn.close();
        %>
      </select>

      <label for="amount">Quantity</label>
      <input type="number" name="amount" id="amount" value="<%= quantity %>" required />

      <label for="donationDate">Donation Date</label>
      <input type="date" name="donationDate" value="<%= donationDate %>" required />

      <button type="submit">Update Donation</button>
    </form>
  </div>
</body>
</html>
