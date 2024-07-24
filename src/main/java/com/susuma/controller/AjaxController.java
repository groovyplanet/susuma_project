package com.susuma.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.google.gson.Gson;
import com.susuma.category.model.CategoryDTO;
import com.susuma.category.model.CategoryMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("*.ajax")
public class AjaxController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		String uri = request.getRequestURI(); // ip, port번호 제외된 주소
		String path = request.getContextPath(); // 프로젝트 식별 이름
		String command = uri.substring(path.length());
		System.out.println("command : " + command);

		if (command.equals("/member/getCategory.ajax") || command.equals("/admin/member/getCategory.ajax")) { // 상위 카테고리로 하위 카테고리 리스트 가져오기

			String rootNo = request.getParameter("rootNo");

			SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
			SqlSession sql = sqlSessionFactory.openSession();
			CategoryMapper Category = sql.getMapper(CategoryMapper.class);
			ArrayList<CategoryDTO> CategorySubList = Category.selectCategorys(rootNo);
			request.setAttribute("CategorySubList", CategorySubList);

			Gson gson = new Gson();
			String json = gson.toJson(CategorySubList);

			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();

		}

	}

}
