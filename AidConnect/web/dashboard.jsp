<%@ page import="java.sql.*, java.util.*" %>
<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String fullName = (String) session.getAttribute("full_name");
    String role = (String) session.getAttribute("role");

    Connection conn = null;
    Map<String, Integer> productCounts = new LinkedHashMap<String, Integer>();
    Map<String, Integer> dispatchStatusCounts = new LinkedHashMap<String, Integer>();
    Map<String, Integer> donationDates = new TreeMap<String, Integer>();

    int totalDonation = 0;
    int totalDispatch = 0;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/aidconnectdb", "app", "app");

        String sqlTotalDonation = "SELECT SUM(quantity) AS total FROM donation";
        PreparedStatement psTotalDonation = conn.prepareStatement(sqlTotalDonation);
        ResultSet rsTotalDonation = psTotalDonation.executeQuery();
        if (rsTotalDonation.next()) {
            totalDonation = rsTotalDonation.getInt("total");
        }

        String sqlTotalDispatch = "SELECT COUNT(*) AS total FROM dispatch";
        PreparedStatement psTotalDispatch = conn.prepareStatement(sqlTotalDispatch);
        ResultSet rsTotalDispatch = psTotalDispatch.executeQuery();
        if (rsTotalDispatch.next()) {
            totalDispatch = rsTotalDispatch.getInt("total");
        }

        String sql1 = "SELECT p.product_name, COUNT(*) AS total FROM donation d JOIN product p ON d.product_id = p.product_id GROUP BY p.product_name";
        PreparedStatement ps1 = conn.prepareStatement(sql1);
        ResultSet rs1 = ps1.executeQuery();
        while (rs1.next()) {
            productCounts.put(rs1.getString("product_name"), rs1.getInt("total"));
        }

        String sql2 = "SELECT status, COUNT(*) AS total FROM dispatch GROUP BY status";
        PreparedStatement ps2 = conn.prepareStatement(sql2);
        ResultSet rs2 = ps2.executeQuery();
        while (rs2.next()) {
            dispatchStatusCounts.put(rs2.getString("status"), rs2.getInt("total"));
        }

        String sql3 = "SELECT donation_date, COUNT(*) AS total FROM donation GROUP BY donation_date ORDER BY donation_date";
        PreparedStatement ps3 = conn.prepareStatement(sql3);
        ResultSet rs3 = ps3.executeQuery();
        while (rs3.next()) {
            donationDates.put(rs3.getString("donation_date"), rs3.getInt("total"));
        }

        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>AidConnect Dashboard</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: #eef5f9;
      margin: 0;
      padding: 0;
    }
    .header {
      background: linear-gradient(135deg, #1976d2, #26a69a);
      color: white;
      padding: 20px 40px;
      position: relative;
      text-align: center;
    }
    .header h1 {
      margin: 0;
    }
    .user-info, .logout-btn {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
    }
    .user-info {
      right: 180px;
      color: #d0f0ef;
    }
    .logout-btn {
      right: 40px;
      background-color: #e74c3c;
      color: white;
      padding: 10px 16px;
      border: none;
      border-radius: 8px;
      font-weight: bold;
      cursor: pointer;
    }

    .layout {
      display: flex;
      min-height: calc(100vh - 80px);
    }

    .sidebar {
      width: 220px;
      background-color: #ffffff;
      border-right: 1px solid #ddd;
      padding: 30px 20px;
      box-shadow: 2px 0 10px rgba(0,0,0,0.05);
      position: fixed;
      top: 83px;
      left: 0;
      bottom: 0;
      overflow-y: auto;
    }

    .sidebar h3 {
      color: #1976d2;
      margin-bottom: 20px;
      font-size: 18px;
    }

    .sidebar a {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 16px;
      padding: 10px 14px;
      background-color: #f1f5f9;
      color: #333;
      text-decoration: none;
      border-left: 4px solid transparent;
      border-radius: 6px;
      font-weight: 500;
      transition: all 0.2s ease;
    }

    .sidebar a:hover {
      background-color: #e3edf8;
      border-left: 4px solid #1976d2;
      color: #1976d2;
    }

    .main-content {
      margin-left: 260px;
      padding: 40px 30px;
      min-height: calc(100vh - 80px);
      display: flex;
      flex-direction: column;
      align-items: center;  /* center horizontally */
      justify-content: flex-start;
      width: 100%;
      max-width: 960px;
      margin-right: auto;
      margin-left: auto;
    }

    .summary-cards {
      display: flex;
      gap: 30px;
      justify-content: center;
      margin-bottom: 40px;
      width: 100%;
      flex-wrap: wrap;
    }

    .summary-card {
      flex: 1 1 250px;
      background: #fff;
      padding: 25px 30px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
      text-align: center;
      min-width: 230px;
      max-width: 320px;
    }

    .summary-card h3 {
      margin-bottom: 15px;
      font-weight: 600;
      color: #222;
    }

    .summary-card .number {
      font-size: 32px;
      font-weight: 700;
      color: #1976d2;
    }

    .charts {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 30px;
      justify-content: center;
      width: 100%;
    }

    .chart-box {
      background: #fff;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
      width: 100%;
      max-width: 280px;
      text-align: center;
      min-width: 280px;
    }
  </style>
</head>
<body>
  <div class="header">
    <h1>Welcome To AidConnect</h1>
    <div class="user-info">Logged in as: <strong><%= fullName %></strong> (<%= role %>)</div>
    <form action="logout.jsp" method="post" style="display:inline;">
      <button class="logout-btn">Logout</button>
    </form>
  </div>

  <div class="layout">

    <!-- Sidebar -->
    <div class="sidebar">
      <h3>Our Menu</h3>
      <a href="donation.jsp"><span>Make a Donation</span></a>
      <a href="ViewDonationsServlet"><span>Donation Records</span></a>
      <a href="dispatch.jsp"><span>Create Dispatch</span></a>
      <a href="viewdispatchpage.jsp"><span>Dispatch Records</span></a>
      <a href="feedback.jsp"><span>Feedback</span></a>
    </div>

    <!-- Main Content -->
    <div class="main-content">

      <div class="summary-cards">
        <div class="summary-card">
          <h3>Total Donation Received</h3>
          <div class="number"><%= totalDonation %></div>
        </div>
        <div class="summary-card">
          <h3>Total Dispatches Made</h3>
          <div class="number"><%= totalDispatch %></div>
        </div>
      </div>

      <div class="charts">
        <div class="chart-box">
          <h3>Top Donated Products</h3>
          <canvas id="productChart"></canvas>
        </div>
        <div class="chart-box">
          <h3>Dispatch Status</h3>
          <canvas id="statusChart"></canvas>
        </div>
        <div class="chart-box">
          <h3>Donations by Date</h3>
          <canvas id="donationDateChart"></canvas>
        </div>
      </div>

    </div>

  </div>

<script>
  // Product Chart
  new Chart(document.getElementById('productChart'), {
    type: 'pie',
    data: {
      labels: [<% for(String key : productCounts.keySet()) { %> "<%= key %>", <% } %>],
      datasets: [{
        data: [<% for(Integer val : productCounts.values()) { %> <%= val %>, <% } %>],
        backgroundColor: ['#42a5f5','#66bb6a','#ffa726','#ab47bc','#ef5350','#8e44ad','#16a085','#f39c12']
      }]
    }
  });

  // Dispatch Status
  new Chart(document.getElementById('statusChart'), {
    type: 'pie',
    data: {
      labels: [<% for(String key : dispatchStatusCounts.keySet()) { %> "<%= key %>", <% } %>],
      datasets: [{
        data: [<% for(Integer val : dispatchStatusCounts.values()) { %> <%= val %>, <% } %>],
        backgroundColor: ['#26a69a', '#ef5350', '#ffee58', '#3498db', '#e67e22']
      }]
    }
  });

  // Donations by Date
  new Chart(document.getElementById('donationDateChart'), {
    type: 'bar',
    data: {
      labels: [<% for(String key : donationDates.keySet()) { %> "<%= key %>", <% } %>],
      datasets: [{
        label: 'Donations',
        data: [<% for(Integer val : donationDates.values()) { %> <%= val %>, <% } %>],
        backgroundColor: '#42a5f5'
      }]
    },
    options: {
      scales: {
        y: { beginAtZero: true }
      }
    }
  });
</script>
</body>
</html>
