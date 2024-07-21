package com.susuma.member.model;

import java.util.ArrayList;
import java.util.Map;

public interface MemberMapper {

	public ArrayList<MemberDTO> getList(Map<String, Object> params); // 관리자 - 회원목록

	public MemberDTO getView(String meNo); // 관리자 - 회원상세

	public int regist(MemberDTO dto); // 사용자 - 회원가입
}
