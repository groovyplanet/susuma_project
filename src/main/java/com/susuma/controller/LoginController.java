package com.susuma.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.susuma.member.service.MemberService;
import com.susuma.member.service.MemberServiceImpl;

public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // MemberService를 인스턴스화
        MemberService service = new MemberServiceImpl();
        
        // 이메일과 비밀번호를 request에서 추출하지 않고, service.login 메서드를 호출합니다.
        service.login(request, response);
    }
}