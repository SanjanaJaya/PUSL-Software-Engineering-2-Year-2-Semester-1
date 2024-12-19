<%@ page import="java.sql.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>

<%
    
    String userEmail = (String) session.getAttribute("email");

    if (userEmail == null) {
        response.sendRedirect("signin.jsp");
        return;
    }

    
    String hall = request.getParameter("hall");
    String movie = request.getParameter("movie");
    String showtime = request.getParameter("showtime");
    String seatno = request.getParameter("seatno");
    String date = request.getParameter("date");

    
    if (date == null || date.isEmpty()) {
        out.println("<script>alert('Date is required. Please select a valid date.');</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movies", "root", "");

        
        String checkSQL = "SELECT * FROM ticketbook WHERE hall = ? AND movie = ? AND showtime = ? AND seatno = ? AND date = ?";
        pstmt = conn.prepareStatement(checkSQL);
        pstmt.setString(1, hall);
        pstmt.setString(2, movie);
        pstmt.setString(3, showtime);
        pstmt.setString(4, seatno);
        pstmt.setDate(5, java.sql.Date.valueOf(date));  
        rs = pstmt.executeQuery();

        if (rs.next()) {
            
            out.println("<script>alert('This seat is already booked in this hall and showtime. Please select a different seat or hall.');</script>");
        } else {
            
            String insertSQL = "INSERT INTO ticketbook (email, hall, movie, showtime, seatno, date) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSQL);
            pstmt.setString(1, userEmail);
            pstmt.setString(2, hall);
            pstmt.setString(3, movie);
            pstmt.setString(4, showtime);
            pstmt.setString(5, seatno);
            pstmt.setDate(6, java.sql.Date.valueOf(date));  
            pstmt.executeUpdate();

           
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

            Message message = new MimeMessage(mailSession);
message.setFrom(new InternetAddress(senderEmail));
message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
message.setSubject("Your Booking Confirmation");


String htmlContent = "<!DOCTYPE html>"
        + "<html lang='en'>"
        + "<head>"
        + "    <style>"
        + "        body {"
        + "            font-family: Arial, sans-serif;"
        + "            margin: 0;"
        + "            padding: 0;"
        + "            background-color: #f5f5f5;"
        + "            color: #333;"
        + "        }"
        + "        .container {"
        + "            max-width: 600px;"
        + "            margin: 20px auto;"
        + "            background: #fff;"
        + "            border-radius: 8px;"
        + "            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);"
        + "            overflow: hidden;"
        + "        }"
        + "        .header {"
        + "            background-color: #663390;"
        + "            color: #fff;"
        + "            text-align: center;"
        + "            padding: 20px;"
        + "        }"
        + "        .header h1 {"
        + "            margin: 0;"
        + "        }"
        + "        .content {"
        + "            padding: 20px;"
        + "        }"
        + "        .content p {"
        + "            line-height: 1.6;"
        + "        }"
        + "        .content table {"
        + "            width: 100%;"
        + "            border-collapse: collapse;"
        + "            margin: 20px 0;"
        + "        }"
        + "        .content table td {"
        + "            padding: 10px;"
        + "            border: 1px solid #ddd;"
        + "        }"
        + "        .content table td:first-child {"
        + "            font-weight: bold;"
        + "        }"
        + "        .footer {"
        + "            text-align: center;"
        + "            padding: 10px;"
        + "            background-color: #333;"
        + "            color: #fff;"
        + "            font-size: 0.9em;"
        + "        }"
        + "    </style>"
        + "</head>"
        + "<body>"
        + "    <div class='container'>"
        + "        <div class='header'>"
        + "            <h1>Booking Confirmation</h1>"
        + "        </div>"
        + "        <div class='content'>"
        + "            <p>Dear Customer,</p>"
        + "            <p>Thank you for booking your ticket with us! Here are your booking details:</p>"
        + "            <table>"
        + "                <tr><td>Hall</td><td>" + hall + "</td></tr>"
        + "                <tr><td>Movie</td><td>" + movie + "</td></tr>"
        + "                <tr><td>Showtime</td><td>" + showtime + "</td></tr>"
        + "                <tr><td>Date</td><td>" + date + "</td></tr>"
        + "                <tr><td>Seat</td><td>" + seatno + "</td></tr>"
        + "            </table>"
        + "            <p>We hope you enjoy the movie! See you soon.</p>"
        + "        </div>"
        + "        <div class='footer'>"
        + "            &copy; 2024 CineFlick Team"
        + "        </div>"
        + "    </div>"
        + "</body>"
        + "</html>";


message.setContent(htmlContent, "text/html; charset=utf-8");


Transport.send(message);


response.sendRedirect("receipt.jsp?hall=" + hall + "&movie=" + movie + "&showtime=" + showtime + "&seatno=" + seatno + "&date=" + date);

        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('An error occurred while processing your booking. Please try again later.');</script>");
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
