package com.susuma.category.service;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface CategoryMasterListService {

	void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
