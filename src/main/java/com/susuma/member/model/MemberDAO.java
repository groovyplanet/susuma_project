package com.susuma.member.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

public class MemberDAO {

    private Connection getConnection() throws SQLException {
        String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe";
        String dbUser = "SSM";
        String dbPassword = "SSM";
        return DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
    }

    public void addMember(MemberDTO member) throws SQLException {
        String sql = "INSERT INTO members (me_no, type, email, pw, name, address, address_detail, latitude, longitude, phone_num, email_notification, profile_photo, join_approval, join_approval_time, business_number, short_description, max_distance, description, work_hours, point, status, insert_time, update_time) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, member.getMeNo());
            pstmt.setString(2, member.getType());
            pstmt.setString(3, member.getEmail());
            pstmt.setString(4, member.getPw());
            pstmt.setString(5, member.getName());
            pstmt.setString(6, member.getAddress());
            pstmt.setString(7, member.getAddressDetail());

            if (member.getLatitude() != null) {
                pstmt.setDouble(8, member.getLatitude());
            } else {
                pstmt.setNull(8, Types.DOUBLE);
            }

            if (member.getLongitude() != null) {
                pstmt.setDouble(9, member.getLongitude());
            } else {
                pstmt.setNull(9, Types.DOUBLE);
            }

            pstmt.setString(10, member.getPhoneNum());
            pstmt.setString(11, member.getEmailNotification());
            pstmt.setString(12, member.getProfilePhoto());
            pstmt.setString(13, member.getJoinApproval());
            pstmt.setTimestamp(14, member.getJoinApprovalTime());
            pstmt.setString(15, member.getBusinessNumber());
            pstmt.setString(16, member.getShortDescription());
            pstmt.setInt(17, member.getMaxDistance());
            pstmt.setString(18, member.getDescription());
            pstmt.setString(19, member.getWorkHours());
            pstmt.setInt(20, member.getPoint());
            pstmt.setString(21, member.getStatus());
            pstmt.setTimestamp(22, member.getInsertTime());
            pstmt.setTimestamp(23, member.getUpdateTime());

            pstmt.executeUpdate();
        }
    }

    // 'addMemberCategories' 및 'addMemberWorkHours' 메서드가 DTO와 맞지 않으므로,
    //해당 부분은 DTO가 제공하는 필드가 없는 것으로 가정하고 생략했습니다.
}
