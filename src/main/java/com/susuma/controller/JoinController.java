package com.susuma.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.susuma.member.model.MemberDAO;
import com.susuma.member.model.MemberDTO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/joinForm.member")
public class JoinController extends HttpServlet {
    private MemberDAO memberDAO;

    @Override
    public void init() {
        memberDAO = new MemberDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 폼 파라미터 받기
        String email = request.getParameter("email");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String phoneNum = request.getParameter("phone_num");
        String address = request.getParameter("address");
        String addressDetail = request.getParameter("address_detail");
        String latitudeStr = request.getParameter("latitude");
        String longitudeStr = request.getParameter("longitude");
        String businessNumber = request.getParameter("business_number");
        String shortDescription = request.getParameter("short_description");
        String maxDistanceStr = request.getParameter("max_distance");
        String description = request.getParameter("description");
        String workHours = request.getParameter("work_hours");
        String emailNotification = request.getParameter("email_notification");
        String status = request.getParameter("status");

        // 데이터 변환
        Double latitude = latitudeStr != null ? Double.valueOf(latitudeStr) : null;
        Double longitude = longitudeStr != null ? Double.valueOf(longitudeStr) : null;
        int maxDistance = maxDistanceStr != null ? Integer.parseInt(maxDistanceStr) : 0;

        // DTO 객체 생성 및 데이터 설정
        MemberDTO member = new MemberDTO();
        member.setEmail(email);
        member.setPw(pw);
        member.setName(name);
        member.setPhoneNum(phoneNum);
        member.setAddress(address);
        member.setAddressDetail(addressDetail);
        member.setLatitude(latitude);
        member.setLongitude(longitude);
        member.setBusinessNumber(businessNumber);
        member.setShortDescription(shortDescription);
        member.setMaxDistance(maxDistance);
        member.setDescription(description);
        member.setWorkHours(workHours);
        member.setEmailNotification(emailNotification);
        member.setStatus(status);
        member.setInsertTime(new Timestamp(System.currentTimeMillis())); // 현재 시간으로 설정
        member.setUpdateTime(new Timestamp(System.currentTimeMillis())); // 현재 시간으로 설정

        // 회원 가입 처리
        try {
            memberDAO.addMember(member);
            request.setAttribute("isSuccess", true); // 성공 시 속성 설정
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("isSuccess", false); // 실패 시 속성 설정
        }

        // 결과 페이지로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/result.jsp");
        dispatcher.forward(request, response);
    }
}
