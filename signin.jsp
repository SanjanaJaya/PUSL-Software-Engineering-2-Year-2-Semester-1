<%@ page import="java.sql.*" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/movies";
    String user = "root";
    String pass = "";

    boolean loginSuccess = false;

    if (email != null && password != null) {
        try (Connection conn = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM reg WHERE email = ? AND password = ?")) {

            Class.forName("com.mysql.cj.jdbc.Driver");
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    loginSuccess = true;
                    session.setAttribute("email", email);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
    }

    if (loginSuccess) {
        response.sendRedirect("home.jsp");
    } else if (email != null && password != null) {
        out.println("<script>alert('Invalid email or password. Please try again.');</script>");
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineFlick SignIn</title>
    <link rel="icon" href="C:\Users\vinuk\OneDrive\Desktop\All JAVA\Register - Dihansie\Icon.png" type="image/jpeg">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
             font-family: Poppins;
        }

        body {
            background-color: #111;
            color: white;
            background-image: url('img/bg.jpg');
            background-size: cover; 
        }

        .header {
            background-color: #f5f5f5;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            width: 120px;
            display: flex;
            align-items: center;
            gap: 10px;
            color: #333;
            text-decoration: none;
        }

        .logo img {
            width: 197px;
            height: 75px;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            list-style: none;
        }

        .nav-links a {
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }

        .auth-buttons {
            display: flex;
            gap: 1rem;
        }

        .auth-buttons button {
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
        }

        .sign-in {
            background-color: #333;
            color: white;
            border: none;
            border-radius: 20px; 
            padding: 8px 16px; 
            display: flex;
            align-items: center;
            gap: 8px; 
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }
        .sign-in .icon {
            font-size: 18px;
        }

        .register {
            border: 1px solid #000000;
            font-weight: bold;
        }

        .register-form {
            background-color: #000;
            color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 550px;
            box-shadow: 0 0 15px rgba(127, 129, 129, 0.7);
        }

        .register-form h2 {
            text-align: center;
            margin-bottom: 45px;
        }

        .register-form input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: none;
            border-bottom: 1px solid #ccc;
            background-color: transparent;
            color: #fff;
        }

        .register-form button {
            background-color: #663390;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: 2px solid #663390; 
            border-radius: 20px;
            margin-top: 50px;
            margin-left: 170px;
            margin-right: 100px;
        }

        .register-form a {
            color: #fff;
            text-decoration: none;
            display: block;
            text-align: center;
            margin-top: 10px;
        }

        .forgot-password {
         position: absolute;
         left: 40px;
         font-size: 12px;
          text-decoration: none;
          color: #ffffff;
          margin-bottom: 50px;
        }

         .forgot-password:hover {
               text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="register-form">
        <h2>SIGN IN</h2>
        <form action="signin.jsp" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <a href="forgotPassword.jsp" class="forgot-password">Forgot Password?</a>
            <button type="submit">Sign In</button>
        </form>
    </div>
</body>
</html>

