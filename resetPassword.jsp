<%@ page import="java.sql.*" %>

<%
    String newPassword = request.getParameter("password");
    String email = (String) session.getAttribute("resetEmail");

    if (newPassword != null && email != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            
            String url = "jdbc:mysql://localhost:3306/movies";
            String user = "root";
            String pass = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pass);

            
            String updateSql = "UPDATE reg SET password = ? WHERE email = ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setString(1, newPassword);
            pstmt.setString(2, email);
            pstmt.executeUpdate();

            out.println("<script>alert('Password reset successfully. Please sign in.');</script>");
            response.sendRedirect("signin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reset Password</title>
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
            font-family: 'Poppins', sans-serif;
        }

        .reset-form {
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

        .reset-form h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .reset-form input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: none;
            border-bottom: 1px solid #ccc;
            background-color: transparent;
            color: #fff;
        }

        .reset-form button {
            background-color: #663390;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 20px;
            width: 100%;
            font-weight: bold;
        }

        .reset-form button:hover {
            background-color: #522a8d;
        }
    </style>
</head>
<body>
    <form class="reset-form" action="resetPassword.jsp" method="post">
        <h2>Reset Password</h2>
        <input type="password" name="password" placeholder="Enter new password" required>
        <button type="submit">Reset Password</button>
    </form>
</body>
</html>
