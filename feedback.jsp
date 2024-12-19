<%@ page import="java.sql.*" %>
<%
    
    String url = "jdbc:mysql://localhost:3306/movies"; 
    String user = "root"; 
    String pass = ""; 

    
    String loggedInEmail = (String) session.getAttribute("email");
    if (loggedInEmail == null) {
        response.sendRedirect("signin.jsp"); 
        return;
    }

    
    String feedbackMessage = "";
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String feedback = request.getParameter("feedback");

        if (feedback != null && !feedback.trim().isEmpty()) {
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                
                Class.forName("com.mysql.cj.jdbc.Driver");

                
                conn = DriverManager.getConnection(url, user, pass);

                
                String sql = "INSERT INTO feedback (email, feedback, submitted_at) VALUES (?, ?, NOW())";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, loggedInEmail);
                pstmt.setString(2, feedback);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    feedbackMessage = "Feedback submitted successfully!";
                } else {
                    feedbackMessage = "Error: Feedback not submitted.";
                }
            } catch (Exception e) {
                e.printStackTrace();
                feedbackMessage = "Error: " + e.getMessage();
            } finally {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        } else {
            feedbackMessage = "Please enter your feedback.";
        }
    }

    
    String deleteFeedbackId = request.getParameter("deleteFeedbackId");
    if (deleteFeedbackId != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");

            
            conn = DriverManager.getConnection(url, user, pass);

            
            String deleteSql = "DELETE FROM feedback WHERE id = ?";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setString(1, deleteFeedbackId);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                feedbackMessage = "Feedback deleted successfully!";
            } else {
                feedbackMessage = "Error: Feedback not deleted.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            feedbackMessage = "Error: " + e.getMessage();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    StringBuilder feedbackHtml = new StringBuilder();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);

        String sql = "SELECT id, email, feedback, submitted_at FROM feedback ORDER BY submitted_at DESC";
        pstmt = conn.prepareStatement(sql);

        rs = pstmt.executeQuery();

        while (rs.next()) {
            int feedbackId = rs.getInt("id");
            String email = rs.getString("email");
            String feedback = rs.getString("feedback");
            Timestamp submittedAt = rs.getTimestamp("submitted_at");

            feedbackHtml.append("<div style='border: 1px solid #333; margin-bottom: 10px; padding: 10px; background-color: #2c2c2c;'>");
            feedbackHtml.append("<p><strong>Email:</strong> " + email + "</p>");
            feedbackHtml.append("<p><strong>Feedback:</strong> " + feedback + "</p>");
            feedbackHtml.append("<p><small><strong>Submitted At:</strong> " + submittedAt + "</small></p>");
            feedbackHtml.append("</div>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        feedbackMessage = "Error: " + e.getMessage();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 20px;
    background-image: url('img/bg.jpg');
    background-size: cover;
    background-position: center;
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
header {
    position: fixed;
    top: 0;
    left: 0;
    width: 96%;
    background-color: #333;
    padding: 20px;
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
    transition: background-color 0.3s ease, transform 0.3s ease;
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
}

.sign-in:hover {
    background-color: #4318FF;
    transform: scale(1.05);
}

.sign-in .icon {
    font-size: 18px;
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
    transform: scale(1.1);
}

h2 {
    text-align: center;
    color: #fff;
    transition: color 0.3s ease; 
}

.feedback-form {
    max-width: 750px;
    margin: 100px auto 20px auto;
    background: #2c2c2c;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    transition: box-shadow 0.3s ease, transform 0.3s ease; 
}


.feedback-form:hover {
    box-shadow: 0 0 15px rgba(255, 255, 255, 0.3); 
    transform: scale(1.02); 
}

.feedback-form textarea {
    width: 97%;
    height: 100px;
    margin-bottom: 20px;
    background-color: #2c2c2c;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    font-size: 16px;
    color: white;
    transition: border-color 0.3s ease; 
}

.feedback-form textarea:focus {
    border-color: #6f42c1; 
    outline: none;
}

.feedback-form button {
    display: block;
    width: 100%;
    padding: 10px;
    background: #6f42c1;
    color: #fff;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease; 
}

.feedback-form button:hover {
    background: #5a2d97;
    transform: scale(1.05); 
}

.feedback-list {
    max-width: 600px;
    margin: 20px auto;
}

.feedback-list div {
    background: #2c2c2c;
    padding: 10px;
    border-radius: 5px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    margin-bottom: 10px;
    color: #fff;
    transition: transform 0.3s ease, box-shadow 0.3s ease; 
}

.feedback-list div:hover {
    transform: scale(1.02);
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.3); 
}

.message {
    color: #d9534f;
    text-align: center;
    transition: color 0.3s ease; 
}

.message:hover {
    color: #ff6666; 
    
    .header {
    background-color: #f5f5f5;
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
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
    <h2>Feedback Page</h2>
    
    <div class="message">
        <%= feedbackMessage %>
    </div>

    <div class="feedback-form">
        <form method="post" action="feedback.jsp">
            <textarea name="feedback" placeholder="Write your feedback here..." required></textarea>
            <button type="submit">Submit Feedback</button>
        </form>
    </div>

    <div class="feedback-list">
        <h3 style="color: #fff;">All Feedbacks</h3>
        <%= feedbackHtml.toString() %>
    </div>
</body>
</html>
