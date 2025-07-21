<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>AidConnect - Login</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #3a9bdc 0%, #45c67d 100%);
      color: #333;
      margin: 0;
      padding: 0;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .container {
      background-color: #ffffffdd;
      padding: 40px 30px;
      border-radius: 12px;
      width: 400px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    }

    h1 {
      text-align: center;
      color: #2a5d8f;
      margin-bottom: 25px;
      font-weight: 700;
      letter-spacing: 1.2px;
    }

    form label {
      display: block;
      margin: 15px 0 6px 0;
      font-weight: 600;
      color: #2a5d8f;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 12px 14px;
      border: 2px solid #a0c6f0;
      border-radius: 6px;
      font-size: 16px;
      transition: border-color 0.3s ease;
    }

    input:focus {
      outline: none;
      border-color: #45c67d;
      box-shadow: 0 0 8px rgba(69, 198, 125, 0.6);
    }

    button {
      margin-top: 25px;
      width: 100%;
      background-color: #45c67d;
      color: white;
      font-weight: 700;
      font-size: 18px;
      padding: 14px 0;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      letter-spacing: 1.1px;
      transition: background-color 0.3s ease;
    }

    button:hover {
      background-color: #3a9bdc;
    }

    .register-link {
      margin-top: 20px;
      display: block;
      text-align: center;
      font-size: 15px;
      color: #2a5d8f;
      text-decoration: none;
      font-weight: 600;
    }

    .register-link:hover {
      text-decoration: underline;
    }

    .input-group {
      position: relative;
    }

    .input-group svg {
      position: absolute;
      top: 50%;
      left: 12px;
      transform: translateY(-50%);
      fill: #45c67d;
      width: 20px;
      height: 20px;
      pointer-events: none;
    }

    input.with-icon {
      padding-left: 40px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>AidConnect Login</h1>
    <% if (request.getParameter("error") != null) { %>
  <p style="color: red; text-align:center;">Invalid login credentials. Try again.</p>
<% } %>
    <form action="LoginServlet" method="post">
      <label for="username">Email</label>
      <div class="input-group">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 12c2.7 0 4.9-2.2 4.9-4.9S14.7 2.2 12 2.2 7.1 4.4 7.1 7.1 9.3 12 12 12zM12 14.1c-3.1 0-9.3 1.5-9.3 4.7v2.2h18.5v-2.2c0-3.2-6.2-4.7-9.2-4.7z"/></svg>
        <input type="text" id="username" name="username" class="with-icon" required placeholder="Enter your username" />
      </div>

      <label for="password">Password</label>
      <div class="input-group">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M17 8V7a5 5 0 00-10 0v1H6a2 2 0 00-2 2v7a2 2 0 002 2h12a2 2 0 002-2v-7a2 2 0 00-2-2h-1zm-6 0V7a3 3 0 016 0v1H11z"/></svg>
        <input type="password" id="password" name="password" class="with-icon" required placeholder="Enter your password" />
      </div>

      <button type="submit">Login</button>
    </form>
    <a href="register.jsp" class="register-link">Don't have an account? Register</a>
  </div>
</body>
</html>
