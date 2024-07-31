package com.susuma.request.model;

import java.sql.Timestamp;
import java.util.Base64;

public class RequestDTO {

	private int reqNo;
	private String masterNo;
	private String clientNo;
	private String content;
	private String requestDate;
	private String requestTime;
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

	// MEMBER
	private String masterName;
	private String clientName;
	private String masterAddress;
	private String clientAddress;
	private String clientAddressDetail;
	private String masterPhoneNum;
	private String clientPhoneNum;
	private byte[] masterProfilePhoto;
	private byte[] clientProfilePhoto;

	// CATEGORY 테이블
	private String caNo; // "CA_NO"
	private String caName; // "CA_NAME"
	private String caRootNo; // "CA_ROOT_NO"
	private String caRootName; // "CA_ROOT_NAME"

	// 예약내역에서 상태 별 개수 확인
	private String allCnt;
	private String requestedCnt;
	private String approvedCnt;
	private String paywaitCnt;
	private String paidCnt;
	private String cancelCnt;

	// REVIEW
	private String reviewCnt;
	private String reviewContent;
	private String starScore;

	// 페이징
	private String rn;
	
	// 남은 날짜
	private String daysDiff;
	

	public RequestDTO() {

	}

	// upsert 시 사용
	public RequestDTO(int reqNo, String masterNo, String clientNo, String content, String requestDate, String requestTime, String status, String payAmount, String cancelReason) {
		super();
		this.reqNo = reqNo;
		this.masterNo = masterNo;
		this.clientNo = clientNo;
		this.content = content;
		this.requestDate = requestDate;
		this.requestTime = requestTime;
		this.status = status;
		this.payAmount = payAmount;
		this.cancelReason = cancelReason;
	}

	public RequestDTO(int reqNo, String masterNo, String clientNo, String content, String requestDate, String requestTime, String address, String addressDetail, Double latitude, Double longitude, String phoneNum, String masterName, String clientName) {
		super();
		this.reqNo = reqNo;
		this.masterNo = masterNo;
		this.clientNo = clientNo;
		this.content = content;
		this.requestDate = requestDate;
		this.requestTime = requestTime;
		this.address = address;
		this.addressDetail = addressDetail;
		this.latitude = latitude;
		this.longitude = longitude;
		this.phoneNum = phoneNum;
		this.masterName = masterName;
		this.clientName = clientName;
	}

	public RequestDTO(int reqNo, String masterNo, String clientNo, String content, String requestDate, String requestTime, String status, String cancelReason, Timestamp insertTime, Timestamp approvalTime, Timestamp cancelTime, String payAmount, String payStatus, Timestamp payRequestTime, Timestamp paidTime, String address, String addressDetail, Double latitude, Double longitude, String phoneNum, String masterName, String clientName, String masterAddress, String clientAddress,
			byte[] masterProfilePhoto, byte[] clientProfilePhoto) {
		super();
		this.reqNo = reqNo;
		this.masterNo = masterNo;
		this.clientNo = clientNo;
		this.content = content;
		this.requestDate = requestDate;
		this.requestTime = requestTime;
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
		this.masterName = masterName;
		this.clientName = clientName;
		this.masterAddress = masterAddress;
		this.clientAddress = clientAddress;
		this.masterProfilePhoto = masterProfilePhoto;
		this.clientProfilePhoto = clientProfilePhoto;
	}

	public int getReqNo() {
		return reqNo;
	}

	public void setReqNo(int reqNo) {
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

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	public String getRequestTime() {
		return requestTime;
	}

	public void setRequestTime(String requestTime) {
		this.requestTime = requestTime;
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
		if (clientProfilePhoto == null || clientProfilePhoto.equals("")) {
			return "";
		}
		return Base64.getEncoder().encodeToString(clientProfilePhoto);
	}

	public String getCaNo() {
		return caNo;
	}

	public void setCaNo(String caNo) {
		this.caNo = caNo;
	}

	public String getCaName() {
		return caName;
	}

	public void setCaName(String caName) {
		this.caName = caName;
	}

	public String getCaRootNo() {
		return caRootNo;
	}

	public void setCaRootNo(String caRootNo) {
		this.caRootNo = caRootNo;
	}

	public String getCaRootName() {
		return caRootName;
	}

	public void setCaRootName(String caRootName) {
		this.caRootName = caRootName;
	}

	public String getClientAddressDetail() {
		return clientAddressDetail;
	}

	public void setClientAddressDetail(String clientAddressDetail) {
		this.clientAddressDetail = clientAddressDetail;
	}

	public String getAllCnt() {
		return allCnt;
	}

	public void setAllCnt(String allCnt) {
		this.allCnt = allCnt;
	}

	public String getRequestedCnt() {
		return requestedCnt;
	}

	public void setRequestedCnt(String requestedCnt) {
		this.requestedCnt = requestedCnt;
	}

	public String getApprovedCnt() {
		return approvedCnt;
	}

	public void setApprovedCnt(String approvedCnt) {
		this.approvedCnt = approvedCnt;
	}

	public String getPaywaitCnt() {
		return paywaitCnt;
	}

	public void setPaywaitCnt(String paywaitCnt) {
		this.paywaitCnt = paywaitCnt;
	}

	public String getPaidCnt() {
		return paidCnt;
	}

	public void setPaidCnt(String paidCnt) {
		this.paidCnt = paidCnt;
	}

	public String getCancelCnt() {
		return cancelCnt;
	}

	public void setCancelCnt(String cancelCnt) {
		this.cancelCnt = cancelCnt;
	}

	public String getMasterPhoneNum() {
		return masterPhoneNum;
	}

	public void setMasterPhoneNum(String masterPhoneNum) {
		this.masterPhoneNum = masterPhoneNum;
	}

	public String getClientPhoneNum() {
		return clientPhoneNum;
	}

	public void setClientPhoneNum(String clientPhoneNum) {
		this.clientPhoneNum = clientPhoneNum;
	}

	public String getReviewCnt() {
		return reviewCnt;
	}

	public void setReviewCnt(String reviewCnt) {
		this.reviewCnt = reviewCnt;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public String getStarScore() {
		return starScore;
	}

	public void setStarScore(String starScore) {
		this.starScore = starScore;
	}

	public String getRn() {
		return rn;
	}

	public void setRn(String rn) {
		this.rn = rn;
	}

	public String getDaysDiff() {
		return daysDiff;
	}

	public void setDaysDiff(String daysDiff) {
		this.daysDiff = daysDiff;
	}

}
