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

	}@Override
	public void submitReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  SqlSession sqlSession = null;
	        try {
	            sqlSession = sqlSessionFactory.openSession();
	            ReviewMapper reviewMapper = sqlSession.getMapper(ReviewMapper.class);
	            RequestMapper requestMapper = sqlSession.getMapper(RequestMapper.class);

	            // reqNo 값을 확인합니다.
	            String reqNo = request.getParameter("reqNo");
	            if (reqNo == null || reqNo.isEmpty()) {
	                throw new ServletException("reqNo is missing");
	            }

	            // RequestDTO를 가져옵니다.
	            RequestDTO requestDTO = requestMapper.getRequestByReqNo(reqNo);
	            if (requestDTO == null) {
	                throw new ServletException("RequestDTO not found for reqNo: " + reqNo);
	            }

	            String masterNo = requestDTO.getMasterNo();

	            // ReviewDTO를 생성합니다.
	            String content = request.getParameter("content");
	            String starScoreStr = request.getParameter("starScore");

	            int starScore = 0;
	            if (starScoreStr != null && !starScoreStr.isEmpty()) {
	                try {
	                    starScore = Integer.parseInt(starScoreStr);
	                } catch (NumberFormatException e) {
	                    starScore = 0; // 기본 값 설정
	                }
	            }

	            ReviewDTO review = new ReviewDTO();
	            review.setReqNo(reqNo);
	            review.setMasterNo(masterNo); // masterNo를 설정합니다.
	            review.setContent(content);
	            review.setStarScore(starScore);

	            // ReviewDTO를 DB에 삽입합니다.
	            reviewMapper.insertReview(review);
	            sqlSession.commit();

	            // 리뷰 목록을 가져와서 뷰에 전달합니다.
	            ArrayList<ReviewDTO> list = reviewMapper.getList();
	            request.setAttribute("list", list);
	            request.getRequestDispatcher("review_list.jsp").forward(request, response);
	        } catch (Exception e) {
	            if (sqlSession != null) {
	                sqlSession.rollback();
	            }
	            throw new ServletException("Error submitting review", e);
	        } finally {
	            if (sqlSession != null) {
	                sqlSession.close();
	            }
	        }
	    }
	}