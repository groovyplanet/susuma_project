package com.susuma.message.service;

import com.google.gson.Gson;
import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;
import com.susuma.message.model.MessageDTO;
import com.susuma.message.model.MessageMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.io.BufferedReader;
import java.io.IOException;

public class MessageServiceImpl implements MessageService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

	// 읽지 않은 메시지 개수
	@Override
	public int getUnreadMessageCount(String meNo) throws ServletException, IOException {

		SqlSession sql = sqlSessionFactory.openSession();
		MessageMapper messageMapper = sql.getMapper(MessageMapper.class);
		int cnt = messageMapper.getNotReadMessageCnt(meNo);
		sql.close();
		
		return cnt;
	}

	// 채팅 목록
	@Override
	public void getChatRooms(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		SqlSession sql = sqlSessionFactory.openSession();
		MessageMapper messageMapper = sql.getMapper(MessageMapper.class);

		HttpSession session = request.getSession();
		String meNo = (String) session.getAttribute("meNo");

		// 모든 대화 목록 가져오기
		ArrayList<MessageDTO> list = messageMapper.getChatRooms(meNo);
		sql.close();

		request.setAttribute("list", list);
		request.getRequestDispatcher("message_list.jsp").forward(request, response);
	}

	// 채팅 메세지
	@Override
	public void getMessages(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		SqlSession sql = sqlSessionFactory.openSession(true);
		MessageMapper messageMapper = sql.getMapper(MessageMapper.class);

		HttpSession session = request.getSession();
		String meNo = (String) session.getAttribute("meNo");
		String user = request.getParameter("user");
		Map<String, Object> params = new HashMap<>();
		params.put("sendMeNo", user);
		params.put("getMeNo", meNo);

		// 상대방 정보 가져오기
		Map<String, Object> params2 = new HashMap<>();
		params2.put("meNo", user);
		MemberMapper Member = sql.getMapper(MemberMapper.class);
		MemberDTO userDTO = Member.selectMember(params2);
		
		// 상대방과 내가 주고받은 모든 메세지 가져오기
		ArrayList<MessageDTO> list = messageMapper.getMessages(params);

		// 상대방과 내가 주고받은 메세지 중 내가 받은 메세지 모두 읽음 처리
		int result = messageMapper.updateMessages(params);
		sql.close();

		request.setAttribute("userDTO", userDTO);
		request.setAttribute("list", list);
		request.setAttribute("getMeNo", user); // 메시지 전송할 때 상대방 번호
		request.getRequestDispatcher("message.jsp").forward(request, response);
	}

	// ajax 폴링
	@Override
	public void getMessagesAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		SqlSession sql = sqlSessionFactory.openSession(true);
		MessageMapper messageMapper = sql.getMapper(MessageMapper.class);

		HttpSession session = request.getSession();
		String meNo = (String) session.getAttribute("meNo");
		String user = request.getParameter("user");
		System.out.println(" user : "+user);
		Map<String, Object> params = new HashMap<>();
		params.put("sendMeNo", user);
		params.put("getMeNo", meNo);
		params.put("read", 'N'); // 추가로 가져올 경우 읽지않은 메시지만

		// 상대방 정보 가져오기
		Map<String, Object> params2 = new HashMap<>();
		params2.put("meNo", user);
		
		// 상대방과 내가 주고받은 모든 메세지 가져오기
		ArrayList<MessageDTO> list = messageMapper.getMessages(params);
		// 모두 읽음 처리
		int result = messageMapper.updateMessages(params);
		sql.close();

		request.setAttribute("list", list);
		request.setAttribute("getMeNo", user); // 메시지 전송할 때 상대방 번호

		RequestDispatcher dispatcher = request.getRequestDispatcher("message_fragment.jsp");
		dispatcher.forward(request, response);
	}

	// 메시지 보내기
	@Override
	public void sendMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		BufferedReader reader = request.getReader();
		Gson gson = new Gson();
		MessageDTO dto = gson.fromJson(reader, MessageDTO.class); // getMeNo, message

		HttpSession session = request.getSession();
		String meNo = (String) session.getAttribute("meNo");
		dto.setSendMeNo(meNo);

		SqlSession sql = sqlSessionFactory.openSession(true);
		MessageMapper messageMapper = sql.getMapper(MessageMapper.class);
		messageMapper.sendMessage(dto);
		sql.close();

	}

}
