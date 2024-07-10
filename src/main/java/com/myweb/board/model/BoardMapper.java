package com.myweb.board.model;

import java.util.ArrayList;

public interface BoardMapper {
	//마이바티스는 인터페이스를 호출시키면, 연결될 수 있는 mapper.xml파일이 실행됨
	public String now(); //test코드
	public ArrayList<BoardDTO> getList(); //글 목록 조회
	public int regist(BoardDTO dto); //글 등록
	public BoardDTO getContent(String bno); //글 상세 내용
	public int update(BoardDTO dto); //글 수정
	public void delete(String bno); //글 삭제
	public void increaseHit(String bno); //조회수
}
