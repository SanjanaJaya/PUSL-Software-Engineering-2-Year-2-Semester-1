<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Movie</title>
    <style>
        body {
    font-family: 'Poppins', sans-serif;
    background-color: #111;
    color: #fff;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    min-height: 100vh;
    margin: 0;
    padding: 20px;
    background-image: url('img/bg.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    animation: fadeIn 1s ease-in-out;
}

.form-container {
    background-color: #222;
    padding: 30px;
    border-radius: 12px;
    width: 500px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.7);
    margin-bottom: 40px;
}

h1 {
    color: #f39c12;
    margin-bottom: 25px;
    text-align: center;
    font-size: 2.5rem;
    font-weight: 600;
}

form {
    display: flex;
    flex-direction: column;
}

label {
    font-size: 1rem;
    margin-bottom: 8px;
    font-weight: 500;
}

input, textarea {
    margin-bottom: 20px;
    padding: 12px;
    border-radius: 8px;
    border: none;
    font-size: 1rem;
    background-color: #333;
    color: #fff;
}

input[type="submit"] {
    background-color: #f39c12;
    color: #111;
    font-weight: bold;
    cursor: pointer;
    padding: 12px;
    border-radius: 8px;
    border: none;
    font-size: 1.1rem;
    transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
    background-color: #e67e22;
}

.message {
    text-align: center;
    margin-top: 15px;
    font-size: 1.2rem;
}

table {
    width: 90%;
    margin-top: 40px;
    border-collapse: collapse;
    color: #fff;
}

table, th, td {
    border: 1px solid #ddd;
    text-align: center;
}

th, td {
    padding: 15px;
    font-size: 1.1rem;
}

th {
    background-color: #f39c12;
    color: #111;
    font-weight: bold;
}

tr:nth-child(even) {
    background-color: #333;
}

tr:hover {
    background-color: #444;
}

.delete-btn {
    background-color: #e74c3c;
    color: white;
    border: none;
    padding: 8px 16px;
    font-size: 1rem;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.delete-btn:hover {
    background-color: #c0392b;
}

.movies-list {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    background-color: #1a1a1a;
    border-radius: 12px;
}

.movies-list h1 {
    font-size: 2rem;
    color: #f39c12;
    margin-bottom: 25px;
    text-align: center;
}

.movies-list table {
    width: 100%;
    margin-top: 20px;
}

.movies-list td {
    font-size: 1.2rem;
}

.movies-list .delete-btn {
    font-size: 1rem;
    padding: 10px 20px;
}

    </style>
</head>
<body>

    <!-- Movie Addition Form -->
    <div class="form-container">
        <h1>Add New Movie</h1>
        <%
            String message = "";

            if (request.getMethod().equalsIgnoreCase("POST")) {
                String title = request.getParameter("title");
                String genre = request.getParameter("genre");
                String posterImage = request.getParameter("poster_image");
                String backgroundVideo = request.getParameter("background_video");
                String description = request.getParameter("description");

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    String url = "jdbc:mysql://localhost:3306/movies";
                    String user = "root";
                    String pass = "";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, pass);

                    String sql = "INSERT INTO movies (title, genre, poster_image, background_video, description) VALUES (?, ?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, title);
                    pstmt.setString(2, genre);
                    pstmt.setString(3, posterImage);
                    pstmt.setString(4, backgroundVideo);
                    pstmt.setString(5, description);

                    int rowsInserted = pstmt.executeUpdate();
                    if (rowsInserted > 0) {
                        message = "Movie added successfully!";
                    } else {
                        message = "Failed to add movie.";
                    }
                } catch (Exception e) {
                    message = "An error occurred: " + e.getMessage();
                    e.printStackTrace();
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            }

            // Handle movie deletion
            if (request.getParameter("delete_id") != null) {
                String deleteId = request.getParameter("delete_id");
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    String url = "jdbc:mysql://localhost:3306/movies";
                    String user = "root";
                    String pass = "";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, pass);

                    String sql = "DELETE FROM movies WHERE id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(deleteId));

                    int rowsDeleted = pstmt.executeUpdate();
                    if (rowsDeleted > 0) {
                        message = "Movie deleted successfully!";
                    } else {
                        message = "Failed to delete movie.";
                    }
                } catch (Exception e) {
                    message = "An error occurred: " + e.getMessage();
                    e.printStackTrace();
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            }
        %>

        <form method="post" action="addmovie.jsp">
            <label for="title">Movie Title:</label>
            <input type="text" id="title" name="title" required>

            <label for="genre">Genre:</label>
            <input type="text" id="genre" name="genre" required>

            <label for="poster_image">Poster Image URL:</label>
            <input type="text" id="poster_image" name="poster_image" required>

            <label for="background_video">Background Video URL:</label>
            <input type="text" id="background_video" name="background_video">

            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4" required></textarea>

            <input type="submit" value="Add Movie">
        </form>

        <div class="message"><%= message %></div>
    </div>

    <!-- Displaying Movies -->
    <div class="movies-list">
        <h1>Added Movies</h1>
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
        %>
        <table>
            <tr>
                <th>Title</th>
                <th>Genre</th>
                <th>Action</th>
            </tr>
            <%
                while (rs.next()) {
                    String movieTitle = rs.getString("title");
                    String genre = rs.getString("genre");
                    String movieId = rs.getString("id");
            %>
            <tr>
                <td><%= movieTitle %></td>
                <td><%= genre %></td>
                <td>
                    <form method="get" action="addmovie.jsp" style="display:inline;">
                        <input type="hidden" name="delete_id" value="<%= movieId %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>
    </div>
</body>
</html>
