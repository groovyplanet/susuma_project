package com.susuma.member.service;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface MemberService {
	void adminList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void getMasterList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminUpsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminUpdateApprove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void deleteAccount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;

	void getMemberById(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;
}
