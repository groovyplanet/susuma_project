package com.susuma.alert.model;

import java.sql.Timestamp;

public class AlertDTO {

	private String alNo;
	private String meNo;
	private String reqNo;
	private String message;
	private Timestamp sendTime;

	public AlertDTO() {
		super();
	}

	public AlertDTO(String alNo, String meNo, String reqNo, String message, Timestamp sendTime) {
		super();
		this.alNo = alNo;
		this.meNo = meNo;
		this.reqNo = reqNo;
		this.message = message;
		this.sendTime = sendTime;
	}

	public String getAlNo() {
		return alNo;
	}

	public void setAlNo(String alNo) {
		this.alNo = alNo;
	}

	public String getMeNo() {
		return meNo;
	}

	public void setMeNo(String meNo) {
		this.meNo = meNo;
	}

	public String getReqNo() {
		return reqNo;
	}

	public void setReqNo(String reqNo) {
		this.reqNo = reqNo;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Timestamp getSendTime() {
		return sendTime;
	}

	public void setSendTime(Timestamp sendTime) {
		this.sendTime = sendTime;
	}

}
