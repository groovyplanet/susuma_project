package com.susuma.controller;

import java.io.IOException;

import org.apache.ibatis.session.SqlSession;

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
        MemberDTO loggedInUser = (MemberDTO) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            try (SqlSession sqlSession = MybatisUtil.getSqlSessionFactory().openSession()) {
                MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
                MemberDTO member = mapper.selectMemberById(loggedInUser.getMeNo());
                request.setAttribute("member", member);
                request.getRequestDispatcher("/user/profile_edit.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/error.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}
