package com.susuma.request.service;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface RequestService {

	void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void getMemberRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	
	void updatePaymentStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
