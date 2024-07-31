package com.susuma.point.model;

import java.sql.Timestamp;

public class PointDTO {
    private String pcNo; // UUID를 위한 필드 추가
    private String meNo;
    private int point;
    private Timestamp insertTime;


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
