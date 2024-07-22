package com.susuma.category.model;

import java.security.Timestamp;

public class CategoryDTO {
	
	private int reqNo;
	private int masterNo;
	private int clientNo;
	private String content;
	private String date;
	private String time;
	private String status;
	private String cancelReason;
	private Timestamp insertTime;
	private Timestamp approvalTime;
	private Timestamp cancelTime;
	private int payAmount;
	private String payStatus;
	private Timestamp payRequestTime;
	private Timestamp paidTime;

	public CategoryDTO() {
		
	}

	public CategoryDTO(int reqNo, int masterNo, int clientNo, String content, String date, String time, String status,
			String cancelReason, Timestamp insertTime, Timestamp approvalTime, Timestamp cancelTime, int payAmount,
			String payStatus, Timestamp payRequestTime, Timestamp paidTime) {
		super();
		this.reqNo = reqNo;
		this.masterNo = masterNo;
		this.clientNo = clientNo;
		this.content = content;
		this.date = date;
		this.time = time;
		this.status = status;
		this.cancelReason = cancelReason;
		this.insertTime = insertTime;
		this.approvalTime = approvalTime;
		this.cancelTime = cancelTime;
		this.payAmount = payAmount;
		this.payStatus = payStatus;
		this.payRequestTime = payRequestTime;
		this.paidTime = paidTime;
	}

	public int getReqNo() {
		return reqNo;
	}

	public void setReqNo(int reqNo) {
		this.reqNo = reqNo;
	}

	public int getMasterNo() {
		return masterNo;
	}

	public void setMasterNo(int masterNo) {
		this.masterNo = masterNo;
	}

	public int getClientNo() {
		return clientNo;
	}

	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	public Timestamp getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(Timestamp insertTime) {
		this.insertTime = insertTime;
	}

	public Timestamp getApprovalTime() {
		return approvalTime;
	}

	public void setApprovalTime(Timestamp approvalTime) {
		this.approvalTime = approvalTime;
	}

	public Timestamp getCancelTime() {
		return cancelTime;
	}

	public void setCancelTime(Timestamp cancelTime) {
		this.cancelTime = cancelTime;
	}

	public int getPayAmount() {
		return payAmount;
	}

	public void setPayAmount(int payAmount) {
		this.payAmount = payAmount;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public Timestamp getPayRequestTime() {
		return payRequestTime;
	}

	public void setPayRequestTime(Timestamp payRequestTime) {
		this.payRequestTime = payRequestTime;
	}

	public Timestamp getPaidTime() {
		return paidTime;
	}

	public void setPaidTime(Timestamp paidTime) {
		this.paidTime = paidTime;
	}
	
	
}

