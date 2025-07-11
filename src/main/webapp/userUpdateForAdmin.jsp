<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sist.web.dao.UserDao, com.sist.web.model.User" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userId = request.getParameter("userId");

    // 회원 정보 조회
    UserDao dao = new UserDao();
    User user = dao.userSelect(userId);

    // 상태 변경
    if (user != null) {
        String currentStatus = user.getStatus();
        String newStatus = currentStatus.equals("Y") ? "N" : "Y";
        user.setStatus(newStatus);

        int result = dao.userUpdate(user);

        if (result > 0) {
            out.println("<script>alert('상태가 변경되었습니다.'); location.href='adminDashboard.jsp';</script>");
        } else {
            out.println("<script>alert('상태 변경 실패'); history.back();</script>");
        }
    } else {
        out.println("<script>alert('사용자 정보를 찾을 수 없습니다.'); history.back();</script>");
    }
%>
