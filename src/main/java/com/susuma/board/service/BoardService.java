package com.susuma.board.service;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface BoardService {
	void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	void getView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	void regist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
} 


