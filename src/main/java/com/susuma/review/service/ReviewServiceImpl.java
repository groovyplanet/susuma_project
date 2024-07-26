package com.susuma.review.service;

import java.io.IOException;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.request.model.RequestDTO;
import com.susuma.request.model.RequestMapper;
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

	@Override
	public void submitReview(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		SqlSession sqlSession = sqlSessionFactory.openSession();
		ReviewMapper reviewMapper = sqlSession.getMapper(ReviewMapper.class);

		// reqNo 값을 확인합니다.
		String reqNo = request.getParameter("reqNo");
		String content = request.getParameter("content");
		String starScore = request.getParameter("starScore");

		ReviewDTO review = new ReviewDTO();
		review.setReqNo(reqNo);
		review.setContent(content);
		review.setStarScore(starScore);

		// ReviewDTO를 DB에 삽입합니다.
		reviewMapper.insertReview(review);
		sqlSession.commit();

		// 리뷰 목록을 가져와서 뷰에 전달합니다.
		ArrayList<ReviewDTO> list = reviewMapper.getList();
		request.setAttribute("list", list);
		request.getRequestDispatcher("review_list.jsp").forward(request, response);

	}
}
