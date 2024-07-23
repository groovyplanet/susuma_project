package com.susuma.review.service;

import java.io.IOException;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.susuma.request.service.RequestService;
import com.susuma.review.model.ReviewDTO;
import com.susuma.review.model.ReviewMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ReviewServiceImpl implements ReviewService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		SqlSession sql = sqlSessionFactory.openSession();
		ReviewMapper Review = sql.getMapper(ReviewMapper.class);
		ArrayList<ReviewDTO> list = Review.getList();
		sql.close();

		request.setAttribute("list", list);
		request.getRequestDispatcher("review_list.jsp").forward(request, response);

	}

}
