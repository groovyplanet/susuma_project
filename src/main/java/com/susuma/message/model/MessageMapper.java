package com.susuma.message.model;

import java.util.ArrayList;
import java.util.Map;

public interface MessageMapper {

	// gnb에 표시할 안 읽은 메세지 개수
	public int getNotReadMessageCnt(String meNo);

	// 대화방 가져오기(select)
	public ArrayList<MessageDTO> getChatRooms(String meNo);

	// 메세지 가져오기(select)
	public ArrayList<MessageDTO> getMessages(Map<String, Object> params);

	// 메세지 읽음 여부 업데이트(update)
	public int updateMessages(Map<String, Object> params);

	// 메세지 전송(insert)
	public int sendMessage(MessageDTO dto);

}
