package com.susuma.board.model;

import java.util.ArrayList;
import java.util.Map;

public interface BoardMapper {

	public ArrayList<BoardDTO> getList(Map<String, Object> params); // 관리자 - 게시물 목록

	public BoardDTO getView(String boNo); // 관리자 - 게시물 상세

	public int regist(BoardDTO dto); // 관리자 - 게시물 등록
}
