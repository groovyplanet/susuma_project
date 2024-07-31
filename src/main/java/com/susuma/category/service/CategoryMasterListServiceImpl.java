package com.susuma.category.service;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.category.model.MasterListDTO;
import com.susuma.category.model.MasterListMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CategoryMasterListServiceImpl implements CategoryMasterListService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
	
	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	

		SqlSession sql = sqlSessionFactory.openSession();
		MasterListMapper category = sql.getMapper(MasterListMapper.class);
		ArrayList<MasterListDTO> list = category.getList();

		sql.close();
		
		request.setAttribute("list", list);
		request.getRequestDispatcher("master_list.jsp").forward(request, response);
	
	
	}
	
	
}
