package com.susuma.member.model;

import java.sql.Timestamp;

public class MemberDTO {
	
	private String title;
	
	public MemberDTO() {
	}

	public MemberDTO(int bno, String writer, String title, String content, Timestamp regdate, int hit) {
		super();
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
}
