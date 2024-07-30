package com.susuma.message.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.susuma.member.model.MemberDTO;
import com.susuma.message.model.MessageDTO;

public interface MessageService {

	int getUnreadMessageCount(String meNo) throws ServletException, IOException;

	void getChatRooms(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void getMessages(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void getMessagesAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void sendMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

}
