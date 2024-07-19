package com.susuma.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.apache.catalina.mapper.Mapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/chat")
public class MessageController extends HttpServlet {
//    private DatabaseManager dbManager = new DatabaseManager();
//    private ObjectMapper mapper = new ObjectMapper();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    	doAction(request, response);
//    	try {
//            List<Message> messages = dbManager.getMessages();
//            String json = Mapper.writeValueAsString(messages);
//            response.setContentType("application/json");
//            response.getWriter().write(json);
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//        }
        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doAction(request, response);
//        try {
//            int masterNo = Integer.parseInt(request.getParameter("masterNo"));
//            int clientNo = Integer.parseInt(request.getParameter("clientNo"));
//            String messageText = request.getParameter("messageText");
//            dbManager.addMessage(masterNo, clientNo, messageText);
//            response.setStatus(HttpServletResponse.SC_OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//        }
        
    }
    
    protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	String name = request.getParameter("name");
    	String age = request.getParameter("age");
    	System.out.println(name);
    	System.out.println(age);
    	
    	//....
    	response.setContentType("application/json");
    	PrintWriter out = response.getWriter();
    	
    	out.println("{\"key\" : \"value\"}");
    }
    
}
