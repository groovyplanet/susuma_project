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

public class BoardServiceImpl implements BoardService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* [1] 매개변수 */
		String type = request.getParameter("type");
		type = (type == null || type.isEmpty()) ? "notice" : type; // 기본 : notice
		String answerCheck = request.getParameter("answerCheck");
		answerCheck = (answerCheck == null || answerCheck.isEmpty()) ? "all" : answerCheck; // 기본 : 답변 완료 여부 전체(승인/미승인)

		Map<String, Object> params = new HashMap<>();
		params.put("type", type);
		params.put("answerCheck", answerCheck);

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		BoardMapper Board = sql.getMapper(BoardMapper.class); // BoardMapper 인터페이스를 사용하여 쿼리 실행을 위한 매퍼 객체 생성
		ArrayList<BoardDTO> list = Board.getList(params); // BoardMapper 메서드 호출
		sql.close();

		/* [3] Request */
		request.setAttribute("list", list);
		for (Map.Entry<String, Object> entry : params.entrySet()) {
			request.setAttribute(entry.getKey(), entry.getValue());
		}
		request.getRequestDispatcher("board_list.jsp").forward(request, response); // 요청 포워드
	}

	@Override
	public void getView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* [1] 매개변수 */
		String boNo = request.getParameter("boNo");

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		BoardMapper Board = sql.getMapper(BoardMapper.class);
		BoardDTO dto = Board.getView(boNo);
		sql.close();

		/* [3] Request */
		request.setAttribute("type", dto.getType());
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("board_view.jsp").forward(request, response);
	}

	@Override
	public void regist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* [1] 매개변수 */
		int meNo = Integer.parseInt(request.getParameter("me_no"));
		String type = request.getParameter("type");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		BoardDTO dto = new BoardDTO(meNo, type, title, content);

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper Board = sql.getMapper(BoardMapper.class);
		int result = Board.regist(dto);
		sql.close();

		/* [3] location.href */
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
	public void modify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/* [1] 매개변수 */
		String boNo = request.getParameter("boNo");
		String type = request.getParameter("type");

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper Board = sql.getMapper(BoardMapper.class);
		BoardDTO dto = Board.getView(boNo);
		sql.close();
		/* [3] Request */
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("board_modify.jsp").forward(request, response);
	}
	@Override
	public void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
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
		int result = board.update(dto);
		sql.close();
		
		/* [3] location.href */
		
		if (result == 1) { // 수정 성공
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('게시물이 수정되었습니다.');");
			out.println("location.href='list.board?type=" + type + "';");
			out.println("</script>");
		}else {
			response.sendRedirect("board_view.board?boNo="+boNo);

		}
		
		

	
		
	}

}
