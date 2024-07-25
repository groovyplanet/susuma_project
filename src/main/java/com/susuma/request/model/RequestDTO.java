package com.susuma.request.model;

import java.sql.Timestamp;

public class RequestDTO {

	private String reqNo;
	private String masterNo;
	private String clientNo;
	private String content;
	private String date;
	private String time;
	private String status;
	private String cancelReason;
	private Timestamp insertTime;
	private Timestamp approvalTime;
	private Timestamp cancelTime;
	private String payAmount;
	private String payStatus;
	private Timestamp payRequestTime;
	private Timestamp paidTime;

	private String address; // "ADDRESS"
	private String addressDetail; // "ADDRESS_DETAIL"
	private Double latitude; // "LATITUDE"
	private Double longitude; // "LONGITUDE"
	private String phoneNum; // "PHONE_NUM"

	public RequestDTO() {

	}
	//예약 신청 시 사용
	public RequestDTO(String masterNo, String clientNo, String content, String date, String time, String address, String addressDetail, Double latitude, Double longitude, String phoneNum) {
		super();
		this.masterNo = masterNo;
		this.clientNo = clientNo;
		this.content = content;
		this.date = date;
		this.time = time;
		this.address = address;
		this.addressDetail = addressDetail;
		this.latitude = latitude;
		this.longitude = longitude;
		this.phoneNum = phoneNum;
	}

	public RequestDTO(String reqNo, String masterNo, String clientNo, String content, String date, String time, String status, String cancelReason, Timestamp insertTime, Timestamp approvalTime, Timestamp cancelTime, String payAmount, String payStatus, Timestamp payRequestTime, Timestamp paidTime, String address, String addressDetail, Double latitude, Double longitude, String phoneNum) {
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
		this.address = address;
		this.addressDetail = addressDetail;
		this.latitude = latitude;
		this.longitude = longitude;
		this.phoneNum = phoneNum;
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

	public String getPayAmount() {
		return payAmount;
	}

	public void setPayAmount(String payAmount) {
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddressDetail() {
		return addressDetail;
	}

	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

}
