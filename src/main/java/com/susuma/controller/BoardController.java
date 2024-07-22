package com.susuma.controller;

import java.io.IOException;

import com.susuma.board.service.BoardService;
import com.susuma.board.service.BoardServiceImpl;
import com.susuma.member.service.MemberService;
import com.susuma.member.service.MemberServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("*.board")
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

		String uri = request.getRequestURI(); // ip, port번호 제외된 주소
		String path = request.getContextPath(); // 프로젝트 식별 이름
		String command = uri.substring(path.length());
//		System.out.println(command);
		BoardService service;

		if (command.equals("/admin/board/list.board")) { // 게시물 목록

			service = new BoardServiceImpl();
			service.getList(request, response);

		} else if (command.equals("/admin/board/view.board")) { // 게시물 상세

			service = new BoardServiceImpl();
			service.getView(request, response);

		} else if (command.equals("/admin/board/write.board")) { // 게시물 작성화면

			request.setAttribute("type", request.getParameter("type"));
			request.getRequestDispatcher("board_write.jsp").forward(request, response);

		} else if (command.equals("/admin/board/registForm.board")) { // 게시물 등록
			
			service = new BoardServiceImpl();
			service.regist(request, response);
			
		} else if (command.equals("/admin/board/modify.board")) { // 게시물 수정화면
			request.setAttribute("type", request.getParameter("type"));

			service = new BoardServiceImpl();
			service.modify(request, response); //구현 필요
			
		} else if (command.equals("/admin/board/updateForm.board")) { // 게시물 수정
			
			service = new BoardServiceImpl();
			service.update(request, response); //구현 필요
			
		} else if(command.equals("/admin/board/delete.board")) { // 게시물 삭제 
			
			service = new BoardServiceImpl();
			service.delete(request, response);// 구현 필요
			
		}
		
	}

}
