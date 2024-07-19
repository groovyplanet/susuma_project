package com.susuma.message.model;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageMapper {
    private static final String DB_URL = "jdbc:oracle:thin:@yourdb:1521:xe";
    private static final String USER = "SSM";
    private static final String PASS = "SSM";

    private Connection connect() throws SQLException {
        return DriverManager.getConnection(DB_URL, USER, PASS);
    }

    public List<MessageDTO> getMessages() throws SQLException {
        String sql = "SELECT * FROM MESSAGE ORDER BY send_time DESC";
        try (Connection conn = this.connect();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            List<MessageDTO> messages = new ArrayList<>();
            while (rs.next()) {
                MessageDTO message = new MessageDTO();
                message.setMsgNo(rs.getInt("msg_no"));
                message.setMasterNo(rs.getInt("master_no"));
                message.setClientNo(rs.getInt("client_no"));
                message.setMessage(rs.getString("message"));
                message.setRead(rs.getString("read").charAt(0));
                message.setSendTime(rs.getTimestamp("send_time"));
                message.setReadTime(rs.getTimestamp("read_time"));
                messages.add(message);
            }
            return messages;
        }
    }

    public void addMessage(int masterNo, int clientNo, String messageText) throws SQLException {
        String sql = "INSERT INTO MESSAGE (master_no, client_no, message) VALUES (?, ?, ?)";
        try (Connection conn = this.connect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, masterNo);
            pstmt.setInt(2, clientNo);
            pstmt.setString(3, messageText);
            pstmt.executeUpdate();
        }
    }

}
