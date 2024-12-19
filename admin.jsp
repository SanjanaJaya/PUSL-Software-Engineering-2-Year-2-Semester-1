<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Registered Users</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
    <style>
        /* Global Styles */
        body {
            background-image: url('img/bg.jpg');
            background-size: cover;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #fff;
        }

        .container {
            max-width: 1000px;
            width: 90%;
            background-color: rgba(0, 0, 0, 0.7);
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.7);
            overflow-y: auto;
        }

        h1 {
            text-align: center;
            font-size: 2.5rem;
            color: #f39c12;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
        }

        table th, table td {
            padding: 12px;
            text-align: center;
            border: 1px solid #444;
            font-size: 1rem;
        }

        table th {
            background-color: #333;
            color: #f39c12;
        }

        table tr:nth-child(even) {
            background-color: #444;
        }

        table tr:hover {
            background-color: #555;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        .btn-delete:active {
            transform: scale(0.98);
        }

        .action-column {
            display: flex;
            justify-content: center;
        }

        a {
    text-decoration: none; 
}

.btn-add-movie {
    background-color: #f39c12;
    color: white;
    padding: 12px 20px;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    font-size: 1.2rem;
    transition: background-color 0.3s ease;
    display: block;
    margin: 30px auto;
    text-align: center;
}

.btn-add-movie:hover {
    background-color: #e67e22;
}


        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 2rem;
            }

            table th, table td {
                font-size: 0.9rem;
            }

            .btn-delete {
                padding: 6px 12px;
            }

            .btn-add-movie {
                padding: 10px 18px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admin Panel - Registered Users</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String url = "jdbc:mysql://localhost:3306/movies";
                    String user = "root";
                    String pass = "";

                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, pass);
                        stmt = conn.createStatement();

                        String sql = "SELECT id, email FROM reg";
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String email = rs.getString("email");

                            out.println("<tr>");
                            out.println("<td>" + id + "</td>");
                            out.println("<td>" + email + "</td>");
                            out.println("<td><div class='action-column'><form action='deleteuser.jsp' method='post'>");
                            out.println("<input type='hidden' name='id' value='" + id + "' />");
                            out.println("<button type='submit' class='btn-delete'>Delete</button>");
                            out.println("</form></div></td>");
                            out.println("</tr>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>

        <h1>Admin Panel - Ticket Bookings</h1>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Movie</th>
                    <th>Showtime</th>
                    <th>Seat No</th>
                    <th>Email</th>
                    <th>Theater</th>
                    <th>Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection connTicket = null; 
                    Statement stmtTicket = null;  
                    ResultSet rsTicket = null;

                    try {
                        connTicket = DriverManager.getConnection(url, user, pass);
                        stmtTicket = connTicket.createStatement();
                        String sqlTicket = "SELECT id, movie, showtime, seatno, email, hall, date FROM ticketbook";
                        rsTicket = stmtTicket.executeQuery(sqlTicket);

                        while (rsTicket.next()) {
                            int ticketId = rsTicket.getInt("id");
                            String movie = rsTicket.getString("movie");
                            String showtime = rsTicket.getString("showtime");
                            String seatno = rsTicket.getString("seatno");
                            String ticketEmail = rsTicket.getString("email");
                            String hall = rsTicket.getString("hall");
                            String date = rsTicket.getString("date");

                            out.println("<tr>");
                            out.println("<td>" + ticketId + "</td>");
                            out.println("<td>" + movie + "</td>");
                            out.println("<td>" + showtime + "</td>");
                            out.println("<td>" + seatno + "</td>");
                            out.println("<td>" + ticketEmail + "</td>");
                            out.println("<td>" + hall + "</td>");
                            out.println("<td>" + date + "</td>");
                            out.println("<td><div class='action-column'><form action='deleteticket.jsp' method='post'>");
                            out.println("<input type='hidden' name='id' value='" + ticketId + "' />");
                            out.println("<button type='submit' class='btn-delete'>Delete</button>");
                            out.println("</form></div></td>");
                            out.println("</tr>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rsTicket != null) rsTicket.close();
                        if (stmtTicket != null) stmtTicket.close();
                        if (connTicket != null) connTicket.close();
                    }
                %>
            </tbody>
        </table>

        <!-- Add Movie Button -->
        <a href="adminmovies.jsp">
            <button class="btn-add-movie">Add Movies</button>
        </a>
    </div>
</body>
</html>
