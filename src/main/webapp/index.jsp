<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String redirectURL = request.getContextPath() + "/main.member";
    response.sendRedirect(redirectURL);
    
%>