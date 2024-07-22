package com.susuma.member.service;

import java.io.IOException;

import com.susuma.member.model.MemberDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface MemberService {
    void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void getView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void regist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    MemberDTO getMemberById(int me_no);
}
