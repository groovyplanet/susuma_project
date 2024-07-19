package com.susuma.member.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MemberServiceImpl implements MemberService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		SqlSession sql = sqlSessionFactory.openSession();

		MemberMapper Member = sql.getMapper(MemberMapper.class);
		ArrayList<MemberDTO> list = Member.getList();
		sql.close();

		request.setAttribute("snbCurrent", "member");
		request.setAttribute("list", list);
		request.getRequestDispatcher("member_list.jsp").forward(request, response);

	}

	@Override
	public void getView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String meNo = request.getParameter("meNo");

		SqlSession sql = sqlSessionFactory.openSession();

		MemberMapper Member = sql.getMapper(MemberMapper.class);
		MemberDTO dto = Member.getView(meNo);
		sql.close();

		request.setAttribute("snbCurrent", "member");
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("member_view.jsp").forward(request, response);
		
	}
}
