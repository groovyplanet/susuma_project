package com.myweb.board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.myweb.util.JdbcUtil;

public class BoardDAO {

	//DAO는 불필요하게 여러개 만들 필요가 없기 때문에 객체가 한개만 생성되도록 
	//singleton형식으로 설계
	
	//1. 나자신의 객체를 1개 생성하고, private을 붙임
	private static BoardDAO instance = new BoardDAO();
	
	//2. 직접 객체를 생성할 수 없도록 생성자에도 private을 붙임
	private BoardDAO() {
		
		//커넥션풀에 사용할 객체를 얻어옴
		try {
			InitialContext init = new InitialContext(); //시작설정 객체
			ds = (DataSource)init.lookup("java:comp/env/jdbc/oracle");
			
		} catch (Exception e) {
			System.out.println("커넥션 풀 에러");
		}
	}
	
	//3. 객체 생성을 요구할때 getter메서드를 사용해서 1번의 객체를 반환
	public static BoardDAO getInstance() {
		return instance;
	}

	///////////////////////////////////////
	//커넥션 풀 객체정보
	private DataSource ds;
	
	
	//글 등록
	public void regist(String writer,
					   String title,
					   String content) {
		
		String sql = "INSERT INTO BOARD(BNO, WRITER, TITLE, CONTENT) "
				   + "VALUES(BOARD_SEQ.NEXTVAL, ?, ?, ?)";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer );
			pstmt.setString(2, title );
			pstmt.setString(3, content );
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn, pstmt, null);
		}

	
	}
	
	//글 목록 조회
	public ArrayList<BoardDTO> getList() {
		
		ArrayList<BoardDTO> list = new ArrayList<>();
		
		String sql = "SELECT * FROM BOARD ORDER BY BNO DESC";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); //select는 Query
			
			while(rs.next()) {
				//1행에 대한 처리
				//컬럼을 DTO에 담고, DTO를 List에 추가한다.
				
				int bno = rs.getInt("bno"); //컬럼명
				String writer = rs.getString("writer");
				String title = rs.getString("title");
				String content = rs.getString("content");
				Timestamp regdate = rs.getTimestamp("regdate");
				int hit = rs.getInt("hit");
				//dto생성
				BoardDTO dto = new BoardDTO(bno, writer, title, content, regdate, hit);
				
				//list추가
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn, pstmt, rs);
		}
		
		return list;
	}
}

