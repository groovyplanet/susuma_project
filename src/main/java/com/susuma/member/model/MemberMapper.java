package com.susuma.member.model;

import java.util.ArrayList;
import java.util.Map;

public interface MemberMapper {
	public ArrayList<MemberDTO> selectMembers(Map<String, Object> params); // [1] 회원 목록

	public MemberDTO selectMember(Map<String, Object> params); // [2] 회원(me_no / email, pw)

	public int insertMember(MemberDTO dto); // [3] 회원 추가

}
