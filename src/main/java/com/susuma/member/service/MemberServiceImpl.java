package com.susuma.member.service;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.susuma.member.model.MemberDTO;
import com.susuma.member.model.MemberMapper;
import com.susuma.util.mybatis.MybatisUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MemberServiceImpl implements MemberService {

    private SqlSessionFactory sqlSessionFactory = MybatisUtil.getSqlSessionFactory();

    @Override
    public void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
            ArrayList<MemberDTO> list = memberMapper.getList(type);
            request.setAttribute("type", type);
            request.setAttribute("list", list);
            request.getRequestDispatcher("member_list.jsp").forward(request, response);
        }
    }

    @Override
    public void getView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String meNo = request.getParameter("meNo");

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
            MemberDTO dto = memberMapper.getView(meNo);
            request.setAttribute("type", dto.getType());
            request.setAttribute("dto", dto);
            request.getRequestDispatcher("member_view.jsp").forward(request, response);
        }
    }

    @Override
    public void addMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        MemberDTO member = new MemberDTO();
        member.setMeNo(Integer.parseInt(request.getParameter("me_no")));
        member.setType(request.getParameter("type"));
        member.setEmail(request.getParameter("email"));
        member.setPw(request.getParameter("pw"));
        member.setName(request.getParameter("name"));
        member.setAddress(request.getParameter("address"));
        member.setAddressDetail(request.getParameter("address_detail"));
        member.setLatitude(Double.parseDouble(request.getParameter("latitude")));
        member.setLongitude(Double.parseDouble(request.getParameter("longitude")));
        member.setPhoneNum(request.getParameter("phone_num"));
        member.setEmailNotification(request.getParameter("email_notification"));
        member.setProfilePhoto(request.getParameter("profile_photo"));
        member.setJoinApproval(request.getParameter("join_approval"));

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            String joinApprovalTimeString = request.getParameter("join_approval_time");
            if (joinApprovalTimeString != null) {
                java.util.Date parsedJoinApprovalTime = dateFormat.parse(joinApprovalTimeString);
                member.setJoinApprovalTime(new Timestamp(parsedJoinApprovalTime.getTime()));
            }

            String insertTimeString = request.getParameter("insert_time");
            if (insertTimeString != null) {
                java.util.Date parsedInsertTime = dateFormat.parse(insertTimeString);
                member.setInsertTime(new Timestamp(parsedInsertTime.getTime()));
            }

            String updateTimeString = request.getParameter("update_time");
            if (updateTimeString != null) {
                java.util.Date parsedUpdateTime = dateFormat.parse(updateTimeString);
                member.setUpdateTime(new Timestamp(parsedUpdateTime.getTime()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp");
            return;
        }

        member.setBusinessNumber(request.getParameter("business_number"));
        member.setShortDescription(request.getParameter("short_description"));
        member.setMaxDistance(Integer.parseInt(request.getParameter("max_distance")));
        member.setDescription(request.getParameter("description"));
        member.setWorkHours(request.getParameter("work_hours"));
        member.setPoint(Integer.parseInt(request.getParameter("point")));
        member.setStatus(request.getParameter("status"));

        try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
            MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
            memberMapper.addMember(member);
            sqlSession.commit();
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
    }
}