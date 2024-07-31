package com.susuma.util.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.alert.model.AlertDTO;
import com.susuma.alert.model.AlertMapper;
import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;
import com.susuma.message.service.MessageService;
import com.susuma.message.service.MessageServiceImpl;
import com.susuma.request.model.RequestDTO;
import com.susuma.request.model.RequestMapper;
import com.susuma.request.service.RequestService;
import com.susuma.request.service.RequestServiceImpl;
import com.susuma.util.mybatis.MybatisUtil;

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

		// 로그인 상태 확인
		if (meNo != null) {
			// 읽지 않은 메시지 개수
			MessageService messageService = new MessageServiceImpl();
            int unreadMsgCount = messageService.getUnreadMessageCount(meNo);
            request.setAttribute("unreadMsgCount", unreadMsgCount);
            
            if(type.equals("master")) {
                // 수리기사인 경우 
            	
            	//새로운 예약 신청 개수
        		RequestService requestService = new RequestServiceImpl();
                int newRequestCount = requestService.getNewRequestCount(meNo);
                request.setAttribute("newRequestCount", newRequestCount);
                
                //알림
            	SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
        		SqlSession sql = sqlSessionFactory.openSession();
    			AlertMapper alertMapper = sql.getMapper(AlertMapper.class);
    			int newAlertCount = alertMapper.getNewAlertCount(meNo);
                request.setAttribute("newAlertCount", newAlertCount);
                ArrayList<AlertDTO> alertList = alertMapper.selectAlerts(meNo);
                request.setAttribute("alertList", alertList);
                sql.close();
                
            }
            
		}

		// 관리자 페이지 접근 제어
		if (command.startsWith("/admin")) {

			if (meNo == null || !type.equals("admin")) {
				response.setContentType("text/html; charset=UTF-8;");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('관리자만 접근 가능한 페이지입니다.');");
				out.println("location.href='" + request.getContextPath() + "/';");
				out.println("</script>");
				return;
			}

		} else {

			// 로그인 시 접근 가능
			switch (command) {
			case "/member/edit.member": // 프로필 수정
			case "/member/mypage.member": // 마이페이지
			case "/member/exit.member": // 회원 탈퇴
			case "/member/memberRequest.member": // 수리 예약
			case "/member/reviewForm.member": // 예약내역 리뷰 작성
			case "/member/request.member": // 수리 예약
			case "/member/point.member": // 포인트
			case "/member/list.message": // 포인트
			case "/board/askWrite.board": // 1:1 문의 작성
			case "/board/askView.board": // 1:1 문의 상세
			case "/board/askModify.board": // 1:1 문의 수정
			case "/member/list.review": // 리뷰 리스트 페이지
			case "/member/list.request": // 예약 내역
			case "/member/view.request": // 예약 상세
			case "/member/masterList.member":// 수리예약화면
			case "/member/form.message":// 채팅창
				if (meNo == null) {
					response.setContentType("text/html; charset=UTF-8;");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('로그인이 필요한 서비스 입니다.');");
					out.println("location.href='" + request.getContextPath() + "/';");
					out.println("</script>");
					return; // 컨트롤러 실행 x
				}

			}

			// 의뢰인만 접근 가능
			switch (command) {
			case "/member/request.member": // 수리 예약
			case "/member/masterList.member":// 수리예약화면
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
