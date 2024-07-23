package com.susuma.board.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface BoardMapper {

	public ArrayList<BoardDTO> selectBoards(Map<String, Object> params); // [1] 게시물 목록

	public int countBoards(Map<String, Object> params); // [1-2] 게시물 목록 수(페이징 처리)

	public BoardDTO selectBoard(String boNo); // [2] 게시물

	public int insertBoard(BoardDTO dto); // [3] 게시물 등록
	
	public int updateBoard(BoardDTO dto); // [4] 게시물 수정
	
	public void deleteBoard(String boNo); // [5] 게시물 삭제
}
