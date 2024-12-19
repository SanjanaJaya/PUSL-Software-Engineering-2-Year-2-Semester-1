<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    String url = "jdbc:mysql://localhost:3306/movies";
    String user = "root";
    String pass = "";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);

        String sql = "DELETE FROM reg WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(id));
        int rowsDeleted = pstmt.executeUpdate();

        if (rowsDeleted > 0) {
            response.sendRedirect("admin.jsp");
        } else {
            out.println("<script>alert('User not found!'); window.location='admin.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
