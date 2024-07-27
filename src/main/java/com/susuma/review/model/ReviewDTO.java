package com.susuma.review.model;

import java.security.Timestamp;
import java.util.Base64;

public class ReviewDTO {

	private String reNo; // reNo는 자동 생성
	private String reqNo; // reqNo를 int 타입으로 선언
	private String masterNo;
	private String clientNo;
	private String content;
	private String starScore;
	private Timestamp insertTime;
	private Timestamp updateTime;
	private String masterName;
	private String clientName;

	// 후기 내역 DTO 추가
	private String address;
	private byte[] profilePhoto; // "PROFILE_PHOTO"

	public ReviewDTO() {
		super();
	}

	public ReviewDTO(String reNo, String reqNo, String masterNo, String clientNo, String content, String starScore, Timestamp insertTime, Timestamp updateTime, String masterName, String address) {
		super();
		this.reNo = reNo;
		this.reqNo = reqNo;
		this.masterNo = masterNo;
		this.clientNo = clientNo;
		this.content = content;
		this.starScore = starScore;
		this.insertTime = insertTime;
		this.updateTime = updateTime;
		this.masterName = masterName;
		this.address = address;
	}
	

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getReNo() {
		return reNo;
	}

	public void setReNo(String reNo) {
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

	public String getStarScore() {
		return starScore;
	}

	public void setStarScore(String starScore) {
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

	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public byte[] getProfilePhoto() {
		return profilePhoto;
	}

	public String getProfilePhotoImg() {
		if (profilePhoto == null || profilePhoto.equals("")) {
			return "";
		}
		return Base64.getEncoder().encodeToString(profilePhoto);
	}

	public void setProfilePhoto(byte[] profilePhoto) {
		this.profilePhoto = profilePhoto;
	}

}
