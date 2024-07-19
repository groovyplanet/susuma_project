package com.susuma.member.model;

import java.sql.Timestamp;

public class MemberDTO {

	private int meNo;
	private String email;
	private String pw;
	private String address;
	private String addressDetail;
	private String zipcode;
	private String phoneNum;
	private char emailNotification;
	private String profilePhoto;
	private String type;
	private String status;
	private String latitude;
	private String kyungdo;
	private char joinApproval;
	private Timestamp joinApprovalTime;
	private String businessNumber;
	private String shortDescription;
	private int maxDistance;
	private String description;
	private int point;
	private String workHours;
	private Timestamp insertTime;
	private Timestamp updateTime;

	public MemberDTO() {
		super();
	}

	public MemberDTO(int meNo, String email, String pw, String address, String addressDetail, String zipcode, String phoneNum, char emailNotification, String profilePhoto, String type, String status, String latitude, String kyungdo, char joinApproval, Timestamp joinApprovalTime, String businessNumber, String shortDescription, int maxDistance, String description, int point, String workHours, Timestamp insertTime, Timestamp updateTime) {
		super();
		this.meNo = meNo;
		this.email = email;
		this.pw = pw;
		this.address = address;
		this.addressDetail = addressDetail;
		this.zipcode = zipcode;
		this.phoneNum = phoneNum;
		this.emailNotification = emailNotification;
		this.profilePhoto = profilePhoto;
		this.type = type;
		this.status = status;
		this.latitude = latitude;
		this.kyungdo = kyungdo;
		this.joinApproval = joinApproval;
		this.joinApprovalTime = joinApprovalTime;
		this.businessNumber = businessNumber;
		this.shortDescription = shortDescription;
		this.maxDistance = maxDistance;
		this.description = description;
		this.point = point;
		this.workHours = workHours;
		this.insertTime = insertTime;
		this.updateTime = updateTime;
	}

	public int getMeNo() {
		return meNo;
	}

	public void setMeNo(int meNo) {
		this.meNo = meNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
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

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public char getEmailNotification() {
		return emailNotification;
	}

	public void setEmailNotification(char emailNotification) {
		this.emailNotification = emailNotification;
	}

	public String getProfilePhoto() {
		return profilePhoto;
	}

	public void setProfilePhoto(String profilePhoto) {
		this.profilePhoto = profilePhoto;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getKyungdo() {
		return kyungdo;
	}

	public void setKyungdo(String kyungdo) {
		this.kyungdo = kyungdo;
	}

	public char getJoinApproval() {
		return joinApproval;
	}

	public void setJoinApproval(char joinApproval) {
		this.joinApproval = joinApproval;
	}

	public Timestamp getJoinApprovalTime() {
		return joinApprovalTime;
	}

	public void setJoinApprovalTime(Timestamp joinApprovalTime) {
		this.joinApprovalTime = joinApprovalTime;
	}

	public String getBusinessNumber() {
		return businessNumber;
	}

	public void setBusinessNumber(String businessNumber) {
		this.businessNumber = businessNumber;
	}

	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public int getMaxDistance() {
		return maxDistance;
	}

	public void setMaxDistance(int maxDistance) {
		this.maxDistance = maxDistance;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getWorkHours() {
		return workHours;
	}

	public void setWorkHours(String workHours) {
		this.workHours = workHours;
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
