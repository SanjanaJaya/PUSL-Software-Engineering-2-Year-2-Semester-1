<%@ page import="java.sql.*" %>

<%
    String userOtp = request.getParameter("otp");
    Integer sessionOtp = (Integer) session.getAttribute("otp");
    String email = (String) session.getAttribute("tempEmail");
    String password = (String) session.getAttribute("tempPassword");

    if (userOtp != null && sessionOtp != null) {
        if (userOtp.equals(String.valueOf(sessionOtp))) {
            String url = "jdbc:mysql://localhost:3306/movies";
            String user = "root";
            String pass = "";

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pass);

                String sql = "INSERT INTO reg (email, password) VALUES (?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, email);
                pstmt.setString(2, password);

                int rowsInserted = pstmt.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<script>alert('Registration successful!');</script>");
                    response.sendRedirect("home.jsp");
                } else {
                    out.println("<script>alert('Registration failed!');</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
            } finally {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }

            session.removeAttribute("otp");
            session.removeAttribute("tempEmail");
            session.removeAttribute("tempPassword");
        } else {
            out.println("<script>alert('Invalid OTP. Please try again.');</script>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Validate OTP</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
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
            font-family: 'Poppins', sans-serif;
        }

        .otp-form {
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

        .otp-form h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .otp-form input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: none;
            border-bottom: 1px solid #ccc;
            background-color: transparent;
            color: #fff;
        }

        .otp-form button {
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

        .otp-form button:hover {
            background-color: #522a8d;
        }
    </style>
</head>
<body>
    <div class="otp-form">
        <h2>Validate OTP</h2>
        <form action="validateOTP.jsp" method="post">
            <input type="text" name="otp" placeholder="Enter OTP" required>
            <button type="submit">Validate</button>
        </form>
    </div>
</body>
</html>
