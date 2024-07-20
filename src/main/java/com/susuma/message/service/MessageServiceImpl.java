package com.susuma.message.service;

import com.google.gson.Gson;
import com.susuma.message.model.MessageDTO;
import com.susuma.message.model.MessageMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.io.BufferedReader;
import java.io.IOException;

public class MessageServiceImpl implements MessageService {

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

	@Override
	public List<MessageDTO> getMessages(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SqlSession sql = sqlSessionFactory.openSession();
		MessageMapper Message = sql.getMapper(MessageMapper.class); 
		ArrayList<MessageDTO> list = Message.getMessages();
		sql.close();
		return list;
	}

	@Override
	public void sendMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		BufferedReader reader = request.getReader();
		Gson gson = new Gson();
		MessageDTO dto = gson.fromJson(reader, MessageDTO.class);

		SqlSession sql = sqlSessionFactory.openSession(true);
		MessageMapper Message = sql.getMapper(MessageMapper.class);
		Message.sendMessage(dto);
		sql.close();

	}
}
