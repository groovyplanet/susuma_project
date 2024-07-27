package com.susuma.request.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;
import com.susuma.request.model.RequestDTO;
import com.susuma.request.model.RequestDTO;
import com.susuma.request.model.RequestMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RequestServiceImpl implements RequestService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
	public final int recordsPerPage = 10; // 한 페이지당 보여줄 레코드 수

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

		String reqNo = request.getParameter("reqNo");
		String masterNo = request.getParameter("masterNo");
		String clientNo = request.getParameter("clientNo");
		String content = request.getParameter("content");
		String requestDate = request.getParameter("requestDate");
		String requestTime = request.getParameter("requestTime");
		String payStatus = request.getParameter("payStatus");
		String cancelReason = request.getParameter("cancelReason");
		return new RequestDTO(reqNo, masterNo, clientNo, content, requestDate, requestTime, payStatus, cancelReason);
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
		sql.close();

		/* [3] 요청에 데이터 설정 */
		request.setAttribute("requestDTO", requestDTO);
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
		params.put("sortField", sortField);
		params.put("sortOrder", sortOrder);
		params.put("startRow", startRow); // rownum 시작값
		params.put("endRow", endRow); // rownum 끝값

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		RequestMapper requestMapper = sql.getMapper(RequestMapper.class);
		ArrayList<RequestDTO> requestList = requestMapper.selectRequests(params);

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
		sql.close();

		/* [3] 화면이동 */
		request.setAttribute("list", requestList);
		for (Map.Entry<String, Object> entry : params.entrySet()) {
			request.setAttribute(entry.getKey(), entry.getValue());
		}
		request.getRequestDispatcher("request_list.jsp").forward(request, response); // 요청 포워드
	}

	@Override
	public void adminList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		getList(request, response); // 관리자, 사용자 공통

	}

	@Override
	public void adminView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 리뷰 정보 가져오기
		getRequestDTO(request, response);

		// 포워딩
		request.getRequestDispatcher("request_view.jsp").forward(request, response);
	}

	@Override
	public void adminEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 리뷰 정보 가져오기
		getRequestDTO(request, response);

		// 포워딩
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
	}

	@Override
	public void getRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		// 리뷰 정보 가져오기
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

	public void updatePaymentStatusAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDTO requestDTO = createRequestDTO(request, response); // 별도 함수로 처리
		boolean isUpdate = true;
		int result = requestUpsert(requestDTO, isUpdate);

		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		try (PrintWriter out = response.getWriter()) {
			if (result == 1) {
				out.write("Success");
			} else {
				out.write("Failure");
			}
		}
	}
}