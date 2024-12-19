<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
    String email = request.getParameter("email");
    if (email != null) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movies", "root", "");
             PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(*) FROM reg WHERE email = ?")) {

            Class.forName("com.mysql.cj.jdbc.Driver");
            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                rs.next();
                if (rs.getInt(1) == 0) {
                    out.println("<script>alert('Email not registered. Please try again.');</script>");
                } else {
                    int otp = new Random().nextInt(900000) + 100000;
                    session.setAttribute("otp", otp);
                    session.setAttribute("resetEmail", email);

                    final String senderEmail = "cineflickcinemasl@gmail.com";
                    final String senderPassword = "ibhw iqjj lqov zzat";

                    Properties props = new Properties();
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.starttls.enable", "true");
                    props.put("mail.smtp.host", "smtp.gmail.com");
                    props.put("mail.smtp.port", "587");

                    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(senderEmail, senderPassword);
                        }
                    });

                    try {
                        Message message = new MimeMessage(mailSession);
                        message.setFrom(new InternetAddress(senderEmail));
                        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                        message.setSubject("Password Reset OTP");
                        message.setContent("<h3>Your OTP for resetting your password is: <b>" + otp + "</b></h3>", "text/html");
                        Transport.send(message);
                        response.sendRedirect("validateOTPF.jsp");
                    } catch (MessagingException e) {
                        e.printStackTrace();
                        out.println("<script>alert('Error sending OTP. Please try again.');</script>");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Forgot Password</title>
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
    <form class="otp-form" action="forgotPassword.jsp" method="post">
        <h2>Forgot Password</h2>
        <input type="email" name="email" placeholder="Enter your registered email" required>
        <button type="submit">Send OTP</button>
    </form>
</body>
</html>
