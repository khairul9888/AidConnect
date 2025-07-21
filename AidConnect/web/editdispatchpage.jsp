<%@ page import="java.sql.*, com.aidconnect.db.DBConnection" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendRedirect("viewdispatchpage.jsp");
        return;
    }

    int dispatchId = Integer.parseInt(idStr);
    String destination = "", handledBy = "", status = "";
    java.sql.Date dispatchDate = null;
    int donationId = 0;

    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM Dispatch WHERE dispatch_id = ?");
    ps.setInt(1, dispatchId);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        destination = rs.getString("destination");
        handledBy = rs.getString("handled_by");
        status = rs.getString("status");
        dispatchDate = rs.getDate("dispatch_date");
        donationId = rs.getInt("donation_id");
    } else {
        conn.close();
        response.sendRedirect("viewdispatchpage.jsp");
        return;
    }
    conn.close();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Dispatch</title>
  <style>
    body { font-family: Arial; background: #f9f9f9; padding: 40px; }
    .form-container { background: white; padding: 30px; border-radius: 10px; max-width: 500px; margin: auto; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
    label { display: block; margin-top: 15px; font-weight: bold; }
    input, select { width: 100%; padding: 10px; margin-top: 5px; border-radius: 6px; border: 1px solid #ccc; }
    button { margin-top: 25px; width: 100%; padding: 12px; background: #2980b9; color: white; border: none; border-radius: 6px; font-size: 16px; }
  </style>
</head>
<body>
  <div class="form-container">
    <h2>Edit Dispatch</h2>
    <form action="UpdateDispatchServlet" method="post">
      <input type="hidden" name="dispatch_id" value="<%= dispatchId %>" />

      <label>Destination</label>
      <input type="text" name="destination" value="<%= destination %>" required />

      <label>Dispatched To</label>
      <input type="text" name="dispatchedTo" value="<%= handledBy %>" required />

      <label>Status</label>
      <select name="status" required>
        <option value="">-- Select --</option>
        <option value="Preparing" <%= "Preparing".equals(status) ? "selected" : "" %>>Preparing</option>
        <option value="In Transit" <%= "In Transit".equals(status) ? "selected" : "" %>>In Transit</option>
        <option value="Delivered" <%= "Delivered".equals(status) ? "selected" : "" %>>Delivered</option>
      </select>

      <label>Dispatch Date</label>
      <input type="date" name="dispatchDate" value="<%= dispatchDate %>" required />

      <button type="submit">Update Dispatch</button>
    </form>
  </div>
</body>
</html>
