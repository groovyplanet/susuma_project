package com.susuma.category.model;

import java.sql.Timestamp;

public class CategoryDTO {

	// CATEGORY 테이블
	private String caNo; // "CA_NO"
	private String rootNo; // "ROOT_NO"
	private String caName; // "CA_NAME"
	private Timestamp insertTime; // "INSERT_TIME"
	private Timestamp updateTime; // "UPDATE_TIME"

	public CategoryDTO() {
		super();
	}

	public CategoryDTO(String caNo, String rootNo, String caName, Timestamp insertTime, Timestamp updateTime) {
		super();
		this.caNo = caNo;
		this.rootNo = rootNo;
		this.caName = caName;
		this.insertTime = insertTime;
		this.updateTime = updateTime;
	}

	public String getcaNo() {
		return caNo;
	}

	public void setcaNo(String caNo) {
		this.caNo = caNo;
	}

	public String getRootNo() {
		return rootNo;
	}

	public void setRootNo(String rootNo) {
		this.rootNo = rootNo;
	}

	public String getCaName() {
		return caName;
	}

	public void setCaName(String caName) {
		this.caName = caName;
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
