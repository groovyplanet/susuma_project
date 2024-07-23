package com.susuma.member.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.category.model.CategoryDTO;
import com.susuma.category.model.CategoryMapper;
import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;

import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MemberServiceImpl implements MemberService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 관리자 - 회원 목록
		/* [1] 매개변수 */
		String type = request.getParameter("type");
		type = (type == null || type.isEmpty()) ? "user" : type; // 기본 : 회원 구분 user
		String joinApproval = request.getParameter("join_approval");
		joinApproval = (joinApproval == null || joinApproval.isEmpty()) ? "all" : joinApproval; // 기본 : 가입 승인 전체(승인/미승인)
		String sortField = request.getParameter("sortField");
		sortField = (sortField == null || sortField.isEmpty()) ? "insert_time" : sortField;
		String sortOrder = request.getParameter("sortOrder");
		sortOrder = (sortOrder == null || sortOrder.isEmpty()) ? "DESC" : sortOrder;
		String rootNo = request.getParameter("rootNo");
		rootNo = (rootNo == null || rootNo.isEmpty()) ? "all" : rootNo;
		String caNo = request.getParameter("caNo");
		caNo = (caNo == null || caNo.isEmpty()) ? "all" : caNo;

		Map<String, Object> params = new HashMap<>();
		params.put("type", type);
		params.put("joinApproval", joinApproval);
		params.put("sortField", sortField);
		params.put("sortOrder", sortOrder);
		params.put("rootNo", rootNo);
		// params.put("caNo", caNo);

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		MemberMapper Member = sql.getMapper(MemberMapper.class); // MemberMapper 인터페이스를 사용하여 쿼리 실행을 위한 매퍼 객체 생성
		ArrayList<MemberDTO> list = Member.selectMembers(params); // MemberMapper 메서드 호출
		if (type.equals("master")) {
			// 수리분야 리스트 출력
			CategoryMapper Category = sql.getMapper(CategoryMapper.class);
			ArrayList<CategoryDTO> CategoryMainList = Category.selectCategorys(null); // 메인 카테고리 출력 시 파라미터는 null
			request.setAttribute("CategoryMainList", CategoryMainList);
			if (!rootNo.equals("all")) {
				// 수리분야 리스트(하위) 출력
				ArrayList<CategoryDTO> CategorySubList = Category.selectCategorys(rootNo);
				request.setAttribute("CategorySubList", CategorySubList);
			}
		}
		sql.close();

		/* [3] 화면이동 */
		request.setAttribute("list", list);
		for (Map.Entry<String, Object> entry : params.entrySet()) {
			request.setAttribute(entry.getKey(), entry.getValue());
		}
		request.getRequestDispatcher("member_list.jsp").forward(request, response); // 요청 포워드
	}

	@Override
	public void getMasterList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 사용자 - 수리기사 목록(수리 예약 메뉴)
		/* [1] 매개변수 */
		Map<String, Object> params = new HashMap<>();
		params.put("type", "master");
		params.put("joinApproval", "Y");
		params.put("sortField", "insert_time");
		params.put("sortOrder", "DESC");
		// 카테고리 매개변수로 받아서 검색하는 기능 구현 필요

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		MemberMapper Member = sql.getMapper(MemberMapper.class);
		ArrayList<MemberDTO> memberList = Member.selectMembers(params);
		CategoryMapper Category = sql.getMapper(CategoryMapper.class);
		ArrayList<CategoryDTO> CategoryMainList = Category.selectCategorys(null); // 메인 카테고리 출력 시 파라미터는 null
		
		sql.close(); 

		/* [3] 화면이동 */
		
		request.setAttribute("memberList", memberList);
		request.setAttribute("CategoryMainList", CategoryMainList);
		request.getRequestDispatcher("master_list.jsp").forward(request, response);

	}

	@Override
	public void getView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 회원 상세 정보 처리 로직
		/* [1] 매개변수 */
		String meNo = request.getParameter("meNo");
		Map<String, Object> params = new HashMap<>();
		params.put("meNo", meNo);

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		MemberMapper Member = sql.getMapper(MemberMapper.class);
		MemberDTO dto = Member.selectMember(params);
		sql.close();

		/* [3] 화면이동 */
		request.setAttribute("type", dto.getType());
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("member_view.jsp").forward(request, response);
	}

	@Override
	public void regist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 회원 가입 처리 로직
		/* [1] 매개변수 */
		String type = request.getParameter("type");
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String phoneNum = request.getParameter("phone_num");
		String address = request.getParameter("address");
		String addressDetail = request.getParameter("address_detail");
		Double latitude = Double.parseDouble(request.getParameter("latitude"));
		Double longitude = Double.parseDouble(request.getParameter("longitude"));
		String emailNotification = request.getParameter("email_notification");
		emailNotification = emailNotification == null ? "N" : "Y";

		MemberDTO dto;
		if (type.equals("user")) {
			dto = new MemberDTO(type, email, pw, name, phoneNum, address, addressDetail, latitude, longitude, emailNotification);
		} else { // master
			String businessNumber = request.getParameter("business_number");
			String shortDescription = request.getParameter("short_description");
			int maxDistance = Integer.parseInt(request.getParameter("max_distance"));
			String workHours = request.getParameter("work_hours");
			// 수리분야 추가 필요(category)
			dto = new MemberDTO(type, email, pw, name, phoneNum, address, addressDetail, latitude, longitude, emailNotification, businessNumber, shortDescription, maxDistance, workHours);
		}

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession(true);
		MemberMapper Member = sql.getMapper(MemberMapper.class);
		int result = Member.insertMember(dto);
		sql.close();

		/* [3] 화면이동 */
		if (result == 1) { // 등록 성공
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원가입이 완료 되었습니다. 로그인 후 이용해주세요.');");
			out.println("location.href = '../';");
			out.println("</script>");
		}
	}

	@Override
	public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 로그인 처리 로직
		/* [1] 매개변수 */
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		String saveEmail = request.getParameter("saveEmail"); // 이메일 저장 체크박스
		Map<String, Object> params = new HashMap<>();
		params.put("email", email);
		params.put("pw", pw);

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		MemberMapper Member = sql.getMapper(MemberMapper.class);
		MemberDTO dto = Member.selectMember(params);
		sql.close();

		/* [3] 화면이동 */
		if (dto == null) { // 로그인 실패(email과 pw 일치하는 회원 없음)

			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			String referrer = request.getHeader("Referer");

			if (referrer.indexOf("loginModal=Y") == -1) {
				referrer += "?loginModal=Y";
			}

			out.println("<script>");
			out.println("alert('이메일 또는 비밀번호를 확인하세요.');");
			out.println("window.location.href = '" + referrer + "';"); // 이전 페이지 보여주기 + 모달 창 다시 띄우기
			out.println("</script>");

		} else { // 로그인 성공

			/* 세션(로그인 정보) */
			HttpSession session = request.getSession();
			session.setAttribute("meNo", dto.getMeNo() + ""); // 처리하기 쉽게 String형으로 저장
			session.setAttribute("email", dto.getEmail());
			session.setAttribute("name", dto.getName());
			session.setAttribute("type", dto.getType());
			session.setMaxInactiveInterval(36000); // 10시간

			/* 쿠키(이메일 저장 체크박스) */
			if (saveEmail != null) { // 이메일 저장 체크했을 경우 쿠키 저장

				Cookie saveEmailCookie = new Cookie("saveEmail", email);
				saveEmailCookie.setMaxAge(36000); // 10시간
				saveEmailCookie.setPath(request.getContextPath()); // 쿠키 경로 설정
				response.addCookie(saveEmailCookie);

			} else { // 이메일 저장 체크 해제 시 쿠키 삭제

				Cookie saveEmailCookie = new Cookie("saveEmail", ""); // 빈 값으로 설정
				saveEmailCookie.setMaxAge(0); // 즉시 만료
				saveEmailCookie.setPath(request.getContextPath()); // 쿠키 경로 설정
				response.addCookie(saveEmailCookie);

			}

			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('정상적으로 로그인되었습니다.');");
			// out.println("location.href = document.referrer;"); // 이전 페이지 보여주기
			out.println("var url = new URL(document.referrer);");
			out.println("url.searchParams.delete('loginModal');"); // 'loginModal' 파라미터 제거
			out.println("location.href = url.toString();"); // 수정된 URL로 리디렉션
			out.println("</script>");

		}

	}

	@Override
	public void profileEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 회원 정보 수정 처리 로직
		/* [1] 매개변수 */
		HttpSession session = request.getSession();
		String meNo = (String) session.getAttribute("meNo"); // 세션 값 가져오기
		Map<String, Object> params = new HashMap<>();
		params.put("meNo", meNo);

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		MemberMapper Member = sql.getMapper(MemberMapper.class);
		MemberDTO dto = Member.selectMember(params);
		// System.out.println(dto.getAddress());
		sql.close();

		/* [3] 화면이동 */
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("profile_edit.jsp").forward(request, response);

	}

}