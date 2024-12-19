<%@ page session="true" %>
<%
    String adminEmail = "admin@gmail.com"; 
    String adminPassword = "123"; 

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null) {
        if (email.equals(adminEmail) && password.equals(adminPassword)) {
            session.setAttribute("admin", true);
            response.sendRedirect("admin.jsp");
        } else {
            out.println("<script>alert('Invalid credentials!');</script>");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #111;
            color: white;
            background-image: url('img/bg.jpg');
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-form {
            background-color: #000;
            color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            width: 400px;
            box-shadow: 0 0 15px rgba(127, 129, 129, 0.7);
        }

        .login-form h1 {
            text-align: center;
            margin-bottom: 20px;
            font-family: 'Poppins', sans-serif;
            font-size: 24px;
        }

        .login-form input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: none;
            border-bottom: 1px solid #ccc;
            background-color: transparent;
            color: #fff;
            font-size: 16px;
        }

        .login-form button {
            background-color: #663390;
            color: #fff;
            border: none;
            padding: 12px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 20px;
            width: 100%;
            transition: background-color 0.3s;
        }

        .login-form button:hover {
            background-color: #522a8d;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .button-container button {
            width: 48%;
        }
    </style>
</head>
<body>
    <div class="login-form">
        <h1>Admin Login</h1>
        <form method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
