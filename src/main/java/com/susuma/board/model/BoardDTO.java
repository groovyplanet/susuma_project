package com.susuma.board.model;

import java.sql.Timestamp;

public class BoardDTO {

	private int boNo;
	private int meNo;
	private String type;
	private String title;
	private String content;
	private Timestamp insertTime;
	private Timestamp updateTime;
	private String answer;
	private Timestamp answerInsertTime;
	private Timestamp answerUpdateTime;
	private String name;
	private int rn; // 페이징 처리
	private int next;
	private int last;
	private String nextTitle;
	private String lastTitle;

	public BoardDTO() {
		super();
	}

	// 게시물 등록
	public BoardDTO(int meNo, String type, String title, String content) {
		super();
		this.meNo = meNo;
		this.type = type;
		this.title = title;
		this.content = content;
	}

	public BoardDTO(int boNo, int meNo, String type, String title, String content, Timestamp insertTime, Timestamp updateTime, String answer, Timestamp answerInsertTime, Timestamp answerUpdateTime, String name, int rn) {
		super();
		this.boNo = boNo;
		this.meNo = meNo;
		this.type = type;
		this.title = title;
		this.content = content;
		this.insertTime = insertTime;
		this.updateTime = updateTime;
		this.answer = answer;
		this.answerInsertTime = answerInsertTime;
		this.answerUpdateTime = answerUpdateTime;
		this.name = name;
		this.rn = rn;
	}
	
	
	

	

	public int getNext() {
		return next;
	}

	public void setNext(int next) {
		this.next = next;
	}

	public int getLast() {
		return last;
	}

	public void setLast(int last) {
		this.last = last;
	}

	public String getNextTitle() {
		return nextTitle;
	}

	public void setNextTitle(String nextTitle) {
		this.nextTitle = nextTitle;
	}

	public String getLastTitle() {
		return lastTitle;
	}

	public void setLastTitle(String lastTitle) {
		this.lastTitle = lastTitle;
	}

	public int getBoNo() {
		return boNo;
	}

	public void setBoNo(int boNo) {
		this.boNo = boNo;
	}

	public int getMeNo() {
		return meNo;
	}

	public void setMeNo(int meNo) {
		this.meNo = meNo;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(Timestamp insertTime) {
		this.insertTime = insertTime;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Timestamp getAnswerInsertTime() {
		return answerInsertTime;
	}

	public void setAnswerInsertTime(Timestamp answerInsertTime) {
		this.answerInsertTime = answerInsertTime;
	}

	public Timestamp getAnswerUpdateTime() {
		return answerUpdateTime;
	}

	public void setAnswerUpdateTime(Timestamp answerUpdateTime) {
		this.answerUpdateTime = answerUpdateTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getRn() {
		return rn;
	}

	public void setRn(int rn) {
		this.rn = rn;
	}

}
