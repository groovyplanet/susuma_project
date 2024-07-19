package com.susuma.board.model;

import java.util.ArrayList;

public interface BoardMapper {
	public ArrayList<BoardDTO> getList(String type);

	public BoardDTO getView(String boNo);
}
