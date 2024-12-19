<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineFlick</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
    <style>
      
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Poppins;
    transition: all 0.3s ease; 
}


body {
    background-color: #111;
    color: white;
    background-image: url('img/bg.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    animation: fadeIn 1s ease-in-out; 
}


@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
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
    transition: color 0.3s ease, transform 0.3s ease;
}

.nav-links a:hover {
    color: #4318FF;
    transform: scale(1.1); 
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
    transition: background-color 0.3s ease, transform 0.3s ease;
}

.register {
    background-color: transparent;
    border: 1px solid #f5f5f5;
    font-weight: bold;
    transition: background-color 0.3s ease, color 0.3s ease, transform 0.3s ease;
}

.register:hover {
    background-color: #4318FF;
    color: white;
    transform: scale(1.05); 
}


.movies-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 2rem;
    padding: 2rem;
}

.movie-card {
    position: relative;
    aspect-ratio: 2/3;
    background-color: #222;
    border-radius: 8px;
    overflow: hidden;
    transition: transform 0.3s, box-shadow 0.3s ease;
}

.movie-card:hover {
    transform: scale(1.05); 
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.6); 
}

.movie-poster {
    width: 100%;
    height: 100%;
    object-fit: cover;
    opacity: 1;
    transition: opacity 0.3s ease; 
}

.movie-card:hover .movie-poster {
    opacity: 0.9; 
}

.movie-info {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 1rem;
    background: linear-gradient(transparent, rgba(0, 0, 0, 0.9));
    transition: opacity 0.3s ease;
    opacity: 0;
}

.movie-card:hover .movie-info {
    opacity: 1; 
}

.movie-title {
    font-size: 1.1rem;
    margin-bottom: 0.3rem;
    color: white;
}

.movie-genre {
    font-size: 0.8rem;
    margin-bottom: 0.25rem;
    color: white;
}

.movie-genre {
    font-size: 0.9rem;
    color: #ccc;
}
        </style>
        </head>
        <body>
        <header class="header">
        <a href="#" class="logo">
            <img src="img/logo.png" alt="CineFlick Logo">
            <span></span>
        </a>
        <nav>
              <ul class="nav-links">
                <li><a href="home.jsp">Home</a></li>
                <li><a href="Movies.jsp">Movies</a></li>
                <li><a href="theater.jsp">Theaters</a></li>
                <li><a href="feedback.jsp">Feedbacks</a></li>
                <li><a href="contact.jsp">Contact Us</a></li>
            </ul>
        </nav>
            <div class="auth-buttons">
                <button class="register" onclick="window.location.href='register.jsp'">Register</button>

                <button class="signin" onclick="window.location.href='signin.jsp'">Sign In</button>
                
            </div>
    </header>
<div class="movies-grid">
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                String url = "jdbc:mysql://localhost:3306/movies";
                String user = "root";
                String pass = "";

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pass);
                stmt = conn.createStatement();

                String sql = "SELECT * FROM movies";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String genre = rs.getString("genre");
                    String posterImage = rs.getString("poster_image");

                    out.println("<div class='movie-card'>");
                    out.println("<a href='moviedetails.jsp?id=" + id + "'>");
                    out.println("<img src='" + posterImage + "' alt='" + title + "' class='movie-poster'>");
                    out.println("<div class='movie-info'>");
                    out.println("<h3 class='movie-title'>" + title + "</h3>");
                    out.println("<h6 class='movie-genre'>" + genre + "</h6>");
                    out.println("</div></a></div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
    
</body>
</html>