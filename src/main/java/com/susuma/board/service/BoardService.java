package com.susuma.board.service;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface BoardService {
	void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminGetView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminModify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void askUpsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void askGetView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void askModify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	
	void askDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void noticeGetView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	
	void adminReplyWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	
	void adminReplyRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

}
