package com.susuma.member.model;

import java.sql.Timestamp;
import java.util.Base64;

public class MemberDTO {

	// MEMBER 테이블
	private String meNo; // "ME_NO"
	private String clientNo; // "CLIENT_NO"
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
	private byte[] profilePhoto; // "PROFILE_PHOTO"
	private String joinApproval; // "JOIN_APPROVAL"
	private Timestamp joinApprovalTime; // "JOIN_APPROVAL_TIME"
	private String businessNumber; // "BUSINESS_NUMBER"
	private String shortDescription; // "SHORT_DESCRIPTION"
	private String maxDistance; // "MAX_DISTANCE"
	private String description; // "DESCRIPTION"
	private String workHours; // "WORK_HOURS"
	private String point; // "point"
	private String status; // "STATUS"
	private Timestamp insertTime; // "INSERT_TIME"
	private Timestamp updateTime; // "UPDATE_TIME"

	// CATEGORY 테이블
	private String caNo; // "CA_NO"
	private String caName; // "CA_NAME"
	private String caRootNo; // "CA_ROOT_NO"
	private String caRootName; // "CA_ROOT_NAME"

	// 수리기사 추가 정보(JOIN)
	private String averageScore; // 별점 평균
	private String reviewCount; // 별점 갯수
	private String masterName; // 마스터 이름
	private String clientName; // 의뢰인 이름
	private String reNo; // 리뷰 번호
	private String content; // 리뷰내역
	private String starScore; // 별점
	private String requestDateTime; // 예약되어있는 날짜 및 시간

	// 페이징
	private String rn;

	// 기본 생성자 : MyBatis에서 DTO (Data Transfer Object) 클래스 사용할 때 필수
	public MemberDTO() {
	}

	// insert/update 시 이용
	public MemberDTO(String meNo, String type, String email, String pw, String name, String phoneNum, String address, String addressDetail, Double latitude, Double longitude, String emailNotification, byte[] profilePhoto, String businessNumber, String shortDescription, String maxDistance, String description, String workHours, String joinApproval, String caNo, String point, String status) {
		this.meNo = meNo; // 수정일 경우만
		this.type = type;
		this.email = email;
		this.pw = pw;
		this.name = name;
		this.phoneNum = phoneNum;
		this.address = address;
		this.addressDetail = addressDetail;
		this.latitude = latitude;
		this.longitude = longitude;
		this.emailNotification = emailNotification;
		this.profilePhoto = profilePhoto;
		this.businessNumber = businessNumber; // 수리기사
		this.shortDescription = shortDescription; // 수리기사
		this.maxDistance = maxDistance; // 수리기사
		this.description = description; // 수리기사
		this.workHours = workHours; // 수리기사
		this.caNo = caNo; // 수리기사
		this.joinApproval = joinApproval; // 관리자
		this.point = point; // 관리자
		this.status = status; // 관리자
	}

	// 모든 필드를 포함하는 생성자
	public MemberDTO(String meNo, String type, String email, String pw, String name, String address, String addressDetail, Double latitude, Double longitude, String phoneNum, String emailNotification, byte[] profilePhoto, String joinApproval, Timestamp joinApprovalTime, String businessNumber, String shortDescription, String maxDistance, String description, String workHours, String point, String status, Timestamp insertTime, Timestamp updateTime, String caNo, String caName, String caRootNo,
			String caRootName, String rn) {
		super();
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
		this.caNo = caNo;
		this.caName = caName;
		this.caRootNo = caRootNo;
		this.caRootName = caRootName;
		this.rn = rn;
	}

	public String getMeNo() {
		return meNo;
	}

	public void setMeNo(String meNo) {
		this.meNo = meNo;
	}

	public String getClientNo() {
		return clientNo;
	}

	public void setClientNo(String clientNo) {
		this.clientNo = clientNo;
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

	public byte[] getProfilePhoto() {
		return profilePhoto;
	}

	public void setProfilePhoto(byte[] profilePhoto) {
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

	public String getMaxDistance() {
		return maxDistance;
	}

	public void setMaxDistance(String maxDistance) {
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

	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
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

	public String getRn() {
		return rn;
	}

	public void setRn(String rn) {
		this.rn = rn;
	}

	public String getAverageScore() {
		return averageScore;
	}

	public void setAverageScore(String averageScore) {
		this.averageScore = averageScore;
	}

	public String getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(String reviewCount) {
		this.reviewCount = reviewCount;
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

	public String getReNo() {
		return reNo;
	}

	public void setReNo(String reNo) {
		this.reNo = reNo;
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

	public String getRequestDateTime() {
		return requestDateTime;
	}

	public void setRequestDateTime(String requestDateTime) {
		this.requestDateTime = requestDateTime;
	}

	public String getProfilePhotoImg() {
		if (profilePhoto == null || profilePhoto.equals("")) {
			return "";
		}
		return Base64.getEncoder().encodeToString(profilePhoto);
	}

}