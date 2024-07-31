package com.susuma.message.model;

import java.sql.Timestamp;
import java.util.Base64;

public class MessageDTO {
	private String msgNo;
	private String sendMeNo;
	private String getMeNo;
	private String message;
	private String read;
	private Timestamp sendTime;
	private Timestamp readTime;

	// 추가
	private String notReadCnt;

	// MEMBER 테이블
	private String sendType;
	private String sendName;
	private byte[] sendProfilePhoto;
	private String getType;
	private String getName;
	private byte[] getProfilePhoto;

	public MessageDTO() {
		super();
	}

	public MessageDTO(String msgNo, String sendMeNo, String getMeNo, String message, String read, Timestamp sendTime, Timestamp readTime) {
		super();
		this.msgNo = msgNo;
		this.sendMeNo = sendMeNo;
		this.getMeNo = getMeNo;
		this.message = message;
		this.read = read;
		this.sendTime = sendTime;
		this.readTime = readTime;
	}

	public String getMsgNo() {
		return msgNo;
	}

	public void setMsgNo(String msgNo) {
		this.msgNo = msgNo;
	}

	public String getSendMeNo() {
		return sendMeNo;
	}

	public void setSendMeNo(String sendMeNo) {
		this.sendMeNo = sendMeNo;
	}

	public String getGetMeNo() {
		return getMeNo;
	}

	public void setGetMeNo(String getMeNo) {
		this.getMeNo = getMeNo;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getRead() {
		return read;
	}

	public void setRead(String read) {
		this.read = read;
	}

	public Timestamp getSendTime() {
		return sendTime;
	}

	public void setSendTime(Timestamp sendTime) {
		this.sendTime = sendTime;
	}

	public Timestamp getReadTime() {
		return readTime;
	}

	public void setReadTime(Timestamp readTime) {
		this.readTime = readTime;
	}

	public String getSendType() {
		return sendType;
	}

	public void setSendType(String sendType) {
		this.sendType = sendType;
	}

	public String getSendName() {
		return sendName;
	}

	public void setSendName(String sendName) {
		this.sendName = sendName;
	}

	public byte[] getSendProfilePhoto() {
		return sendProfilePhoto;
	}

	public void setSendProfilePhoto(byte[] sendProfilePhoto) {
		this.sendProfilePhoto = sendProfilePhoto;
	}

	public String getSendProfilePhotoImg() {
		if (sendProfilePhoto == null || sendProfilePhoto.equals("")) {
			return "";
		}
		return Base64.getEncoder().encodeToString(sendProfilePhoto);
	}

	public void setGetProfilePhoto(byte[] getProfilePhoto) {
		this.getProfilePhoto = getProfilePhoto;
	}

	public String getGetProfilePhotoImg() {
		if (getProfilePhoto == null || getProfilePhoto.equals("")) {
			return "";
		}
		return Base64.getEncoder().encodeToString(getProfilePhoto);
	}

	public String getGetType() {
		return getType;
	}

	public void setGetType(String getType) {
		this.getType = getType;
	}

	public String getGetName() {
		return getName;
	}

	public void setGetName(String getName) {
		this.getName = getName;
	}

	public byte[] getGetProfilePhoto() {
		return getProfilePhoto;
	}

	public String getNotReadCnt() {
		return notReadCnt;
	}

	public void setNotReadCnt(String notReadCnt) {
		this.notReadCnt = notReadCnt;
	}

}
