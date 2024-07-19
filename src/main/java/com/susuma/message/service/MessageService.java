package com.susuma.message.service;

import com.susuma.message.model.MessageDTO;
import java.util.List;

public interface MessageService {
    List<MessageDTO> getMessages();
    void addMessage(int masterNo, int clientNo, String messageText);
}
