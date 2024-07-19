package com.susuma.controller;

import com.susuma.message.service.MessageService;
import com.susuma.message.service.MessageServiceImpl;
import com.susuma.message.model.MessageDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/Susuma/master/messages")
public class MessageController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MessageService messageService = new MessageServiceImpl();
    private ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<MessageDTO> messages = messageService.getMessages();
        String json = mapper.writeValueAsString(messages);
        response.setContentType("application/json");
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int masterNo = Integer.parseInt(request.getParameter("masterNo"));
        int clientNo = Integer.parseInt(request.getParameter("clientNo"));
        String messageText = request.getParameter("messageText");
        messageService.addMessage(masterNo, clientNo, messageText);
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
