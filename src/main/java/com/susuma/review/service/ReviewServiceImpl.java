package com.susuma.review.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.review.model.ReviewDTO;
import com.susuma.review.model.ReviewMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ReviewServiceImpl implements ReviewService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

	/**
	 * alert창 띄우고 화면 이동
	 */
	private void alertRedirect(HttpServletResponse response, String message, String url) throws IOException {
		response.setContentType("text/html; charset=UTF-8;");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('" + message + "');");
		if (url.equals("back")) {
			out.println("history.back();");
		} else {
			out.println("location.href='" + url + "';");
		}
		out.println("</script>");
	}

	/**
	 * DTO 생성(upsert 시 사용)
	 */
	private ReviewDTO createReviewDTO(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		String reNo = request.getParameter("reNo");
		String reqNo = request.getParameter("reqNo");
		String content = request.getParameter("content");
		String starScore = request.getParameter("starScore");
		return new ReviewDTO(reNo, reqNo, content, starScore);
	}

	/**
	 * 데이터베이스 작업
	 */
	private int reviewUpsert(ReviewDTO reviewDTO, boolean isUpdate) {
		SqlSession sql = sqlSessionFactory.openSession(true);
		ReviewMapper reviewMapper = sql.getMapper(ReviewMapper.class);
		int result;
		if (isUpdate) {
			result = reviewMapper.updateReview(reviewDTO);
		} else {
			result = reviewMapper.insertReview(reviewDTO);
		}
		sql.close();
		return result;
	}

	/**
	 * 리뷰 가져오기
	 */
	public void getReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* [1] 매개변수 */
		String reNo = request.getParameter("reNo");
		Map<String, Object> params = new HashMap<>();
		params.put("reNo", reNo);

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		ReviewMapper reviewMapper = sql.getMapper(ReviewMapper.class);
		ReviewDTO reviewDTO = reviewMapper.selectReview(params);
		sql.close();

		/* [3] 요청에 데이터 설정 */
		request.setAttribute("reviewDTO", reviewDTO);
	}

	/**
	 * 리뷰 목록
	 */
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* [1] 매개변수 */
		String clientNo = request.getParameter("clientNo");
		String masterNo = request.getParameter("masterNo");

		HttpSession session = request.getSession();
		String meNo = (String) session.getAttribute("meNo");
		String type = (String) session.getAttribute("type");
		if ("master".equals(type)) {
			masterNo = meNo;
		} else if ("user".equals(type)) {
			clientNo = meNo;
		}
		int recordsPerPage = 2; // 한 페이지당 보여줄 레코드 수
		if ("admin".equals(type)) {
			recordsPerPage = 10;
		}

		String sortField = request.getParameter("sortField");
		sortField = (sortField == null || sortField.isEmpty()) ? "RE.insert_time" : sortField;
		String sortOrder = request.getParameter("sortOrder");
		sortOrder = (sortOrder == null || sortOrder.isEmpty()) ? "DESC" : sortOrder;
		int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		int startRow = (currentPage - 1) * recordsPerPage + 1;
		int endRow = startRow + recordsPerPage - 1;

		Map<String, Object> params = new HashMap<>();
		params.put("clientNo", clientNo);
		params.put("masterNo", masterNo);
		params.put("sortField", sortField);
		params.put("sortOrder", sortOrder);
		params.put("startRow", startRow); // rownum 시작값
		params.put("endRow", endRow); // rownum 끝값

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		ReviewMapper reviewMapper = sql.getMapper(ReviewMapper.class);
		ArrayList<ReviewDTO> reviewList = reviewMapper.selectReviews(params);

		// 페이징
		int totalRecords = reviewMapper.countReviews(params);
		int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
		int startPage = Math.max(currentPage - 2, 1);
		int endPage = Math.min(currentPage + 2, totalPages);
		endPage = (currentPage == 1 || currentPage == 2) ? Math.min(endPage + 3 - currentPage, totalPages) : endPage;
		startPage = (currentPage == totalPages || currentPage == totalPages - 1) ? Math.max(startPage - 2 + totalPages - currentPage, 1) : startPage;
		params.put("currentPage", currentPage); // 현재 페이지
		params.put("totalPages", totalPages); // 총 페이지 수
		params.put("totalRecords", totalRecords); // 총 레코드 수
		params.put("startPage", startPage); // 표시할 시작 페이지
		params.put("endPage", endPage); // 표시할 마지막 페이지
		params.put("recordsPerPage", recordsPerPage);
		sql.close();

		request.setAttribute("list", reviewList);
		for (Map.Entry<String, Object> entry : params.entrySet()) {
			request.setAttribute(entry.getKey(), entry.getValue());
		}
	}

	@Override
	public void adminList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		getList(request, response); // 관리자, 사용자 공통
		request.getRequestDispatcher("review_list.jsp").forward(request, response); // 요청 포워드

	}

	@Override
	public void adminUpsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ReviewDTO reviewDTO = createReviewDTO(request, response); // 별도 함수로 처리
		boolean isUpdate = reviewDTO.getReNo() != null && !reviewDTO.getReNo().isEmpty();
		int result = reviewUpsert(reviewDTO, isUpdate);

		if (result == 1) {
			alertRedirect(response, "정상적으로 " + (isUpdate ? "수정" : "등록") + "되었습니다.", "view.request?reqNo=" + reviewDTO.getReqNo());
		}

	}

	@Override
	public void adminDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* [1] 매개변수 */
		String reNo = request.getParameter("reNo");
		String reqNo = request.getParameter("reqNo");

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession(true);
		ReviewMapper reviewMapper = sql.getMapper(ReviewMapper.class);
		reviewMapper.deleteReview(reNo);
		sql.close();

		/* [3] 화면이동 */
		alertRedirect(response, "리뷰가 삭제되었습니다.", "view.request?reqNo=" + reqNo);

	}

	@Override
	public void getReviewList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		getList(request, response); // 관리자, 사용자 공통
		request.getRequestDispatcher("review_list.jsp").forward(request, response); // 요청 포워드
	}

	@Override
	public void upsertReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ReviewDTO reviewDTO = createReviewDTO(request, response); // 별도 함수로 처리
		boolean isUpdate = reviewDTO.getReNo() != null && !reviewDTO.getReNo().isEmpty();
		int result = reviewUpsert(reviewDTO, isUpdate);

		if (result == 1) {
			alertRedirect(response, "정상적으로 " + (isUpdate ? "수정" : "등록") + "되었습니다.", "view.request?reqNo=" + reviewDTO.getReqNo());
		}

	}

	@Override
	public void getReviewListAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		getList(request, response); // 관리자, 사용자 공통

		RequestDispatcher dispatcher = request.getRequestDispatcher("review_list_fragment.jsp");
		dispatcher.forward(request, response);
		
	}
}
