package com.susuma.member.model;

import java.util.ArrayList;
import java.util.Map;

public interface MemberMapper {

	public ArrayList<MemberDTO> selectMembers(Map<String, Object> params); // [1] 회원 목록

	public int countMembers(Map<String, Object> params); // [1-2] 회원 목록 수(페이징 처리)

	public MemberDTO selectMember(Map<String, Object> params); // [2] 회원(me_no / email, pw)

	public int insertMember(MemberDTO dto); // [3] 회원 등록

	public int updateMember(MemberDTO dto); // [4] 회원 수정

	public void deleteMember(String meNo); // [5] 회원 삭제

	public MemberDTO selectMemberByMeNo(Map<String, Object> params);

	public String getPassword(String meNo);

	public MemberDTO selectMemberById(String meNo);

	public MemberDTO getMemberByNo(String meNo);
}
