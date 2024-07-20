package com.susuma.board.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.board.model.BoardDTO;
import com.susuma.board.model.BoardMapper;
import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BoardServiceImpl implements BoardService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String type = request.getParameter("type");
		
		SqlSession sql = sqlSessionFactory.openSession();

		BoardMapper board = sql.getMapper(BoardMapper.class);
		ArrayList<BoardDTO> list = board.getList(type);
		sql.close();

		request.setAttribute("type", type);
		request.setAttribute("list", list);
		request.getRequestDispatcher("board_list.jsp").forward(request, response);

	}

	@Override
	public void getView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String boNo = request.getParameter("boNo");

		SqlSession sql = sqlSessionFactory.openSession();

		BoardMapper board = sql.getMapper(BoardMapper.class);
		BoardDTO dto = board.getView(boNo);
		sql.close();

		request.setAttribute("type", dto.getType());
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("board_view.jsp").forward(request, response);

	}
	
	@Override
	public void regist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String title = request.getParameter("subject");
		String content =request.getParameter("content");
		String type = "notice";
		int meNo = 1;
		
		BoardDTO dto = new BoardDTO();
		dto.setContent(content);
		dto.setTitle(title);
		dto.setMeNo(meNo);
		dto.setType(type);
		
		SqlSession sql = sqlSessionFactory.openSession(true);
		BoardMapper board = sql.getMapper(BoardMapper.class);
		int result = board.regist(dto);
		sql.close();
		
		request.setAttribute("type", type);
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("board_view.jsp").forward(request, response);
		
		
	}

}
