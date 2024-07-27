package com.susuma.point.model;

import java.sql.Timestamp;

public class PointDTO {
    private String pcNo;
    private String meNo;
    private int point;
    private Timestamp insertTime;

    public PointDTO() {}

    public PointDTO(String pcNo, String meNo, int point, Timestamp insertTime) {
        this.pcNo = pcNo;
        this.meNo = meNo;
        this.point = point;
        this.insertTime = insertTime;
    }

    public String getPcNo() {
        return pcNo;
    }

    public void setPcNo(String pcNo) {
        this.pcNo = pcNo;
    }

    public String getMeNo() {
        return meNo;
    }

    public void setMeNo(String meNo) {
        this.meNo = meNo;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public Timestamp getInsertTime() {
        return insertTime;
    }

    public void setInsertTime(Timestamp insertTime) {
        this.insertTime = insertTime;
    }
}
