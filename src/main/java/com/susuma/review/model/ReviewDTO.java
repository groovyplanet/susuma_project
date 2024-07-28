package com.susuma.review.model;

import java.security.Timestamp;
import java.util.Base64;

public class ReviewDTO {

	private String reNo; // reNo는 자동 생성
	private String reqNo; // reqNo를 int 타입으로 선언
	private String content;
	private String starScore;
	private Timestamp insertTime;
	private Timestamp updateTime;

	private String masterNo;
	private String clientNo;
	private String masterName;
	private String clientName;
	private String masterAddress;
	private String clientAddress;
	private byte[] masterProfilePhoto;
	private byte[] clientProfilePhoto;

	public ReviewDTO() {
		super();
	}

	// upsert 시 사용
	public ReviewDTO(String reNo, String reqNo, String content, String starScore) {
		this.reNo = reNo;
		this.reqNo = reqNo;
		this.content = content;
		this.starScore = starScore;
	}

	public ReviewDTO(String reNo, String reqNo, String content, String starScore, Timestamp insertTime, Timestamp updateTime, String masterNo, String clientNo, String masterName, String clientName, String masterAddress, String clientAddress, byte[] masterProfilePhoto, byte[] clientProfilePhoto) {
		super();
		this.reNo = reNo;
		this.reqNo = reqNo;
		this.content = content;
		this.starScore = starScore;
		this.insertTime = insertTime;
		this.updateTime = updateTime;
		this.masterNo = masterNo;
		this.clientNo = clientNo;
		this.masterName = masterName;
		this.clientName = clientName;
		this.masterAddress = masterAddress;
		this.clientAddress = clientAddress;
		this.masterProfilePhoto = masterProfilePhoto;
		this.clientProfilePhoto = clientProfilePhoto;
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

	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getMasterAddress() {
		return masterAddress;
	}

	public void setMasterAddress(String masterAddress) {
		this.masterAddress = masterAddress;
	}

	public String getClientAddress() {
		return clientAddress;
	}

	public void setClientAddress(String clientAddress) {
		this.clientAddress = clientAddress;
	}

	public byte[] getMasterProfilePhoto() {
		return masterProfilePhoto;
	}

	public void setMasterProfilePhoto(byte[] masterProfilePhoto) {
		this.masterProfilePhoto = masterProfilePhoto;
	}

	public byte[] getClientProfilePhoto() {
		return clientProfilePhoto;
	}

	public void setClientProfilePhoto(byte[] clientProfilePhoto) {
		this.clientProfilePhoto = clientProfilePhoto;
	}

	public String getmasterProfilePhotoImg() {
		if (masterProfilePhoto == null || masterProfilePhoto.equals("")) {
			return "";
		}
		return Base64.getEncoder().encodeToString(masterProfilePhoto);
	}

	public String getClientProfilePhotoImg() {
		if (masterProfilePhoto == null || masterProfilePhoto.equals("")) {
			return "";
		}
		return Base64.getEncoder().encodeToString(masterProfilePhoto);
	}

}
