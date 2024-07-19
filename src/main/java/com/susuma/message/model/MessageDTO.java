package com.susuma.message.model;

import java.sql.Timestamp;

public class MessageDTO {
    private int msgNo;
    private int masterNo;
    private int clientNo;
    private String messageText;
    private char read;
    private Timestamp sendTime;
    private Timestamp readTime;

    public MessageDTO(int msgNo, int masterNo, int clientNo, String messageText, char read, Timestamp sendTime, Timestamp readTime) {
        this.msgNo = msgNo;
        this.masterNo = masterNo;
        this.clientNo = clientNo;
        this.messageText = messageText;
        this.read = read;
        this.sendTime = sendTime;
        this.readTime = readTime;
    }

    // Getters and setters...
}
