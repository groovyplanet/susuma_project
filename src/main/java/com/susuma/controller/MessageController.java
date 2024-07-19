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

@WebServlet("/master/messages") // 'Susuma/' 삭제
public class MessageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MessageService messageService = new MessageServiceImpl();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		int userNo = Integer.parseInt(request.getParameter("userNo"));
//        int getMeNo = Integer.parseInt(request.getParameter("getMeNo"));
//        List<MessageDTO> messages = messageDAO.getMessages(userNo, getMeNo);
		List<MessageDTO> messages = messageService.getMessages(request, response);
		String json = new Gson().toJson(messages);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(json);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		messageService.sendMessage(request, response);
	}
}
