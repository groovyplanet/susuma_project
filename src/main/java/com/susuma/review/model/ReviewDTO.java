package com.susuma.review.model;

import java.security.Timestamp;

public class ReviewDTO {

    private int reNo; // reNo는 자동 생성
    private String reqNo; // reqNo를 int 타입으로 선언
	private String masterNo;
	private String clientNo;
	private String content;
	private int starScore;
	private Timestamp insertTime;
	private Timestamp updateTime;

	public ReviewDTO() {
		super();
	}
	
	

	public ReviewDTO(int reNo, String reqNo, String masterNo, String clientNo, String content, int starScore,
			Timestamp insertTime, Timestamp updateTime) {
		super();
		this.reNo = reNo;
		this.reqNo = reqNo;
		this.masterNo = masterNo;
		this.clientNo = clientNo;
		this.content = content;
		this.starScore = starScore;
		this.insertTime = insertTime;
		this.updateTime = updateTime;
	}



	public int getReNo() {
		return reNo;
	}

	public void setReNo(int reNo) {
		this.reNo = reNo;
	}

	public String getReqNo() {
		return reqNo;
	}

	public void setReqNo(String reqNo) {
		this.reqNo = reqNo;
	}

	public String getMasterNo() {
		return masterNo;
	}

	public void setMasterNo(String masterNo) {
		this.masterNo = masterNo;
	}

	public String getClientNo() {
		return clientNo;
	}

	public void setClientNo(String clientNo) {
		this.clientNo = clientNo;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getStarScore() {
		return starScore;
	}

	public void setStarScore(int starScore) {
		this.starScore = starScore;
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
}
	

	