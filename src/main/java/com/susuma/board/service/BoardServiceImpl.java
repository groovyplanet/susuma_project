package com.susuma.board.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.board.model.BoardDTO;
import com.susuma.board.model.BoardMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BoardServiceImpl implements BoardService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
	public final int recordsPerPage = 10; // 한 페이지당 보여줄 레코드 수

	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* [1] 매개변수 */
		HttpSession session = request.getSession();
		String meNo = (String) session.getAttribute("meNo"); // myask 인 경우 사용
		String type = request.getParameter("type");
		type = (type == null || type.isEmpty()) ? "notice" : type; // 기본 : notice
		String answerCheck = request.getParameter("answerCheck");
		answerCheck = (answerCheck == null || answerCheck.isEmpty()) ? "all" : answerCheck; // 기본 : 답변 완료 여부 전체(승인/미승인)
		String title = request.getParameter("title");
		String sortField = request.getParameter("sortField");
		sortField = (sortField == null || sortField.isEmpty()) ? "insert_time" : sortField;
		String sortOrder = request.getParameter("sortOrder");
		sortOrder = (sortOrder == null || sortOrder.isEmpty()) ? "DESC" : sortOrder;
		int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		int startRow = (currentPage - 1) * recordsPerPage + 1;
		int endRow = startRow + recordsPerPage - 1;

		Map<String, Object> params = new HashMap<>();
		params.put("meNo", meNo);
		params.put("type", type);
		params.put("answerCheck", answerCheck);
		params.put("title", title);
		params.put("sortField", sortField);
		params.put("sortOrder", sortOrder);
		params.put("startRow", startRow); // rownum 시작값
		params.put("endRow", endRow); // rownum 끝값

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		BoardMapper Board = sql.getMapper(BoardMapper.class); // BoardMapper 인터페이스를 사용하여 쿼리 실행을 위한 매퍼 객체 생성
		ArrayList<BoardDTO> list = Board.selectBoards(params); // BoardMapper 메서드 호출

		// 페이징 관련
		int totalRecords = Board.countBoards(params); // 해당되는 게시물 수 (페이징)
		int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
		int startPage = Math.max(currentPage - 2, 1);
		int endPage = Math.min(currentPage + 2, totalPages);
		endPage = (currentPage == 1 || currentPage == 2) ? Math.min(endPage + 3 - currentPage, totalPages) : endPage;
		startPage = (currentPage == totalPages || currentPage == totalPages - 1)
				? Math.max(startPage - 2 + totalPages - currentPage, 1)
				: startPage;
		params.put("currentPage", currentPage); // 현재 페이지
		params.put("totalPages", totalPages); // 총 페이지 수
		params.put("totalRecords", totalRecords); // 총 레코드 수
		params.put("startPage", startPage); // 표시할 시작 페이지
		params.put("endPage", endPage); // 표시할 마지막 페이지
		sql.close();

		/* [3] 화면이동 */
		request.setAttribute("list", list);
		for (Map.Entry<String, Object> entry : params.entrySet()) {
			request.setAttribute(entry.getKey(), entry.getValue());
		}
		request.getRequestDispatcher("board_list.jsp").forward(request, response); // 요청 포워드
	}

	@Override
	public void adminGetView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		/* [1] 매개변수 */
		String boNo = request.getParameter("boNo");

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		BoardMapper Board = sql.getMapper(BoardMapper.class);
		BoardDTO dto = Board.selectBoard(boNo);
		sql.close();

		/* [3] 화면이동 */
		request.setAttribute("type", dto.getType());
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("board_view.jsp").forward(request, response);
	}

	@Override
	public void adminRegister(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		/* [1] 매개변수 */
		int meNo = Integer.parseInt(request.getParameter("me_no"));
		String type = request.getParameter("type");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		BoardDTO dto = new BoardDTO(meNo, type, title, content);

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper Board = sql.getMapper(BoardMapper.class);
		int result = Board.insertBoard(dto);
		sql.close();

		/* [3] 화면이동 */
		if (result == 1) { // 등록 성공
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('게시물이 등록되었습니다.');");
			out.println("location.href='list.board?type=" + type + "';");
			out.println("</script>");
		}
	}

	@Override
	public void adminModify(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		/* [1] 매개변수 */
		String boNo = request.getParameter("boNo");

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper Board = sql.getMapper(BoardMapper.class);
		BoardDTO dto = Board.selectBoard(boNo);
		sql.close();

		/* [3] 화면이동 */
		request.setAttribute("dto", dto);
		request.setAttribute("type", dto.getType());
		request.getRequestDispatcher("board_modify.jsp").forward(request, response);
	}

	@Override
	public void adminUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		/* [1] 매개변수 */
		String boNo = request.getParameter("boNo");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String type = request.getParameter("type");
		BoardDTO dto = new BoardDTO();
		dto.setBoNo(Integer.parseInt(boNo));
		dto.setTitle(title);
		dto.setContent(content);
		dto.setType(type);
		dto.setUpdateTime(Timestamp.valueOf(LocalDateTime.now()));

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper board = sql.getMapper(BoardMapper.class);
		int result = board.updateBoard(dto);
		sql.close();

		/* [3] 화면이동 */
		if (result == 1) { // 수정 성공
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('게시물이 수정되었습니다.');");
			out.println("location.href='list.board?type=" + type + "';");
			out.println("</script>");
		} else {
			response.sendRedirect("view.board?boNo=" + boNo);

		}

	}

	@Override
	public void adminDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		/* [1] 매개변수 */
		String boNo = request.getParameter("boNo");
		String type = request.getParameter("type");

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper board = sql.getMapper(BoardMapper.class);
		board.deleteBoard(boNo);
		sql.close();

		/* [3] 화면이동 */
		response.setContentType("text/html; charset=UTF-8;");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('게시물이 삭제되었습니다.');");
		out.println("location.href='list.board?type=" + type + "';");
		out.println("</script>");

	}

	@Override
	public void askUpsert(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String meNoStr = (String) session.getAttribute("meNo");
		int meNo = 0;
		if (meNoStr != null) {
			try {
				meNo = Integer.parseInt(meNoStr);
			} catch (NumberFormatException e) {
				// 로그에 오류 기록 또는 기본값 설정
				System.out.println("meNo is not a valid integer: " + meNoStr);
				meNo = -1; // 기본값 설정
			}
		}
//		int meNo = 30;
		String boNo = request.getParameter("boNo");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String type = "ask";

		BoardDTO dto = new BoardDTO();
		dto.setMeNo(meNo);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setType(type);

		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper board = sql.getMapper(BoardMapper.class);
		int result = 0;
		if (boNo == null || boNo.equals("")) { // insert
			result = board.askWrite(dto);
		} else {
			dto.setBoNo(Integer.parseInt(boNo));
			result = board.updateBoard(dto);
		}

		sql.close();

		if (result == 1) {
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('1:1문의가 " + (boNo == null || boNo.equals("") ? "등록" : "수정") + "되었습니다');");
			out.println("location.href='list.board?type=" + type + "';");
			out.println("</script>");
		}

	}

	@Override
	public void askGetView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String meNoStr = (String) session.getAttribute("meNo");
		String type = (String) session.getAttribute("type");
		String boNo = request.getParameter("boNo");
		int meNo = 0;
		if (meNoStr != null) {
			try {
				meNo = Integer.parseInt(meNoStr);
			} catch (NumberFormatException e) {
				// 로그에 오류 기록 또는 기본값 설정
				System.out.println("meNo is not a valid integer: " + meNoStr);
				meNo = -1; // 기본값 설정
			}
		}
		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper board = sql.getMapper(BoardMapper.class);
		BoardDTO dto = board.askView(boNo);
		sql.close();

		if (meNo == dto.getMeNo() || type.equals("admin")) {
			request.setAttribute("dto", dto);
			request.setAttribute("type", dto.getType());
			request.getRequestDispatcher("ask_view.jsp").forward(request, response);
		} else {
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('작성자 본인만 확인할 수 있습니다.');");
			out.println("location.href='list.board?type=ask';");
			out.println("</script>");
		}

	}

	@Override
	public void askModify(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String meNoStr = (String) session.getAttribute("meNo");
		String boNo = request.getParameter("boNo");
		int meNo = 0;
		if (meNoStr != null) {
			try {
				meNo = Integer.parseInt(meNoStr);
			} catch (NumberFormatException e) {
				// 로그에 오류 기록 또는 기본값 설정
				System.out.println("meNo is not a valid integer: " + meNoStr);
				meNo = -1; // 기본값 설정
			}
		}

		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper board = sql.getMapper(BoardMapper.class);
		BoardDTO dto = board.selectBoard(boNo);
		sql.close();

		request.setAttribute("dto", dto);
		request.setAttribute("type", "ask");
		request.getRequestDispatcher("ask_write.jsp").forward(request, response);

	}
	
	@Override
	public void askDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String meNoStr = (String) session.getAttribute("meNo");
		String boNo = request.getParameter("boNo");
		int meNo = 0;
		
		if (meNoStr != null) {
			try {
				meNo = Integer.parseInt(meNoStr);
			} catch (NumberFormatException e) {
				// 로그에 오류 기록 또는 기본값 설정
				System.out.println("meNo is not a valid integer: " + meNoStr);
				meNo = -1; // 기본값 설정
			}
		}

		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper board = sql.getMapper(BoardMapper.class);
		board.deleteBoard(boNo);
		sql.close();
		
		response.setContentType("text/html; charset=UTF-8;");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('1:1 문의가 삭제되었습니다.');");
		out.println("location.href='list.board?type=ask';");
		out.println("</script>");
		
	}
	
	@Override
	public void noticeGetView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* [1] 매개변수 */
		String boNo = request.getParameter("boNo");

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		BoardMapper Board = sql.getMapper(BoardMapper.class);
		BoardDTO dto = Board.selectBoard(boNo);
		sql.close();
		
		SqlSession sql2 = sqlSessionFactory.openSession();
		BoardMapper Board2 = sql2.getMapper(BoardMapper.class);
		BoardDTO sidedto = Board2.getPreNext(boNo);
		sql.close();

		/* [3] 화면이동 */
		request.setAttribute("type", dto.getType());
		request.setAttribute("sidedto", sidedto);
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("/board/notice_view.jsp").forward(request, response);
		
		
	}
	@Override
	public void adminReplyWrite(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		/* [1] 매개변수 */
		String boNo = request.getParameter("boNo");

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper Board = sql.getMapper(BoardMapper.class);
		BoardDTO dto = Board.selectBoard(boNo);
		sql.close();

		/* [3] 화면이동 */
		request.setAttribute("dto", dto);
		request.setAttribute("type", dto.getType());
		request.getRequestDispatcher("board_view_modify.jsp").forward(request, response);
		
	}
	@Override
	public void adminReplyRegister(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String boNo = request.getParameter("boNo");
		String answer = request.getParameter("answer");
		
		
		BoardDTO dto = new BoardDTO();
		dto.setBoNo(Integer.parseInt(boNo));
		dto.setAnswer(answer);
		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper board = sql.getMapper(BoardMapper.class);
		int result = board.insertReply(dto);
		sql.close();
		
		if (result == 1) {
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('1:1답변이 등록되었습니다');");
			out.println("location.href='list.board?type=ask';");
			out.println("</script>");
		}
	}
	


}
