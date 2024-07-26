package com.susuma.util.filter;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*") // 모든 요청에 필터 적용
public class AuthenticationFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		String uri = request.getRequestURI(); // uri : '/Susuma/member/join.member'
		String path = request.getContextPath(); // path : '/Susuma'
		String command = uri.substring(path.length()); // command : '/member/join.member'

		HttpSession session = request.getSession();
		String meNo = (String) session.getAttribute("meNo");
		String type = (String) session.getAttribute("type");

		// 관리자 페이지 접근 제어
		if (command.startsWith("/admin")) {
			/*
			 * if (meNo == null || !meNo.equals("1")) {
			 * response.setContentType("text/html; charset=UTF-8;"); PrintWriter out =
			 * response.getWriter(); out.println("<script>");
			 * out.println("alert('관리자만 접근 가능한 페이지입니다.');"); out.println("location.href='" +
			 * request.getContextPath() + "/';"); out.println("</script>"); return; }
			 */
		} else {

			// 로그인 시 접근 가능
			switch (command) {
			case "/member/edit.member": // 프로필 수정
			case "/member/findPw.member": // 비밀번호 찾기
			case "/member/mypage.member": // 마이페이지
			case "/member/exit.member": // 회원 탈퇴
			case "/member/memberRequest.member": // 수리 예약
			case "/member/reviewForm.member": // 예약내역 리뷰 작성
			case "/board/askWrite.board": // 1:1 문의 작성
			case "/board/askView.board": // 1:1 문의 상세
			case "/board/askModify.board": // 1:1 문의 수정
			case "/member/list.review" : //리뷰 리스트 페이지
			case "/member/list.request" : //예약 신청 페이지
			case "/member/requestView.request" : //예약 내역 보기
			
				
				if (meNo == null) {
					response.setContentType("text/html; charset=UTF-8;");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('로그인이 필요한 서비스 입니다.');");
					out.println("history.back();"); // 이전 페이지로 돌아가기
					out.println("</script>");
					return; // 컨트롤러 실행 x
				}
			

			}

			// 의뢰인만 접근 가능
			switch (command) {
			case "/member/memberRequest.member": // 수리 예약
				if (!type.equals("user")) {
					response.setContentType("text/html; charset=UTF-8;");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('의뢰인만 이용 가능한 서비스 입니다.');");
					out.println("history.back();");
					out.println("</script>");
					return;
				}

			}

		}
		chain.doFilter(request, response); // 다음 필터로 연결

	}

}
