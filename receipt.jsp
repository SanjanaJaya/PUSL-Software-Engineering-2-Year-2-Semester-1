<%@ page import="java.sql.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    
    String hall = request.getParameter("hall");
    String movie = request.getParameter("movie");
    String showtime = request.getParameter("showtime");
    String seatno = request.getParameter("seatno");
    String date = request.getParameter("date");

    if (hall == null || movie == null || showtime == null || seatno == null) {
        out.println("<script>alert('Invalid booking details. Please try again.');</script>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Receipt</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #111;
            color: white;
            background-image: url('img/bg.jpg');
            background-size: cover;
            background-attachment: fixed;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background: rgba(0, 0, 0, 0.8);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            padding: 20px;
            text-align: center;
        }

        h2 {
            color: #FFB800;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table td {
            padding: 10px;
            border: 1px solid #444;
        }

        table td:first-child {
            font-weight: bold;
            text-align: left;
            background-color: #222;
        }

        table td:last-child {
            text-align: right;
            background-color: #333;
        }

        p {
            margin-top: 20px;
            font-size: 1.1em;
            color: #ccc;
        }

        .footer {
            margin-top: 30px;
            font-size: 0.9em;
            color: #777;
        }

        .footer a {
            color: #FFB800;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }
        select, .proceed {
            padding: 12px;
            width: 100%;
            margin: 10px 0;
            font-size: 16px;
            border-radius: 5px;
            border: none;
        }
        .proceed {
            background-color: #800080;
            color: white;
            cursor: pointer;
        }
        .proceed:hover {
            background-color: #660066;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Booking Receipt</h2>
        <table>
            <tr>
                <td>Hall</td>
                <td><%= hall %></td>
            </tr>
            <tr>
                <td>Movie</td>
                <td><%= movie %></td>
            </tr>
            <tr>
                <td>Showtime</td>
                <td><%= showtime %></td>
            </tr>
            <tr>
                <td>Seat Number</td>
                <td><%= seatno %></td>
            </tr>
            <tr>
                <td>Date</td>
                <td><%= date %></td>
            </tr>
        </table>
        <p>Thank you for booking with us. Enjoy your movie!</p>
        <button class="proceed" onclick="window.location.href='payment.jsp'">Proceed To Payment</button>
        <div class="footer">
            &copy; 2024 CineFlick Team. <a href="home.jsp"> Return to Home</a>
        </div>
    </div>
</body>
</html>
