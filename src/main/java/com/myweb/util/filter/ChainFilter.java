package com.myweb.util.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;


//1. filter인터페이스를 상속받고, web.xml 또는 @WebFilter를 이용해서 필터를 등록
//@WebFilter("/*" ) //모든 요청에 대해서 필터가 실행됨
public class ChainFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		System.out.println("1번 필터 실행됨");
		
		//다음 필터로 연결 - 다음이 없으면 servlet으로 연결됨
		chain.doFilter(request, response);
		
	}

}
