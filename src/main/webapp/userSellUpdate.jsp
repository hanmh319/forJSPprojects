<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userId = request.getParameter("userId");

    if (userId == null || userId.trim().equals("")) {
%>
    <script>
        alert("유효하지 않은 사용자입니다.");
        history.back();
    </script>
<%
        return;
    }

    UserDao dao = new UserDao();
    User user = dao.userSelect(userId); // 기존 정보 가져오기

    if (user == null) {
%>
    <script>
        alert("사용자를 찾을 수 없습니다.");
        history.back();
    </script>
<%
        return;
    }

    // SELL 값 토글
    String newSell = user.getSell().equals("Y") ? "N" : "Y";
    user.setSell(newSell);

    // 나머지 값은 그대로 유지
    int result = dao.userUpdate(user);

    if (result > 0) {
%>
    <script>
        alert("판매자 여부가 변경되었습니다.");
        location.href = "adminDashboard.jsp";
    </script>
<%
    } else {
%>
    <script>
        alert("변경에 실패했습니다.");
        history.back();
    </script>
<%
    }
%>