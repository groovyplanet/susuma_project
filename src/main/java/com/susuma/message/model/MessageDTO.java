package com.susuma.message.model;

import java.sql.Timestamp;

public class MessageDTO {
    private int msgNo;
    private int masterNo;
    private int clientNo;
    private String message;
    private char read;
    private Timestamp sendTime;
    private Timestamp readTime;

    // Getters and Setters
    public int getMsgNo() {
        return msgNo;
    }

    public void setMsgNo(int msgNo) {
        this.msgNo = msgNo;
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

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public char getRead() {
        return read;
    }

    public void setRead(char read) {
        this.read = read;
    }

    public Timestamp getSendTime() {
        return sendTime;
    }

    public void setSendTime(Timestamp sendTime) {
        this.sendTime = sendTime;
    }


    public Timestamp getReadTime() {
        return readTime;
    }

    public void setReadTime(Timestamp readTime) {
        this.readTime = readTime;
    }
}

