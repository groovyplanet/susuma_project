package com.myweb.user.service;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface UserService {
	
	void join(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	void getInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	
}
