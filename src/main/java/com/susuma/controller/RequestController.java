package com.susuma.controller;

import java.io.IOException;

import com.susuma.request.service.RequestService;
import com.susuma.request.service.RequestServiceImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("*.request")
public class RequestController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public RequestController() {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		String uri = request.getRequestURI(); // uri : '/Susuma/member/join.member'
		String path = request.getContextPath(); // path : '/Susuma'
		String command = uri.substring(path.length()); // command : '/member/join.member'
		System.out.println("command : " + command);

		RequestService service = new RequestServiceImpl();

		switch (command) {

		case "/admin/request/list.request":
			service.adminList(request, response); // 관리자 - 목록
			break;

		case "/admin/request/view.request":
			service.adminView(request, response); // 관리자 - 상세
			break;

		case "/admin/request/edit.request":
			service.adminEdit(request, response); // 관리자 - 수정 화면
			break;

		case "/admin/request/editForm.request":
			service.adminUpsert(request, response); // 관리자 - 수정
			break;

		case "/admin/request/delete.request":
			service.adminDelete(request, response); // 관리자 - 삭제
			break;

		case "/member/list.request":
			service.getRequestList(request, response);
			break;

		case "/member/getRequestsAjax.request":
			service.getRequestListAjax(request, response);
			break;

		case "/member/view.request":
			service.getRequest(request, response);
			break;

		case "/member/edit.request":
			// service.edit(request, response);
			break;

		case "/member/editForm.request":
			service.upsertRequest(request, response);
			break;

		case "/member/payAjax.request":
			service.updateStatusAjax(request, response); // 결제 (의뢰인)
			break;

		case "/member/approveAjax.request":
			service.updateStatusAjax(request, response); // 예약 승인 (수리기사)
			break;

		case "/member/payRequestAjax.request":
			service.updateStatusAjax(request, response); // 결제 요청 (수리기사)
			break;

		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			break;
		}
	}
}
