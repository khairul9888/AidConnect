<%
    session.invalidate(); // Clear session data
    response.sendRedirect("login.jsp"); // Redirect to login
%>
