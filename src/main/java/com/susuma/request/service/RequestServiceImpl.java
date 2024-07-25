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
        SqlSession sql = sqlSessionFactory.openSession();
        RequestMapper requestMapper = sql.getMapper(RequestMapper.class);
        ArrayList<RequestDTO> list = requestMapper.getListByMember(meNo);
       

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
		RequestDTO dto = requestMapper.getRequestByNo(reqNo);
		
		/* [3] 화면이동 */
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("request_view.jsp").forward(request, response);
		
	}
}