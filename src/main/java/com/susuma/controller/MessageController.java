package com.susuma.controller;

import com.susuma.message.model.MessageDTO;
import com.susuma.message.service.MessageService;
import com.susuma.message.service.MessageServiceImpl;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("*.message")
public class MessageController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public MessageController() {
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

		MessageService messageService = new MessageServiceImpl();

		switch (command) {

		case "/member/list.message":
			messageService.getChatRooms(request, response);
			break;
			
		case "/member/form.message":
			messageService.getMessages(request, response);
			break;

		case "/member/sendAjax.message":
			messageService.sendMessage(request, response);
			break;
			
		case "/member/getAjax.message":
			messageService.getMessagesAjax(request, response);
			break;

		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			break;
		}
	}

}