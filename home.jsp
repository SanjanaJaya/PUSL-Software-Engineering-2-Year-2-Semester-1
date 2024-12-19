<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}/img/icon.png" type="image/png">
    <title>CineFlick - Movie Booking</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
    <style>
        * /* Global Reset */
* /* Universal Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
    transition: all 0.3s ease;
}

/* Body Styling */
body {
    background-color: #111;
    color: white;
    background-image: url('img/bg.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    animation: fadeIn 1.5s ease-in-out;
    margin-top: 80px;
}

/* Fade-in animation */
@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

/* Header */
/* Header */
.header {
    background-color: #f5f5f5;
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%; /* Make the header span the full width */
    position: fixed; /* Keep the navbar at the top */
    top: 0; /* Align to the top of the page */
    left: 0; /* Ensure it starts from the left */
    right: 0; /* Ensure it extends to the right */
    z-index: 1000; /* Make sure it's above other content */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Add subtle shadow for better visibility */
    background-color: rgba(245, 245, 245, 0.9); /* Slight transparency */
}

/* Logo */
.logo {
    width: 120px;
    display: flex;
    align-items: center;
    gap: 10px;
    color: #333;
    text-decoration: none;
}

/* Logo image */
.logo img {
    width: 197px;
    height: 75px;
}

/* Navigation Links */
.nav-links {
    display: flex;
    gap: 2rem;
    list-style: none;
}

/* Link styling */
.nav-links a {
    color: #333;
    text-decoration: none;
    font-weight: bold;
    transition: color 0.3s ease, transform 0.3s ease;
}

/* Link hover effect */
.nav-links a:hover {
    color: #4318FF;
    transform: scale(1.1); 
}

/* Auth Buttons */
.auth-buttons {
    display: flex;
    gap: 1rem;
}

/* Auth button styling */
.auth-buttons button {
    padding: 0.5rem 1rem;
    border-radius: 5px;
    cursor: pointer;
}

/* Sign-in button */
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

/* Sign-in button hover effect */
.sign-in:hover {
    background-color: #5a34ff;
    transform: scale(1.05);
}

/* Register button */
.register {
    background-color: transparent;
    border: 1px solid #f5f5f5;
    font-weight: bold;
    transition: background-color 0.3s ease, color 0.3s ease, transform 0.3s ease;
}

/* Register button hover effect */
.register:hover {
    background-color: #4318FF;
    color: white;
    transform: scale(1.05); 
}

/* Hero Section */
.hero {
    background-color: #4318FF;
    padding: 3rem 2rem;
    text-align: center;
    color: white;
}

.hero h1 {
    font-size: 2rem;
    margin-bottom: 1rem;
}

/* Movie Section */
.movies-section {
    padding: 2rem;
    width: 100%;
}

.section-title {
    font-size: 2.5rem;
    margin-bottom: 1.0rem;
    text-align: center;
    color: #fff;
}

.movie-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    padding: 2rem 1rem;
    justify-content: center;
    align-items: stretch;
    margin: 0 auto;
}

.movie-card {
    background: #1a1a1a;
    border-radius: 1rem;
    overflow: hidden;
    transition: transform 0.4s ease, box-shadow 0.3s ease;
    width: 250px;
    flex-shrink: 0;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    height: 100%;
    height: 550px;
}

.movie-card:hover {
    transform: translateY(-10px) scale(1.05);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
}

.movie-image {
    width: 100%;
    height: 300px;
    object-fit: cover;
    opacity: 1;
    transition: opacity 0.5s ease;
}

.movie-card:hover .movie-image {
    opacity: 0.8;
}

.movie-info {
    padding: 1rem;
    text-align: left;
}

.movie-title {
    color: white;
    font-size: 1.2rem;
    margin-bottom: 0.5rem;
    text-align: left;
    font-weight: bold; /* Bold the title */
}

.movie-genre {
    font-size: 1rem;
    color: #B0B0B0;
}

.movie-theaters {
    font-size: 0.9rem;
    color: #888;
    margin-bottom: 0.5rem;
}

.price {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 1rem;
}

.book-now {
    background-color: #4318FF;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 0.5rem;
    border: none;
    cursor: pointer;
    font-size: 0.9rem;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

.book-now:hover {
    background-color: #5a34ff;
    transform: scale(1.1);
}

@media (max-width: 768px) {
    .movie-grid {
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        justify-items: center;
    }
    .movie-card {
        width: 200px;
    }
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

    <section class="movies-section">
        <h2 class="section-title">Lastest Movies</h2>
        <div class="movie-grid">
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Database connection
                    String url = "jdbc:mysql://localhost:3306/movies";
                    String user = "root";
                    String pass = "";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, pass);
                    stmt = conn.createStatement();

                    // SQL query to fetch 5 random movies
                    String sql = "SELECT * FROM movies ORDER BY RAND() LIMIT 5";
                    rs = stmt.executeQuery(sql);

                    // Loop through the result set and display movies
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String genre = rs.getString("genre");
                        String posterImage = rs.getString("poster_image");

                        out.println("<div class='movie-card'>");
                        out.println("<a href='moviedetails.jsp?id=" + id + "'>");
                        out.println("<img src='" + posterImage + "' alt='" + title + "' class='movie-image'>");
                        out.println("<div class='movie-info'>");
                        out.println("<h3 class='movie-title'>" + title + "</h3>");
                        out.println("<h6 class='movie-genre'>" + genre + "</h6>");
                        out.println("</div></a>");
                        out.println("</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close resources
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </div>
    </section>
</body>
</html>