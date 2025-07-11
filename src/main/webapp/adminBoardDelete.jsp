<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sist.web.dao.BoardDao" %>

<%
    long tbNum = Long.parseLong(request.getParameter("tbNum"));
    BoardDao dao = new BoardDao();
    int result = dao.boardDelete(tbNum);

    response.setContentType("text/html; charset=UTF-8");
  

    if (result > 0) {
        out.println("<script>");
        out.println("alert('삭제되었습니다.');");
        out.println("location.href='adminDashboard.jsp';");
        out.println("</script>");
    } else {
        out.println("<script>");
        out.println("alert('삭제 실패.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>