<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="jakarta.servlet.*" %>

<%
    Integer sessionOtp = (Integer) session.getAttribute("otp");
    String enteredOtpParam = request.getParameter("otp");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Validate OTP</title>
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
    <form class="otp-form" action="validateOTPF.jsp" method="post">
        <h2>Enter OTP</h2>
        <input type="text" name="otp" placeholder="Enter the OTP sent to your email" required>
        <button type="submit">Validate OTP</button>
    </form>
    <% if (enteredOtpParam != null) {
        try {
            int enteredOtp = Integer.parseInt(enteredOtpParam);
            if (enteredOtp == sessionOtp) { 
                session.removeAttribute("otp");
                response.sendRedirect("resetPassword.jsp");
            } else {
                out.println("<script>alert('Invalid OTP. Please try again.');</script>");
            }
        } catch (NumberFormatException e) {
            out.println("<script>alert('Invalid OTP format. Please enter numbers only.');</script>");
        }
    } %>
</body>
</html>
