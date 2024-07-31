package com.susuma.controller;

import java.io.IOException;

import com.susuma.review.service.ReviewService;
import com.susuma.review.service.ReviewServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("*.review")
public class ReviewController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public ReviewController() {
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

		ReviewService service = new ReviewServiceImpl();

		switch (command) {

		case "/admin/member/list.review":

			service.adminList(request, response); // 관리자 - 목록
			break;

		case "/admin/member/editForm.review":
			service.adminUpsert(request, response); // 관리자 - 수정
			break;

		case "/admin/member/delete.review":
			service.adminDelete(request, response); // 관리자 - 삭제
			break;

		case "/member/list.review":
			service.getReviewList(request, response);
			break;

		case "/member/getReviewsAjax.review":
			service.getReviewListAjax(request, response);
			break;

		case "/member/edit.review":
			// service.edit(request, response);
			break;

		case "/member/editForm.review":
			service.upsertReview(request, response);
			break;

		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			break;
		}

	}

}
