package com.susuma.controller;

import com.susuma.member.service.MemberService;
import com.susuma.member.service.MemberServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class JoinController extends HttpServlet {
    private MemberService memberService = new MemberServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        memberService.regist(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/member/join.jsp").forward(request, response);
    }
}
