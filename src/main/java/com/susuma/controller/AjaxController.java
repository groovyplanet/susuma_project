package com.susuma.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.google.gson.Gson;
import com.susuma.alert.model.AlertDTO;
import com.susuma.alert.model.AlertMapper;
import com.susuma.category.model.CategoryDTO;
import com.susuma.category.model.CategoryMapper;
import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;
import com.susuma.request.model.RequestDTO;
import com.susuma.request.model.RequestMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("*.ajax")
@MultipartConfig
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
			SqlSession sql = sqlSessionFactory.openSession(true);
			CategoryMapper Category = sql.getMapper(CategoryMapper.class);
			ArrayList<CategoryDTO> CategorySubList = Category.selectCategorys(rootNo);

			Gson gson = new Gson();
			String json = gson.toJson(CategorySubList);
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();

		} else if (command.equals("/member/checkEmailDuplication.ajax")) { // 회원가입 시 이메일 중복 확인

			String email = request.getParameter("email");
			Map<String, Object> params = new HashMap<>();
			params.put("email", email);

			SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
			SqlSession sql = sqlSessionFactory.openSession(true);
			MemberMapper Member = sql.getMapper(MemberMapper.class);
			MemberDTO dto = Member.selectMember(params);
			sql.close();

			boolean isAvailable = dto == null; // 이메일이 일치하는 회원정보가 없으면 회원가입 가능(true)
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("{\"available\":" + isAvailable + "}"); // JSON 형태로 응답
			out.flush();

		} else if (command.equals("/member/insertRequest.ajax")) { // 수리 예약

			int reqNo = request.getParameter("reqNo") == null ? 0 : Integer.parseInt(request.getParameter("reqNo"));
			String masterNo = request.getParameter("masterNo");
			HttpSession session = request.getSession();
			String clientNo = (String) session.getAttribute("meNo");
			String clientName = (String) session.getAttribute("name");
			String content = request.getParameter("content");
			String requestDate = request.getParameter("requestDate");
			String requestTime = request.getParameter("requestTime");
			String address = request.getParameter("address");
			String addressDetail = request.getParameter("address_detail");
			Double latitude = (request.getParameter("latitude")) == null ? 0.0 : Double.parseDouble(request.getParameter("latitude"));
			Double longitude = (request.getParameter("longitude")) == null ? 0.0 : Double.parseDouble(request.getParameter("longitude"));
			String phoneNum = request.getParameter("phoneNum");

			RequestDTO requestDTO = new RequestDTO(reqNo, masterNo, clientNo, content, requestDate, requestTime, address, addressDetail, latitude, longitude, phoneNum, null, null);

			SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
			SqlSession sql = sqlSessionFactory.openSession(true);
			RequestMapper requestMapper = sql.getMapper(RequestMapper.class);
			// INSERT REQUEST
			int result = requestMapper.insertRequest(requestDTO);
			System.out.println("dto.getReqNo() : " + requestDTO.getReqNo());
			System.out.println("masterNo : " + masterNo);

			// INSERT ALERT
			AlertMapper alertMapper = sql.getMapper(AlertMapper.class);
			AlertDTO alertDTO = new AlertDTO(null, masterNo, (requestDTO.getReqNo() + ""), clientName + "님이 수리 예약을 신청했습니다.", null);
			int result2 = alertMapper.insertAlert(alertDTO);
			sql.close();

			boolean isAvailable = result == 1; // 이메일이 일치하는 회원정보가 없으면 회원가입 가능(true)
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("{\"available\":" + isAvailable + "}"); // JSON 형태로 응답
			out.flush();

		} else if (command.endsWith("deleteAlert.ajax")) {
			//HttpSession session = request.getSession();
			//String meNo = (String) session.getAttribute("meNo");
			//System.out.println(meNo);
			String alNo = request.getParameter("alNo");
			SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
			SqlSession sql = sqlSessionFactory.openSession(true);
			// DELETE ALERT
			AlertMapper alertMapper = sql.getMapper(AlertMapper.class);
			int result = alertMapper.deleteAlert(alNo);
			System.out.println(result);
			sql.close();

		}

	}

}
