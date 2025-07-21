<%@ page import="java.util.Date" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String fullName = (String) session.getAttribute("full_name");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Submit Feedback - AidConnect</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f2f6fa;
      margin: 0;
      padding: 0;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      padding-top: 50px;
    }

    .container {
      max-width: 600px;
      background: white;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.05);
    }

    h2 {
      text-align: center;
      color: #2c3e50;
      margin-bottom: 30px;
    }

    p {
      text-align: center;
      font-size: 16px;
      color: #333;
      margin-bottom: 30px;
    }

    label {
      display: block;
      font-weight: bold;
      margin-bottom: 8px;
      color: #333;
    }

    textarea {
      width: 100%;
      min-height: 140px;
      padding: 12px;
      border-radius: 6px;
      border: 1px solid #ccc;
      font-size: 14px;
      resize: vertical;
      font-family: inherit;
    }

    button {
      margin-top: 20px;
      width: 100%;
      background-color: #3498db;
      color: white;
      border: none;
      padding: 14px 0;
      font-size: 16px;
      border-radius: 6px;
      cursor: pointer;
      font-weight: bold;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #2980b9;
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
    .back-btn:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>

  <div class="container">
    <a href="dashboard.jsp" class="back-btn">Back to Dashboard</a>
    <h2>Feedback Form</h2>
    <p>Hello <strong><%= fullName %></strong>, we value your feedback!</p>
    <form action="FeedbackServlet" method="post">
      <label for="message">Your Feedback</label>
      <textarea id="message" name="message" required></textarea>
      <button type="submit">Submit Feedback</button>
    </form>
  </div>

</body>
</html>
