<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
    
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            
            String url = "jdbc:mysql://localhost:3306/movies";
            String user = "root";
            String pass = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pass);

            
            String checkSql = "SELECT COUNT(*) FROM reg WHERE email = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            rs.next();
            int count = rs.getInt(1);

                if (count > 0) {
                out.println("<script>alert('Email already registered. Please use a different email.');");
                out.println("window.location.href = 'register.jsp';</script>");
                }
                 else {
                
                int otp = new Random().nextInt(900000) + 100000;

               
                session.setAttribute("otp", otp);
                session.setAttribute("tempEmail", email);
                session.setAttribute("tempPassword", password);

                
                final String senderEmail = "cineflickcinemasl@gmail.com";
                final String senderPassword = "ibhw iqjj lqov zzat"; 
                String host = "smtp.gmail.com";

                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", host);
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
                    message.setSubject("Your OTP for Registration");
                    message.setContent("<html><body>" +
                            "<h2>Your OTP for Registration</h2>" +
                            "<p style='font-size:16px;'>Your OTP is: <b>" + otp + "</b></p>" +
                            "<p>Please use this OTP to complete your registration.</p>" +
                            "<p>Thank you for choosing CineFlick Cinemas!</p>" +
                            "</body></html>", "text/html");

                    Transport.send(message);

                    
                    response.sendRedirect("validateOTP.jsp");
                } catch (MessagingException e) {
                    e.printStackTrace();
                    out.println("<script>alert('Error sending OTP. Please try again.');</script>");
                }
            }
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineFlick Registration</title>
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
            margin-left: 20px;
            margin-right: 20px;
        }

        .register-form a {
            color: #fff;
            text-decoration: none;
            display: block;
            text-align: center;
            margin-top: 10px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .button-container button {
            background-color: #663390;
            color: white;
            border: none;
            padding: 12px 24px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 20px;
            font-weight: bold;
            width: 150px;
        }

        .button-container button:hover {
            background-color: #522a8d;
        }
    </style>
</head>

<body>
    <div class="register-form">
        <h2>REGISTER</h2>
        <form action="register.jsp" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Register</button>
            <button class="admin" onclick="window.location.href='adminlogin.jsp'">Admin</button>
            <button class="signin" onclick="window.location.href='signin.jsp'">Sign In</button>
        </form>
    </div>
</body>
</html>
