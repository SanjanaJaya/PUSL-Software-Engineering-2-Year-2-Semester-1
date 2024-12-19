<%@ page import="java.sql.*" %>
<%
    String message = "";

    // Handling Movie Addition
    String title = request.getParameter("title");
    String genre = request.getParameter("genre");
    String posterImage = request.getParameter("poster_image");
    String backgroundVideo = request.getParameter("background_video");
    String description = request.getParameter("description");

    if (title != null && genre != null && posterImage != null && description != null) {
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

            pstmt.executeUpdate();
            message = "Movie added successfully!";
            response.sendRedirect("adminmovies.jsp");  // Redirect to refresh the page
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error adding movie: " + e.getMessage();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    // Handling Movie Deletion
    String deleteId = request.getParameter("delete_id");

    if (deleteId != null) {
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
            response.sendRedirect("adminmovies.jsp");  // Redirect to adminmovies.jsp to refresh the movie list
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error deleting movie: " + e.getMessage();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>