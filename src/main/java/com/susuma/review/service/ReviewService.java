package com.susuma.review.service;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface ReviewService {
	void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	void getListMaster(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	void submitReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
