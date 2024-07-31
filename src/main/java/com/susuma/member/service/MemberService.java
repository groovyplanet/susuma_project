package com.susuma.member.service;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface MemberService {

	/* 관리자 */
	void adminList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminUpsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminUpdateApprove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	/* 사용자 */
	void getMasterList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void getMasterListAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void join(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void changePwAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void deleteAccount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;

	void getMemberById(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;

	void getMemberDetails(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;

	void reviewWrite(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;

	void getMainMaster(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;

	void getMemberPoints(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void withdrawPoints(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void chargePoints(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void attendancepoint(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void findPwForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

}
