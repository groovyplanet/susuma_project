package com.susuma.member.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.catalina.realm.AuthenticatedUserRealm;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.board.model.BoardDTO;
import com.susuma.board.model.BoardMapper;
import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class MemberServiceImpl implements MemberService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원 목록 처리 로직
		/* [1] 매개변수 */
		String type = request.getParameter("type");
		type = (type == null || type.isEmpty()) ? "user" : type; // 기본 : 회원 구분 user
		String joinApproval = request.getParameter("join_approval");
		joinApproval = (joinApproval == null || joinApproval.isEmpty()) ? "all" : joinApproval; // 기본 : 가입 승인 전체(승인/미승인)

		Map<String, Object> params = new HashMap<>();
		params.put("type", type);
		params.put("joinApproval", joinApproval);

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		MemberMapper Member = sql.getMapper(MemberMapper.class); // MemberMapper 인터페이스를 사용하여 쿼리 실행을 위한 매퍼 객체 생성
		ArrayList<MemberDTO> list = Member.getList(params); // MemberMapper 메서드 호출
		sql.close();

		/* [3] Request */
		request.setAttribute("list", list);
		for (Map.Entry<String, Object> entry : params.entrySet()) {
			request.setAttribute(entry.getKey(), entry.getValue());
		}
		request.getRequestDispatcher("member_list.jsp").forward(request, response); // 요청 포워드
	}

	@Override
	public void getView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // 회원 상세 정보 처리 로직
		/* [1] 매개변수 */
		String meNo = request.getParameter("meNo");

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		MemberMapper Member = sql.getMapper(MemberMapper.class);
		MemberDTO dto = Member.getView(meNo);
		sql.close();

		/* [3] Request */
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
		int result = Member.regist(dto);
		sql.close();

		/* [3] location.href */
		if (result == 1) { // 등록 성공
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원가입이 완료 되었습니다. 로그인 후 이용해주세요.');");
			out.println("location.href='../';");
			out.println("</script>");
		}
	}
	@Override
	public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String email = request.getParameter("email");
	    String password = request.getParameter("pw");

	    try (SqlSession session = sqlSessionFactory.openSession()) {
	        MemberMapper mapper = session.getMapper(MemberMapper.class);
	        MemberDTO member = mapper.getMemberByEmail(email);

	        if (member != null && password.equals(member.getPw())) { // 암호화된 비밀번호 비교 필요 시 수정
	            HttpSession httpSession = request.getSession();
	            httpSession.setAttribute("loggedInUser", member);
	            response.sendRedirect(request.getContextPath() + "/index.jsp");
	        } else {
	            response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect(request.getContextPath() + "/login.jsp?error=exception");
	    }
	}

	    @Override
	    public MemberDTO getMemberById(int me_no) {
	        try (SqlSession session = sqlSessionFactory.openSession()) {
	            MemberMapper mapper = session.getMapper(MemberMapper.class);
	            return mapper.selectMemberById(me_no);
	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
	    }
	}