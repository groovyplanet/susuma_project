package com.myweb.controller;

import java.io.IOException;

import com.myweb.board.service.BoardService;
import com.myweb.board.service.BoardServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("*.board") // .board 끝나는 모든 요청은 서블릿으로 연결
public class BoardController extends HttpServlet {

	public BoardController() {
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
		
		//요청 분기
		request.setCharacterEncoding("utf-8");
		
		String uri = request.getRequestURI(); //ip, port번호 제외된 주소
		String path = request.getContextPath(); //프로젝트 식별 이름
		String command = uri.substring( path.length() );
		
		System.out.println(command);
		System.out.println(request.getRemoteAddr());
		
		//boardservice선언
		BoardService service;
		
		
		if(command.equals("/board/list.board")) { //목록화면
			
			//mvc2의 기본이동은 forward이다
			//서비스 영역을 거쳐서 목록 data를 가지고 감
			service = new BoardServiceImpl();
			service.getList(request, response);
			
		} else if(command.equals("/board/write.board") ) { //글 작성화면
			
//			HttpSession session = request.getSession();
//			String user_id = (String)session.getAttribute("user_id");
//			
//			if(user_id == null) {
//				response.sendRedirect("/MyWeb/index.jsp");
//				return;
//			}
			
			request.getRequestDispatcher("board_write.jsp").forward(request, response);
		
		} else if(command.equals("/board/registForm.board") ) { //글 등록
			

			
			
			service = new BoardServiceImpl();
			service.regist(request, response);
			
		} else if(command.equals("/board/getContent.board")) { //글 상세 내용
			
			service = new BoardServiceImpl();
			service.getContent(request, response);
			
		} else if(command.equals("/board/modify.board")) { //수정 화면으로
			

			
			service = new BoardServiceImpl();
			service.modify(request, response);
			
			
		} else if(command.equals("/board/updateForm.board")) { //글 수정
			

			
			service = new BoardServiceImpl();
			service.update(request, response);
			
		} else if(command.equals("/board/delete.board")) { //삭제 처리
			

			
			service = new BoardServiceImpl();
			service.delete(request, response);
					
			
			
		}
		
		
		
		
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
