package com.susuma.controller;

import java.io.IOException;

import com.susuma.board.service.BoardService;
import com.susuma.board.service.BoardServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("*.board")
public class BoardController extends HttpServlet {

	private static final long serialVersionUID = 1L;

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

	protected void doAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		String uri = request.getRequestURI(); // uri : '/Susuma/member/join.member'
		String path = request.getContextPath(); // path : '/Susuma'
		String command = uri.substring(path.length()); // command : '/member/join.member'

		BoardService service = new BoardServiceImpl(); // 비즈니스 로직 처리(DB 접근 및 조작 등)

		if (command.equals("/admin/board/list.board")) { // 게시물 목록

			service.getList(request, response);

		} else if (command.equals("/admin/board/view.board")) { // 게시물 상세

			service.adminGetView(request, response);

		} else if (command.equals("/admin/board/write.board")) { // 게시물 작성화면

			request.setAttribute("type", request.getParameter("type"));
			request.getRequestDispatcher("board_write.jsp").forward(request, response);

		} else if (command.equals("/admin/board/registForm.board")) { // 게시물 등록

			service.adminRegister(request, response);

		} else if (command.equals("/admin/board/modify.board")) { // 게시물 수정화면

			service.adminModify(request, response);

		} else if (command.equals("/admin/board/updateForm.board")) { // 게시물 수정

			service.adminUpdate(request, response);

		} else if (command.equals("/admin/board/delete.board")) { // 게시물 삭제

			service.adminDelete(request, response);

		} else if (command.equals("/board/list.board")) { // 사용자 화면 게시물 목록

			// request.setAttribute("key","value"); // 사용자 화면만 별도로 파라미터 지정할 경우 사용,
			// getAttribute로 꺼내기
			service.getList(request, response); // 관리자 게시물 목록과 동일한 메서드 사용

		} else if (command.equals("/board/ask/write.board")) { // 1:1문의 작성화면
			
			HttpSession session = request.getSession();
			String meNo = (String) session.getAttribute("meNo");

			if (meNo == null) {
				response.sendRedirect("/Susuma/index.jsp");
				return;
			}

			request.getRequestDispatcher("/board/ask_write.jsp").forward(request, response);

		} else if (command.equals("/board/registAskForm.board")) { //등록 & 수정완료
			
			service.askUpsert(request, response);
			
		} else if (command.equals("/board/ask_view.board")) {

			HttpSession session = request.getSession();
			String meNo = (String) session.getAttribute("meNo");
			if (meNo == null) {
				response.sendRedirect("/Susuma/index.jsp");
				return;
			}
			service.askGetView(request, response);

			
		} else if (command.equals("/board/modifyAsk.board")) { //수정화면
			
			service.askModify(request, response);

		} 

		} else if(command.equals("/board/notice/view.board")) {
			service.noticeGetView(request, response);
		}

	}

}
