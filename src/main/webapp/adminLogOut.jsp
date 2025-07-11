<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%
    // 쿠키에서 ADMIN_ID를 삭제
   	if(CookieUtil.getCookie(request,"ADMIN_ID") != null)
	{
		CookieUtil.deleteCookie(request, response, "/", "ADMIN_ID");
	}

    // 로그아웃 후 공지사항 목록 페이지로 리다이렉트
    response.sendRedirect("noticeList.jsp");
%>
