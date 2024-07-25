package com.susuma.controller;

import java.io.IOException;

import com.susuma.board.service.BoardService;
import com.susuma.request.service.RequestService;
import com.susuma.request.service.RequestServiceImpl;

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

		String uri = request.getRequestURI(); // ip, port번호 제외된 주소
		String path = request.getContextPath(); // 프로젝트 식별 이름
		String command = uri.substring(path.length());

		RequestService service;

		System.out.println(command);
		if (command.equals("/member/list.request")) {

			service = new RequestServiceImpl();
			service.getList(request, response);

		}else if(command.equals("/member/requestView.request")) {
			//멤버 예약 내역 보기
			service = new RequestServiceImpl();
			service.getMemberRequest(request,response);
			
		}

	}

}
