package com.susuma.member.model;

import java.util.ArrayList;

public interface MemberMapper {
    void addMember(MemberDTO member);
    MemberDTO getView(String meNo);
    ArrayList<MemberDTO> getList(String type);
}
