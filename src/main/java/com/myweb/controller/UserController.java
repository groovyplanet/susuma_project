package com.myweb.controller;

import java.io.IOException;

import com.myweb.user.service.UserService;
import com.myweb.user.service.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("*.user") //확장자패턴
public class UserController extends HttpServlet {

	public UserController() {
	}
	
	//doAction으로 연결
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//3. 요청을 분기
		request.setCharacterEncoding("utf-8");
		
		String uri = request.getRequestURI(); //ip, port번호 제외된 주소
		String path = request.getContextPath(); //프로젝트 식별 이름
		String command = uri.substring( path.length() );
		
		System.out.println(command);
		
		//공통으로 사용할 유저 서비스 객체
		UserService service;
		
		//기본 이동방식 forward
		//MVC2 방식에서 리다이렉트는 다시 컨트롤러를 태울때 사용합니다.
		
		if(command.equals("/user/join.user")) { //회원가입 화면

			request.getRequestDispatcher("join.jsp").forward(request, response);
		
		} else if(command.equals("/user/joinForm.user")) { //회원가입 기능
			
			//값......
			service = new UserServiceImpl();
			service.join(request, response);
			
		} else if(command.equals("/user/login.user")) { //로그인 화면
			
			request.getRequestDispatcher("login.jsp").forward(request, response);
		
		} else if(command.equals("/user/loginForm.user")) { //로그인 요청
			
			service = new UserServiceImpl();
			service.login(request, response);
			
		} else if(command.equals("/user/mypage.user")) { //회원페이지
			
			request.getRequestDispatcher("mypage.jsp").forward(request, response);
		
		} else if(command.equals("/user/modify.user")) { //회원정보 수정페이지
			
			service = new UserServiceImpl();
			service.getInfo(request, response);
			
		} else if(command.equals("/user/logout.user")) { //로그아웃
			
			HttpSession session = request.getSession();
			session.invalidate();
			
			response.sendRedirect( request.getContextPath()  + "/index.jsp" ); //메인화면으로
			
		} else if(command.equals("/user/update.user")) { //회원정보 수정
		
			service = new UserServiceImpl();
			service.update(request, response);
		
		} else if(command.equals("/user/delete.user")) { //삭제화면
			
			//mvc2는 기본 이동이 forward
			request.getRequestDispatcher("delete.jsp").forward(request, response);
			
		} else if(command.equals("/user/deleteForm.user")) { //탈퇴요청
			
			service = new UserServiceImpl();
			service.delete(request, response);
		}
	}
	
}
