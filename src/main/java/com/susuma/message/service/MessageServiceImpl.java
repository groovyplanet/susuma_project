package com.susuma.message.service;

import com.susuma.message.model.MessageDTO;
import com.susuma.message.model.MessageMapper;
import java.util.List;
import java.sql.SQLException;

public class MessageServiceImpl implements MessageService {
    private MessageMapper messageMapper = new MessageMapper();

    @Override
    public List<MessageDTO> getMessages() {
        try {
            return messageMapper.getMessages();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void addMessage(int masterNo, int clientNo, String messageText) {
        try {
            messageMapper.addMessage(masterNo, clientNo, messageText);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
