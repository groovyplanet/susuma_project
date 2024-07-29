package com.susuma.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.susuma.member.service.MemberService;
import com.susuma.member.service.MemberServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("*.member")
@MultipartConfig()
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
		System.out.println("command : " + command);

		MemberService service = new MemberServiceImpl();

		switch (command) {
		
		case "/admin/member/list.member":
			service.adminList(request, response); // 관리자 - 회원 목록
			break;

		case "/admin/member/view.member":
			service.adminView(request, response); // 관리자 - 회원 상세
			break;

		case "/admin/member/write.member":
			service.adminWrite(request, response); // 관리자 - 회원 추가 화면
			break;

		case "/admin/member/edit.member":
			service.adminEdit(request, response); // 관리자 - 회원 수정 화면
			break;

		case "/admin/member/editForm.member":
			service.adminUpsert(request, response); // 관리자 - 회원 추가/수정
			break;

		case "/admin/member/approve.member":
			service.adminUpdateApprove(request, response); // 관리자 - 수리기사 승인
			break;

		case "/admin/member/delete.member":
			service.adminDelete(request, response); // 관리자 - 회원 정보 삭제
			break;

		case "/member/join.member":
			service.join(request, response); // 회원가입 화면
			break;

		case "/member/joinForm.member":
			service.register(request, response); // 회원가입
			break;

		case "/member/loginForm.member":
			service.login(request, response); // 사용자 로그인
			break;

		case "/member/edit.member":
			service.edit(request, response); // 프로필 수정 화면
			break;

		case "/member/editForm.member":
			service.update(request, response); // 프로필 수정
			break;

		case "/member/changePwAjax.member":
			service.changePwAjax(request, response); // 비밀번호 변경
			break;

		case "/member/findPw.member":
			request.getRequestDispatcher("find_info.jsp").forward(request, response); // 비밀번호 찾기
			break;
			
		case "/member/findPwForm.member":
			service.findPwForm(request, response);
			break;

		case "/member/mypage.member":
			request.getRequestDispatcher("mypage.jsp").forward(request, response); // 마이페이지
			break;

		case "/member/masterList.member":
			service.getMasterList(request, response); // 수리 예약(수리기사 목록)
			break;

		case "/member/getMasterListAjax.member":
			service.getMasterListAjax(request, response);
			break;
			
		case "/member/logout.member":
			logout(request, response); // 사용자 로그아웃
			break;

		case "/member/exit.member":
			request.getRequestDispatcher("exit.jsp").forward(request, response); // 회원 탈퇴 화면
			break;

		case "/member/exitForm.member":
			service.deleteAccount(request, response); // 회원 탈퇴
			break;

		case "/member/masterView.member":
			service.getMemberById(request, response); // 회원 상세 정보 보기
			break;

		case "/member/request.member":
			service.getMemberDetails(request, response); // 수리 예약
			break;

		case "/member/reviewForm.member":
			service.reviewWrite(request, response); // 멤버 예약내역에서 리뷰 작성 구현
			break;

		case "/main.member":
			// 메인페이지 - 기사님정보가져오기 + 리뷰
			service.getMainMaster(request, response);
			break;

		case "/member/point.member":
			service.getMemberPoints(request, response); // 포인트 정보 조회
			break;
		
		case "/member/withdrawPoints.member":
			service.withdrawPoints(request, response);
			break;
			
		case "/member/chargePoints.member":
			service.chargePoints(request, response);
			break;

			
		case "/member/attendanceAjax.member":
			service.attendancepoint(request, response);
			break;
			

		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			break;
		}
	}
	


	/**
	 * 사용자의 세션을 종료하고 로그아웃 후 메인 페이지로 리다이렉트하는 메서드
	 */
	private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {

		// 세션 삭제
		HttpSession session = request.getSession();
		session.invalidate();

		// 화면 이동
		response.setContentType("text/html; charset=UTF-8;");
		PrintWriter out = response.getWriter();
		String contextPath = request.getContextPath();
		out.println("<script>");
		// out.println("alert('로그아웃 되었습니다.');");
		out.println("location.href = '" + contextPath + "/';");
		out.println("</script>");
	}

}