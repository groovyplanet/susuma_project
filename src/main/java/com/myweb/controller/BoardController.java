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
		
		request.setCharacterEncoding("utf-8");
		
		String uri = request.getRequestURI(); //ip, port번호 제외된 주소
		String path = request.getContextPath(); //프로젝트 식별 이름
		String command = uri.substring( path.length() );
		
		System.out.println(command);
		System.out.println(request.getRemoteAddr());
		
		BoardService service;
		
		if(command.equals("/board/list.board")) { //목록화면
			
			service = new BoardServiceImpl();
			service.getList(request, response);
			
		}
		
	}
	
}
