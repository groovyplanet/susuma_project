package com.susuma.member.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.board.model.BoardDTO;
import com.susuma.board.model.BoardMapper;
import com.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MemberServiceImpl implements MemberService {
	
	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
	
	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		SqlSession sql = sqlSessionFactory.openSession();
		BoardMapper board = sql.getMapper(BoardMapper.class);
		ArrayList<BoardDTO> list = board.getList();
		sql.close();
		
		request.setAttribute("list", list);
		request.getRequestDispatcher("member_list.jsp").forward(request, response);
		
	}
	
}
