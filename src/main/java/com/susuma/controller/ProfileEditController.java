package com.susuma.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import com.susuma.member.service.MemberService;
import com.susuma.member.service.MemberServiceImpl;
import com.susuma.member.model.MemberDTO;

public class ProfileEditController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션에서 사용자 이메일을 가져옵니다.
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        // MemberService를 사용하여 사용자 정보를 가져옵니다.
        MemberService service = new MemberServiceImpl();
        MemberDTO member = service.getMemberByEmail(email);

        // 사용자 정보를 JSP에 전달합니다.
        request.setAttribute("member", member);
        request.getRequestDispatcher("profile_edit.jsp").forward(request, response);
    }
}
