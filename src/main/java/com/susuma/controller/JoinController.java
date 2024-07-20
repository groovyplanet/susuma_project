package com.susuma.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

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
        String password = request.getParameter("pw");
        String name = request.getParameter("name");
        String phoneNum = request.getParameter("phone_num");
        String address = request.getParameter("address");
        String latitude = request.getParameter("latitude");
        String longitude = request.getParameter("longitude");
        String businessNum = request.getParameter("business_num");
        String workHours = request.getParameter("work_hours"); // 이 필드는 JSP에서 사용하지 않지만, 추가적으로 필요한 경우를 대비해 남겨둡니다.
        String maxDistance = request.getParameter("max_distance");
        String shortDescription = request.getParameter("short_description");
        String emailNotification = request.getParameter("email_notification");
        String termsAgreement = request.getParameter("check-terms-all"); // JSP에서는 이 값이 `check-terms-all`으로 설정되어 있습니다.

        // DTO 객체 생성 및 데이터 설정
        MemberDTO member = new MemberDTO();
        member.setEmail(email);
        member.setPassword(password);
        member.setName(name);
        member.setPhoneNum(phoneNum);
        member.setAddress(address);
        member.setLatitude(latitude);
        member.setLongitude(longitude);
        member.setBusinessNum(businessNum);
        member.setMaxDistance(maxDistance);
        member.setShortDescription(shortDescription);
        member.setEmailNotification(emailNotification != null ? "Y" : "N"); // 체크박스는 null이거나 "Y"로 설정됩니다.
        member.setTermsAgreement(termsAgreement != null ? "Y" : "N"); // 전체 동의는 `check-terms-all`로 설정됨

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