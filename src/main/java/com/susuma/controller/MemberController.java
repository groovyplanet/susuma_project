package com.susuma.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.susuma.member.model.MemberDTO;
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

		if (command.equals("/admin/member/list.member")) { // 관리자 - 회원목록

			service = new MemberServiceImpl();
			service.getList(request, response);

		} else if (command.equals("/admin/member/view.member")) { // 관리자 - 회원상세

			service = new MemberServiceImpl();
			service.getView(request, response);

		} else if (command.equals("/member/join.member")) { // 사용자 - 회원가입 작성

			request.getRequestDispatcher("join.jsp").forward(request, response);

		} else if (command.equals("/member/joinForm.member")) { // 사용자 - 회원가입

			service = new MemberServiceImpl();
			service.regist(request, response);

		} else if (command.equals("/member/loginForm.member")) { // 사용자 로그인

			service = new MemberServiceImpl();
			service.login(request, response);

		} else if (command.equals("/member/logout.member")) { // 사용자 로그아웃

			/* 세션 값 삭제 */
			HttpSession session = request.getSession();
			session.invalidate();

			/* 화면 이동 */
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			String contextPath = request.getContextPath();
			out.println("<script>");
			out.println("alert('로그아웃 되었습니다.');");
			out.println("location.href = '" + contextPath + "/';");
			out.println("</script>");

		} else if (command.equals("/profileEdit.member")) { // 사용자 - 프로필 수정

		    service = new MemberServiceImpl();
		    HttpSession session = request.getSession();
		    Integer me_no = (Integer) session.getAttribute("me_no");

		    // 세션에 me_no가 없을 경우 로그인 페이지로 리다이렉트
		    if (me_no == null) {
		        response.sendRedirect(request.getContextPath() + "/login.jsp");
		        return;
		    }

		    MemberDTO member = service.getMemberById(me_no);
		    request.setAttribute("member", member);
		    request.getRequestDispatcher("profile_edit.jsp").forward(request, response);
		}
	}
}