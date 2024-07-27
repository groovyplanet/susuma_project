package com.susuma.request.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.request.model.RequestDTO;
import com.susuma.request.model.RequestMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class RequestServiceImpl implements RequestService{

	private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();
	
	@Override
	public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession session = request.getSession();
        String meNo = (String) session.getAttribute("meNo");
        String type = (String) session.getAttribute("type");
        SqlSession sql = sqlSessionFactory.openSession();
        RequestMapper requestMapper = sql.getMapper(RequestMapper.class);
        ArrayList<RequestDTO> list = null;
//        ArrayList<RequestDTO> list = requestMapper.getListByMember(meNo);
        if("master".equals(type)) {
        	list = requestMapper.getListByMaster(meNo);
        }else if("user".equals(type)) {
        	list = requestMapper.getListByMember(meNo);
        }
       

        sql.close();

        request.setAttribute("list", list);
        request.getRequestDispatcher("request_list.jsp").forward(request, response);
    }
	public void getMemberRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		/* [1] 매개변수 */
		String reqNo = request.getParameter("reqNo"); // 세션 값 가져오기 (*)

		/* [2] Mapper */
		SqlSession sql = sqlSessionFactory.openSession();
		RequestMapper requestMapper = sql.getMapper(RequestMapper.class);
		RequestDTO dto = requestMapper.selectRequest(reqNo);
		
		/* [3] 화면이동 */
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("request_view.jsp").forward(request, response);
		
	}
	public void updatePaymentStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  String reqNo = request.getParameter("reqNo");
		    String payStatus = request.getParameter("payStatus");
		    System.out.println(reqNo);
		    // RequestDTO 객체 생성 및 설정
		    RequestDTO dto = new RequestDTO();
		    dto.setReqNo(reqNo);
		    dto.setPayStatus(payStatus);

		    // MyBatis SQL 세션 관리
		    try (SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession()) {
		        RequestMapper requestMapper = sqlSession.getMapper(RequestMapper.class);
		        
		        
		        boolean success = requestMapper.updatePaymentStatus(dto); // DTO를 전달
		        sqlSession.commit(); // 커밋

		        // 응답 설정
		        response.setContentType("text/plain");
		        response.setCharacterEncoding("UTF-8");
		        try (PrintWriter out = response.getWriter()) {
		            if (success) {
		                out.write("Success");
		            } else {
		                out.write("Failure");
		            }
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "서버 오류 발생");
		    }
		}
}