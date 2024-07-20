package com.susuma.request.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.board.model.BoardDTO;
import com.susuma.board.model.BoardMapper;
import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;
import com.susuma.request.model.RequestDTO;
import com.susuma.request.model.RequestMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class RequestServiceImpl implements RequestService{

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
	
	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	

		SqlSession sql = sqlSessionFactory.openSession();
		RequestMapper relist = sql.getMapper(RequestMapper.class);
		ArrayList<RequestDTO> list = relist.getList();

		sql.close();
		
		request.setAttribute("list", list);
		request.getRequestDispatcher("reserve_list.jsp").forward(request, response);
		
		
		
	
		

	}


}
