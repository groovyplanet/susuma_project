package com.susuma.controller;

import java.io.IOException;

import com.susuma.member.service.MemberService;
import com.susuma.member.service.MemberServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("*.member")
public class MemberController extends HttpServlet {

	public MemberController() {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		String uri = request.getRequestURI(); // ip, port번호 제외 주소
		String path = request.getContextPath(); // 프로젝트 식별 이름
		String command = uri.substring(path.length());

		MemberService service;

		if (command.equals("/admin/member/list.member")) {

			service = new MemberServiceImpl();
			service.getList(request, response);

		} else if (command.equals("/admin/member/view.member")) {

			service = new MemberServiceImpl();
			service.getView(request, response);

		}

	}

}
