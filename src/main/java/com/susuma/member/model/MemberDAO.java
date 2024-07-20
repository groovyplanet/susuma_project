package com.susuma.member.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Array;
import java.sql.Types;

public class MemberDAO {

    private Connection getConnection() throws SQLException {
        String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe";
        String dbUser = "SSM";
        String dbPassword = "SSM";
        return DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
    }

    public void addMember(MemberDTO member) throws SQLException {
        String sql = "INSERT INTO members (email, password, name, phone_num, address, address_detail, latitude, longitude, business_num, short_description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, member.getEmail());
            pstmt.setString(2, member.getPassword());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getPhoneNum());
            pstmt.setString(5, member.getAddress());
            pstmt.setString(6, member.getAddressDetail());
            pstmt.setString(7, member.getLatitude());
            pstmt.setString(8, member.getLongitude());
            pstmt.setString(9, member.getBusinessNum());
            pstmt.setString(10, member.getShortDescription());
            pstmt.executeUpdate();
        }
    }

    public void addMemberCategories(MemberDTO member) throws SQLException {
        String sql = "INSERT INTO member_categories (email, category) VALUES (?, ?)";

        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, member.getEmail());

            for (String category : member.getCategories()) {
                pstmt.setString(2, category);
                pstmt.addBatch(); // Add batch for each category
            }

            pstmt.executeBatch(); // Execute all batches
        }
    }

    public void addMemberWorkHours(MemberDTO member) throws SQLException {
        String sql = "INSERT INTO member_work_hours (email, work_hour) VALUES (?, ?)";

        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, member.getEmail());

            for (String workHour : member.getWorkHours()) {
                pstmt.setString(2, workHour);
                pstmt.addBatch(); // Add batch for each work hour
            }

            pstmt.executeBatch(); // Execute all batches
        }
    }
}
