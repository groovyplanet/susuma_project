package com.susuma.member.model;

import java.util.ArrayList;

public interface MemberMapper {
	public ArrayList<MemberDTO> getList(String type);

	public MemberDTO getView(String meNo);
}
