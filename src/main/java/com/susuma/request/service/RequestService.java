package com.susuma.request.service;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface RequestService {

	/* 관리자 */
	void adminList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminUpsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	/* 사용자 */
	int getNewRequestCount(String meNo) throws ServletException, IOException;
	
	void getRequestList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void getRequestListAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void getRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void upsertRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void updateStatusAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
