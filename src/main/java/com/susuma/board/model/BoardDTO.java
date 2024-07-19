package com.susuma.board.model;

import java.sql.Timestamp;

public class BoardDTO {
	
	private String title;
	
	public BoardDTO() {
	}

	public BoardDTO(int bno, String writer, String title, String content, Timestamp regdate, int hit) {
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
