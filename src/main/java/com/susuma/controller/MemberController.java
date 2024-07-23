package com.susuma.controller;

import java.io.IOException;
import java.io.PrintWriter;

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

	private static final long serialVersionUID = 1L;

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

		String uri = request.getRequestURI(); // uri : '/Susuma/member/join.member'
		String path = request.getContextPath(); // path : '/Susuma'
		String command = uri.substring(path.length()); // command : '/member/join.member'

		MemberService service = new MemberServiceImpl(); // 비즈니스 로직 처리(DB 접근 및 조작 등)

		if (command.equals("/admin/member/list.member")) { // 관리자 - 회원목록

			service.adminGetList(request, response);

		} else if (command.equals("/admin/member/view.member")) { // 관리자 - 회원상세

			service.adminGetView(request, response);

		} else if (command.equals("/member/join.member")) { // 사용자 - 회원가입 작성

			request.getRequestDispatcher("join.jsp").forward(request, response);

		} else if (command.equals("/member/joinForm.member")) { // 사용자 - 회원가입

			service.register(request, response);

		} else if (command.equals("/member/loginForm.member")) { // 사용자 로그인

			service.login(request, response);

		} else if (command.equals("/member/edit.member")) { // 사용자 - 프로필 수정

			service.edit(request, response);

		} else if (command.equals("/member/find_info.member")) { // 사용자 - 비밀번호 찾기

			request.getRequestDispatcher("find_info.jsp").forward(request, response);

		} else if (command.equals("/member/mypage.member")) { // 사용자 - 마이페이지

			request.getRequestDispatcher("mypage.jsp").forward(request, response);

		} else if (command.equals("/member/masterList.member")) { // 사용자 - 수리 예약(수리기사 목록)

			service.getMasterList(request, response);

		} else if (command.equals("/member/logout.member")) { // 사용자 로그아웃

			// 세션 삭제
			HttpSession session = request.getSession();
			session.invalidate();

			// 화면 이동
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			String contextPath = request.getContextPath();
			out.println("<script>");
			out.println("alert('로그아웃 되었습니다.');");
			out.println("location.href = '" + contextPath + "/';");
			out.println("</script>");

		}else if (command.equals("/member/ExitForm.member")) { // 사용자 - 회원 탈퇴
		    service.deleteAccount(request, response);
		}
	}
}