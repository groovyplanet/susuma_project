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

		String uri = request.getRequestURI(); // ip, port번호 제외된 주소
		String path = request.getContextPath(); // 프로젝트 식별 이름
		String command = uri.substring(path.length());

		ReviewService service;

		System.out.println(command);
		if (command.equals("/member/list.review")) {

			service = new ReviewServiceImpl();
			service.getList(request, response);

		}

	}

}
