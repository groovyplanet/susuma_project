package com.myweb.util.mybatis;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisUtil {
	
	private static SqlSessionFactory sqlSessionFactory;

	static {
		
		try {
			String resource = "mybatis/config/mybatis-config.xml";
			
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

			System.out.println("sqlSessionFactory :" + sqlSessionFactory);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("sqlSessionFactory Error");
		}
	}
	
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
	
}
