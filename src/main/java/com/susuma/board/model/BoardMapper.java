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
	
	public int askWrite(BoardDTO dto); // [6] 1:1문의 등록
	
	public BoardDTO askView(String boNo); // [7] 1:1문의 상세보기
	
	public BoardDTO getPreNext(String boNo);//[8] 이전글 다음글
	
	public int insertReply(BoardDTO dto); //[9] 1:1답변 등록
	
	public void askDelete(String boNo); // [10] 1:1문의 삭제

}
