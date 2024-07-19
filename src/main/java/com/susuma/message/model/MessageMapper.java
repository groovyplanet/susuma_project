package com.susuma.message.model;

import java.util.ArrayList;

import com.susuma.member.model.MemberDTO;

public interface MessageMapper {
	public ArrayList<MessageDTO> getMessages();
	public int sendMessage(MessageDTO dto);

}
