<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>AidConnect - User Registration</title>
    <style>
        /* Reset */
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
            width: 420px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        h1 {
            text-align: center;
            color: #2a5d8f;
            margin-bottom: 20px;
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
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px 14px;
            border: 2px solid #a0c6f0;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #45c67d;
            box-shadow: 0 0 8px rgba(69, 198, 125, 0.6);
        }

        button {
            margin-top: 30px;
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

        .login-link {
            margin-top: 20px;
            display: block;
            text-align: center;
            font-size: 15px;
            color: #2a5d8f;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link:hover {
            text-decoration: underline;
        }

        /* Icon styling for inputs */
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

        input[type="text"].with-icon,
        input[type="email"].with-icon,
        input[type="password"].with-icon {
            padding-left: 40px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>AidConnect Registration</h1>
        <form action="RegisterServlet" method="post">
            <label for="fullname">Full Name</label>
            <div class="input-group">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 12c2.7 0 4.9-2.2 4.9-4.9S14.7 2.2 12 2.2 7.1 4.4 7.1 7.1 9.3 12 12 12zM12 14.1c-3.1 0-9.3 1.5-9.3 4.7v2.2h18.5v-2.2c0-3.2-6.2-4.7-9.2-4.7z"/></svg>
                <input type="text" id="fullname" name="fullname" class="with-icon" required placeholder="Enter your full name" />
            </div>

            <label for="email">Email Address</label>
            <div class="input-group">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/></svg>
                <input type="email" id="email" name="email" class="with-icon" required placeholder="Enter your email address" />
            </div>

            <label for="username">Username</label>
            <div class="input-group">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 12c2.7 0 4.9-2.2 4.9-4.9S14.7 2.2 12 2.2 7.1 4.4 7.1 7.1 9.3 12 12 12zM12 14.1c-3.1 0-9.3 1.5-9.3 4.7v2.2h18.5v-2.2c0-3.2-6.2-4.7-9.2-4.7z"/></svg>
                <input type="text" id="username" name="username" class="with-icon" required placeholder="Choose a username" />
            </div>

            <label for="password">Password</label>
            <div class="input-group">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M17 8V7a5 5 0 00-10 0v1H6a2 2 0 00-2 2v7a2 2 0 002 2h12a2 2 0 002-2v-7a2 2 0 00-2-2h-1zm-6 0V7a3 3 0 016 0v1H11z"/></svg>
                <input type="password" id="password" name="password" class="with-icon" required placeholder="Enter a password" />
            </div>

            <label for="confirm-password">Confirm Password</label>
            <div class="input-group">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M17 8V7a5 5 0 00-10 0v1H6a2 2 0 00-2 2v7a2 2 0 002 2h12a2 2 0 002-2v-7a2 2 0 00-2-2h-1zm-6 0V7a3 3 0 016 0v1H11z"/></svg>
                <input type="password" id="confirm-password" name="confirm-password" class="with-icon" required placeholder="Confirm your password" />
            </div>

            <button type="submit">Create Account</button>
        </form>
        <a href="login.jsp" class="login-link">Already have an account? Log in</a>
    </div>
</body>
</html>
