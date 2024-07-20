package com.susuma.member.model;

import java.sql.Timestamp;

public class MemberDTO {

	private int meNo; // "ME_NO"
	private String type; // "TYPE"
	private String email; // "EMAIL"
	private String pw; // "PW"
	private String name; // "NAME"
	private String address; // "ADDRESS"
	private String addressDetail; // "ADDRESS_DETAIL"
	private Double latitude; // "LATITUDE"
	private Double longitude; // "LONGITUDE"
	private String phoneNum; // "PHONE_NUM"
	private String emailNotification; // "EMAIL_NOTIFICATION"
	private String profilePhoto; // "PROFILE_PHOTO"
	private String joinApproval; // "JOIN_APPROVAL"
	private Timestamp joinApprovalTime; // "JOIN_APPROVAL_TIME"
	private String businessNumber; // "BUSINESS_NUMBER"
	private String shortDescription; // "SHORT_DESCRIPTION"
	private int maxDistance; // "MAX_DISTANCE"
	private String description; // "DESCRIPTION"
	private String workHours; // "WORK_HOURS"
	private int point; // "POINT"
	private String status; // "STATUS"
	private Timestamp insertTime; // "INSERT_TIME"
	private Timestamp updateTime; // "UPDATE_TIME"

	// 기본 생성자 : MyBatis에서 DTO (Data Transfer Object) 클래스 사용할 때 필수
	public MemberDTO() {
	}

	// 모든 필드를 포함하는 생성자
	public MemberDTO(int meNo, String type, String email, String pw, String name, String address, String addressDetail, Double latitude, Double longitude, String phoneNum, String emailNotification, String profilePhoto, String joinApproval, Timestamp joinApprovalTime, String businessNumber, String shortDescription, int maxDistance, String description, String workHours, int point, String status, Timestamp insertTime, Timestamp updateTime) {
		this.meNo = meNo;
		this.type = type;
		this.email = email;
		this.pw = pw;
		this.name = name;
		this.address = address;
		this.addressDetail = addressDetail;
		this.latitude = latitude;
		this.longitude = longitude;
		this.phoneNum = phoneNum;
		this.emailNotification = emailNotification;
		this.profilePhoto = profilePhoto;
		this.joinApproval = joinApproval;
		this.joinApprovalTime = joinApprovalTime;
		this.businessNumber = businessNumber;
		this.shortDescription = shortDescription;
		this.maxDistance = maxDistance;
		this.description = description;
		this.workHours = workHours;
		this.point = point;
		this.status = status;
		this.insertTime = insertTime;
		this.updateTime = updateTime;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getEmailNotification() {
		return emailNotification;
	}

	public void setEmailNotification(String emailNotification) {
		this.emailNotification = emailNotification;
	}

	public String getProfilePhoto() {
		return profilePhoto;
	}

	public void setProfilePhoto(String profilePhoto) {
		this.profilePhoto = profilePhoto;
	}

	public String getJoinApproval() {
		return joinApproval;
	}

	public void setJoinApproval(String joinApproval) {
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

	public String getWorkHours() {
		return workHours;
	}

	public void setWorkHours(String workHours) {
		this.workHours = workHours;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
