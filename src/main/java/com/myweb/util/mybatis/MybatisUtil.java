package com.myweb.util.mybatis;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisUtil {
	
	//마이바티스 세션팩토리 생성, 설정파일의 위치 등을 지정

	private static SqlSessionFactory sqlSessionFactory;

	//첫번째 실행시 1번만 동작된다.
	static {
		//src/main/resources 폴더 생성
		//src/main/resources/mybatis.config 패키지 생성 
		//밑에 mybatis-config.xml파일이 있어야합니다.
		
		try {
			String resource = "mybatis/config/mybatis-config.xml"; //resrouces 폴더 아래에서 경로가 시작함. 마이바티스 설정 파일의 위치
			
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

			System.out.println("잘실행됨:" + sqlSessionFactory);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("터졌냐?");
		}
	}
	//GETTER
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
	
}
