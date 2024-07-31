package com.susuma.request.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.member.model.MemberMapper;
import com.susuma.message.model.MessageMapper;
import com.susuma.point.model.PointDTO;

import com.susuma.point.model.PointMapper;
import com.susuma.request.model.RequestDTO;
import com.susuma.request.model.RequestMapper;
import com.susuma.review.model.ReviewDTO;
import com.susuma.review.model.ReviewMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RequestServiceImpl implements RequestService {

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
	private RequestDTO createRequestDTO(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		int reqNo = request.getParameter("reqNo") == null ? 0 : Integer.parseInt(request.getParameter("reqNo"));
		String masterNo = request.getParameter("masterNo");
		String clientNo = request.getParameter("clientNo");
		String content = request.getParameter("content");
		String requestDate = request.getParameter("requestDate");
		String requestTime = request.getParameter("requestTime");
		String status = request.getParameter("status");
		String payAmount = request.getParameter("payAmount");
		String cancelReason = request.getParameter("cancelReason");
		return new RequestDTO(reqNo, masterNo, clientNo, content, requestDate, requestTime, status, payAmount, cancelReason);
	}

	/**
	 * 데이터베이스 작업
	 */
	private int requestUpsert(RequestDTO requestDTO, boolean isUpdate) {
		SqlSession sql = sqlSessionFactory.openSession(true);
		RequestMapper requestMapper = sql.getMapper(RequestMapper.class);
		int result;
		if (isUpdate) {
			result = requestMapper.updateRequest(requestDTO);
		} else {
			result = requestMapper.insertRequest(requestDTO);
		}
		sql.close();
		return result;
	}

	/**
	 * 수리 요청 가져오기
	 */
	public void getRequestDTO(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* [1] 매개변수 */
		String reqNo = request.getParameter("reqNo");
		Map<String, Object> params = new HashMap<>();
		params.put("reqNo", reqNo);

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		RequestMapper requestMapper = sql.getMapper(RequestMapper.class);
		RequestDTO requestDTO = requestMapper.selectRequest(params);
		ReviewMapper reviewMapper = sql.getMapper(ReviewMapper.class);
		ReviewDTO reviewDTO = reviewMapper.selectReview(params);
		sql.close();
		
		/* [3] 요청에 데이터 설정 */
		request.setAttribute("requestDTO", requestDTO);
		request.setAttribute("reviewDTO", reviewDTO);
	}

	/**
	 * 수리 요청 목록
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

		String status = request.getParameter("status");
		status = (status == null || status.isEmpty()) ? "all" : status;
		String sortField = request.getParameter("sortField");
		sortField = (sortField == null || sortField.isEmpty()) ? "R.insert_time" : sortField;
		String sortOrder = request.getParameter("sortOrder");
		sortOrder = (sortOrder == null || sortOrder.isEmpty()) ? "DESC" : sortOrder;
		int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		int startRow = (currentPage - 1) * recordsPerPage + 1;
		int endRow = startRow + recordsPerPage - 1;

		Map<String, Object> params = new HashMap<>();
		params.put("clientNo", clientNo);
		params.put("masterNo", masterNo);
		params.put("status", status);
		params.put("sortField", sortField);
		params.put("sortOrder", sortOrder);
		params.put("startRow", startRow); // rownum 시작값
		params.put("endRow", endRow); // rownum 끝값

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		RequestMapper requestMapper = sql.getMapper(RequestMapper.class);
		ArrayList<RequestDTO> requestList = requestMapper.selectRequests(params);
		RequestDTO cntDTO = requestMapper.selectRequestCnts(params);

		// 페이징
		int totalRecords = requestMapper.countRequests(params);
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

		request.setAttribute("list", requestList);
		request.setAttribute("cntDTO", cntDTO);
		for (Map.Entry<String, Object> entry : params.entrySet()) {
			request.setAttribute(entry.getKey(), entry.getValue());
		}
	}

	@Override
	public void adminList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		getList(request, response); // 관리자, 사용자 공통

		request.setAttribute("type", "request");
		request.getRequestDispatcher("request_list.jsp").forward(request, response); // 요청 포워드
	}

	@Override
	public void adminView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 수리 요청 정보 가져오기
		getRequestDTO(request, response);

		// 포워딩
		request.setAttribute("type", "request");
		request.getRequestDispatcher("request_view.jsp").forward(request, response);
	}

	@Override
	public void adminEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setAttribute("type", "request");

		// 수리 요청 정보 가져오기
		getRequestDTO(request, response);

		// 포워딩
		request.setAttribute("type", "request");
		request.getRequestDispatcher("request_edit.jsp").forward(request, response);
	}

	@Override
	public void adminUpsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDTO requestDTO = createRequestDTO(request, response); // 별도 함수로 처리
		boolean isUpdate = true;
		int result = requestUpsert(requestDTO, isUpdate);

		if (result == 1) {
			alertRedirect(response, "정상적으로 수정되었습니다.", "edit.request?reqNo=" + requestDTO.getReqNo());
		}

	}

	@Override
	public void adminDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* [1] 매개변수 */
		String reqNo = request.getParameter("reqNo");

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession(true);
		RequestMapper requestMapper = sql.getMapper(RequestMapper.class);
		requestMapper.deleteRequest(reqNo);
		sql.close();

		/* [3] 화면이동 */
		alertRedirect(response, "수리요청 정보가 삭제되었습니다.", "list.request");

	}

	@Override
	public void getRequestList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		getList(request, response); // 관리자, 사용자 공통
		request.getRequestDispatcher("request_list.jsp").forward(request, response); // 요청 포워드
	}

	@Override
	public void getRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		// 수리 요청 정보 + 리뷰 가져오기
		getRequestDTO(request, response);

		// 포워딩
		request.getRequestDispatcher("request_view.jsp").forward(request, response);

	}

	@Override
	public void upsertRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDTO requestDTO = createRequestDTO(request, response); // 별도 함수로 처리
		boolean isUpdate = true;
		int result = requestUpsert(requestDTO, isUpdate);

		if (result == 1) {
			alertRedirect(response, "정상적으로 수정되었습니다.", "edit.request?reqNo=" + requestDTO.getReqNo());
		}
	}

