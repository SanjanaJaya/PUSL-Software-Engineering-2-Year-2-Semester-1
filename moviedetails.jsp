<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Details</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #111;
            color: #fff;
            overflow-x: hidden; /* Prevent horizontal scrolling */
            overflow-y: auto;  /* Enable vertical scrolling */
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            text-align: center;
            position: relative;
            z-index: 1;
        }

        .movie-details {
            margin-top: 20px;
        }

        .movie-title {
            font-size: 2.5rem;
            color: #f39c12;
        }

        .movie-genre {
            font-size: 1.2rem;
            margin: 10px 0;
            color: #ccc;
        }

        .movie-description {
            margin: 20px 0;
            font-size: 1rem;
            line-height: 1.6;
        }

        .movie-poster {
            width: 50%;
            border-radius: 10px;
            margin: 20px 0;
        }

        .video-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .video-background video {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            min-width: 100%;
            min-height: 100%;
            background: rgba(0, 0, 0, 0.55);
        }

        a.back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            border: 2px solid #f39c12;
            color: #f39c12;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        a.back-button:hover {
            background-color: #f39c12;
            color: #111;
        }
    </style>
</head>
<body>
    <%
        int id = 0; // Default ID value
        String title = "", genre = "", posterImage = "", backgroundVideo = "", description = "";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                id = Integer.parseInt(idParam);
            } else {
                out.println("<p style='color:red;'>Movie ID is missing in the request!</p>");
                return;
            }

            String url = "jdbc:mysql://localhost:3306/movies";
            String user = "root";
            String pass = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pass);
            String sql = "SELECT * FROM movies WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                title = rs.getString("title");
                genre = rs.getString("genre");
                posterImage = rs.getString("poster_image");
                backgroundVideo = rs.getString("background_video");
                description = rs.getString("description");
            } else {
                out.println("<p style='color:red;'>Movie not found!</p>");
                return;
            }
        } catch (NumberFormatException e) {
            out.println("<p style='color:red;'>Invalid Movie ID!</p>");
            e.printStackTrace();
        } catch (Exception e) {
            out.println("<p style='color:red;'>An error occurred while fetching the movie details.</p>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <!-- YouTube Video Background -->
    <% if (backgroundVideo != null && !backgroundVideo.isEmpty()) { %>
    <div class="video-background">
        <video autoplay muted loop>
            <source src="<%= backgroundVideo %>" type="video/mp4">
            Your browser does not support the video tag.
        </video>
    </div>
    <% } %>

    <!-- Movie Details -->
    <div class="container">
        <div class="movie-details">
            <h1 class="movie-title"><%= title %></h1>
            <p class="movie-genre">Genre: <%= genre %></p>
            <img src="<%= posterImage %>" alt="<%= title %>" class="movie-poster">
            <p class="movie-description"><%= description %></p>
        </div>

        <!-- Back Button -->
        <a href="Movies.jsp" class="back-button">Back to Movies</a>
        <a href="seat.jsp" class="back-button">Book Now</a>
    </div>
</body>
</html>
