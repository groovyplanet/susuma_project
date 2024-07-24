package com.susuma.member.service;

import java.io.IOException;

import com.susuma.member.model.MemberDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface MemberService {
    void adminGetList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void getMasterList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void adminGetView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    void deleteAccount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;
    void getMemberById(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;
}
