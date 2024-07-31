package com.susuma.controller;

import java.io.IOException;

import com.susuma.board.service.BoardService;
import com.susuma.board.service.BoardServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		String uri = request.getRequestURI(); // uri : '/Susuma/member/join.member'
		String path = request.getContextPath(); // path : '/Susuma'
		String command = uri.substring(path.length()); // command : '/member/join.member'

		BoardService service = new BoardServiceImpl();

		switch (command) {
		case "/admin/board/list.board":
			service.getList(request, response); // 게시물 목록
			break;
			
		case "/admin/board/view.board":
			service.adminGetView(request, response); // 게시물 상세
			break;
			
		case "/admin/board/write.board":
			request.setAttribute("type", request.getParameter("type"));
			request.getRequestDispatcher("board_write.jsp").forward(request, response); // 게시물 작성화면
			break;
			
		case "/admin/board/registForm.board":
			service.adminRegister(request, response); // 게시물 등록
			break;
			
		case "/admin/board/modify.board":
			service.adminModify(request, response); // 게시물 수정화면
			break;
			
		case "/admin/board/updateForm.board":
			service.adminUpdate(request, response); // 게시물 수정
			break;
			
		case "/admin/board/delete.board":
			service.adminDelete(request, response); // 게시물 삭제
			break;
			
		case "/admin/board/replyWrite.board":
			service.adminReplyWrite(request, response); // 게시물 답글화면
			break;
			
		case "/admin/board/replyWriteForm.board":
			service.adminReplyRegister(request, response); // 관리자 답글 작성 완료
			break;
			
		case "/board/list.board":
			request.setAttribute("gnb", "board");
			service.getList(request, response); // 게시물 목록(공지사항, faq, 1:1문의)
			break;
			
		case "/board/noticeView.board":
			request.setAttribute("gnb", "board");
			service.noticeGetView(request, response); // 공지사항 상세
			break;
			
		case "/board/askWrite.board":
			request.setAttribute("type", "ask");
			request.setAttribute("gnb", "board");
			request.getRequestDispatcher("/board/ask_write.jsp").forward(request, response); // 1:1문의 작성 & 수정 화면
			break;
			
		case "/board/askRegistForm.board":
			service.askUpsert(request, response); // 1:1문의 등록 & 수정완료
			break;
			
		case "/board/askView.board":
			request.setAttribute("gnb", "board");
			service.askGetView(request, response); // 1:1 문의 상세
			break;
			
		case "/board/askModify.board":
			request.setAttribute("gnb", "board");
			service.askModify(request, response); // 1:1 문의 수정
			break;
			
		case "/board/askDelete.board":
			service.askDelete(request, response); // 1:1 문의 삭제
			break;
			
		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			break;
		}
	}

}
