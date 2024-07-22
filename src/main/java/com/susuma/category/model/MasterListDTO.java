package com.susuma.category.model;

public class MasterListDTO {
	
	//Member
	private String name;
	private String address;
	private int maxDistance;
	private String shortDescription;
	
	//Master Category
	private int masterNo;
	private int caNo;
	
	//Review
	private int stars; //가상테이블에 cnt++
	
	
	public MasterListDTO() {
		
	}

	public MasterListDTO(String name, String address, int maxDistance, String shortDescription, int masterNo, int caNo,
			int stars) {
		super();
		this.name = name;
		this.address = address;
		this.maxDistance = maxDistance;
		this.shortDescription = shortDescription;
		this.masterNo = masterNo;
		this.caNo = caNo;
		this.stars = stars;
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

	public int getMaxDistance() {
		return maxDistance;
	}

	public void setMaxDistance(int maxDistance) {
		this.maxDistance = maxDistance;
	}

	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public int getMasterNo() {
		return masterNo;
	}

	public void setMasterNo(int masterNo) {
		this.masterNo = masterNo;
	}

	public int getCaNo() {
		return caNo;
	}

	public void setCaNo(int caNo) {
		this.caNo = caNo;
	}

	public int getStars() {
		return stars;
	}

	public void setStars(int stars) {
		this.stars = stars;
	}
	
	
}


