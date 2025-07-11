<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.util.HttpUtil" %>

<%
	Logger logger = LogManager.getLogger("loginOut.jsp");

	HttpUtil.requestLogString(request, logger);
	
	//쿠키가 있을 경우에 삭제
	if(CookieUtil.getCookie(request,"USER_ID") != null)
	{
		CookieUtil.deleteCookie(request, response, "/", "USER_ID");
	}
	
	response.sendRedirect("/");	//클라이언트에서 다시 바로 리퀘스트 보냄
%>