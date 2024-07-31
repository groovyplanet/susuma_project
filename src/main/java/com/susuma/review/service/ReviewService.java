package com.susuma.review.service;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface ReviewService {

	/* 관리자 */
	void adminList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void adminUpsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException; // view, edit은 request에서 처리

	void adminDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	/* 사용자 */
	void getReviewList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void getReviewListAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

	void upsertReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

}
