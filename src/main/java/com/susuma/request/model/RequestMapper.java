package com.susuma.request.model;

import java.util.ArrayList;

import com.susuma.member.model.MemberDTO;

public interface RequestMapper {

	public ArrayList<RequestDTO> getList();
	
	ArrayList<RequestDTO> getListByMember(String clientNo); // 추가된 메서드

	public int insertRequest(RequestDTO dto);

	public RequestDTO getRequestByNo(String reqNo);
	
	RequestDTO selectRequest(String reqNo);
	
	 boolean updatePaymentStatus(RequestDTO dto);
}
