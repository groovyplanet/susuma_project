<%@ page import="java.sql.*, java.util.*" %>
<%
    // 데이터베이스 연결 설정
    String url = "jdbc:oracle:thin:@localhost:1521:xe"; // JDBC URL
    String user = "HR"; // 데이터베이스 사용자 이름
    String password = "HR"; // 데이터베이스 비밀번호
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 필터 값 수신
    String category = request.getParameter("category");
    String subCategory = request.getParameter("subCategory");
    String region = request.getParameter("region");
    String maxDistance = request.getParameter("max_distance");
    String rating = request.getParameter("rating");

    // SQL 쿼리 구성
    String query = "SELECT * FROM your_table WHERE 1=1";
    if (category != null && !category.isEmpty()) {
        query += " AND category = ?";
    }
    if (subCategory != null && !subCategory.isEmpty()) {
        query += " AND sub_category = ?";
    }
    if (region != null && !region.isEmpty()) {
        query += " AND region = ?";
    }
    if (maxDistance != null && !maxDistance.isEmpty()) {
        query += " AND distance <= ?";
    }
    if (rating != null && rating.equals("desc")) {
        query += " ORDER BY rating DESC";
    } else {
        query += " ORDER BY rating ASC";
    }

    try {
        // 데이터베이스 연결
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, password);
        pstmt = conn.prepareStatement(query);

        // 쿼리 파라미터 설정
        int paramIndex = 1;
        if (category != null && !category.isEmpty()) {
            pstmt.setString(paramIndex++, category);
        }
        if (subCategory != null && !subCategory.isEmpty()) {
            pstmt.setString(paramIndex++, subCategory);
        }
        if (region != null && !region.isEmpty()) {
            pstmt.setString(paramIndex++, region);
        }
        if (maxDistance != null && !maxDistance.isEmpty()) {
            pstmt.setInt(paramIndex++, Integer.parseInt(maxDistance));
        }

        // 쿼리 실행 및 결과 처리
        rs = pstmt.executeQuery();
        while (rs.next()) {
            out.println("결과: " + rs.getString("some_column") + "<br>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
