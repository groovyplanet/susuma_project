package com.susuma.controller;

import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profileEdit.member")
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer meNo = (Integer) session.getAttribute("me_no"); // 세션에서 me_no 가져오기

        if (meNo != null) {
            try (SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession()) {
                MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
                MemberDTO member = mapper.selectMemberById(meNo);
                request.setAttribute("member", member);
                request.getRequestDispatcher("/profile_edit.jsp").forward(request, response); // JSP 경로 확인
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/error.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}
