package com.myweb.util.mybatis;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisUtil {

	private static SqlSessionFactory sqlSessionFactory;

	static {
		
		try {
			String resource = "mybatis/config/mybatis-config.xml"; //resrouces 폴더 아래에서 경로가 시작함. 마이바티스 설정 파일의 위치
			
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

			System.out.println("sqlSessionFactory :" + sqlSessionFactory);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("sqlSessionFactory error");
		}
	}
	//GETTER
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
	
}