//	public void updateStatusAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//		RequestDTO requestDTO = createRequestDTO(request, response); // 별도 함수로 처리
//		boolean isUpdate = true;
//		int result = requestUpsert(requestDTO, isUpdate);
//
//		response.setContentType("text/plain");
//		response.setCharacterEncoding("UTF-8");
//		try (PrintWriter out = response.getWriter()) {
//			if (result == 1) {
//				out.write("Success");
//			} else {
//				out.write("Failure");
//			}
//		}
//	}

	public void updateStatusAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String resultMessage = "Success";

		// 결제할 경우 [1]의뢰인 point 차감, [2]수리기사 point 적립, [3]수리기사 point_history
		String status = request.getParameter("status");
		if (status.equals("paid")) {

			int payAmount = request.getParameter("payAmount") == null ? 0 : Integer.parseInt(request.getParameter("payAmount"));
			SqlSession sql = sqlSessionFactory.openSession(true);
			PointMapper pointMapper = sql.getMapper(PointMapper.class);
			MemberMapper memberMapper = sql.getMapper(MemberMapper.class);
			RequestMapper requestMapper = sql.getMapper(RequestMapper.class);

			String reqNo = request.getParameter("reqNo");
			Map<String, Object> params = new HashMap<>();
			params.put("reqNo", reqNo);
			RequestDTO requestDTO2 = requestMapper.selectRequest(params);
			String meNo = requestDTO2.getClientNo();
			Integer currentPoints = pointMapper.MemberPoints(meNo);
			if (currentPoints == null)
				currentPoints = 0;
			if (currentPoints < payAmount) {
				resultMessage = "잔액이 부족합니다.";
			} else {

				// [1] request 업데이트
				RequestDTO requestDTO = createRequestDTO(request, response);
				boolean isUpdate = true;
				int result = requestUpsert(requestDTO, isUpdate);

				// [2] 의뢰인 point 차감
				Map<String, Object> params2 = new HashMap<>();
				params2.put("meNo", meNo);
				params2.put("point", currentPoints - payAmount);
				memberMapper.updateMemberPoints(params2);

				// [3] 수리기사 point 적립
				String masterNo = requestDTO2.getMasterNo();
				int currentMasterPoints = pointMapper.MemberPoints(masterNo);
				Map<String, Object> params3 = new HashMap<>();
				params3.put("meNo", masterNo);
				params3.put("point", currentMasterPoints + payAmount);
				memberMapper.updateMemberPoints(params3);
			}

			sql.close();

		} else {

			// [1] request 업데이트
			RequestDTO requestDTO = createRequestDTO(request, response);
			boolean isUpdate = true;
			int result = requestUpsert(requestDTO, isUpdate);
		}

		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		try (PrintWriter out = response.getWriter()) {
			out.write(resultMessage);
		}
	}

	@Override
	public void getRequestListAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		getList(request, response); // 관리자, 사용자 공통

		// AJAX 요청을 처리하는 서블릿에서 RequestDispatcher를 사용하여 JSP 파일로 포워딩하면,
		// 서블릿은 JSP 파일의 내용(HTML, JSP 코드 등)을 클라이언트에 응답으로 전달합니다.
		// 이 HTML 내용이 AJAX 요청의 응답으로 사용됩니다.
		RequestDispatcher dispatcher = request.getRequestDispatcher("request_list_fragment.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	public int getNewRequestCount(String meNo) throws ServletException, IOException {

		SqlSession sql = sqlSessionFactory.openSession();
		RequestMapper requestMapper = sql.getMapper(RequestMapper.class);
		int cnt = requestMapper.getNewRequestCount(meNo);
		sql.close();
		
		return cnt;
	}
}