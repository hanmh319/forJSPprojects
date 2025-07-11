<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.dao.AdminDao" %>
<%@ page import="com.sist.web.model.Admin" %>
<%
	
		Logger logger = LogManager.getLogger("/adminLoginProc.jsp");
		
		String adminId = request.getParameter("adminId");
		String adminPwd = request.getParameter("adminPwd");
		
		AdminDao adminDao = new AdminDao();
		Admin admin = adminDao.adminSelect(adminId);

    if (admin != null && StringUtil.equals(admin.getAdminPwd(), adminPwd)) {
        // 로그인 성공
        logger.debug("로그인 성공: " + adminId);
        
        // 쿠키로 로그인 정보 저장
        CookieUtil.addCookie(response, "/", "ADMIN_ID", adminId);
        CookieUtil.deleteCookie(request, response, "/", "USER_ID");
    %>
    <script>
	location.href ="/";
    </script>
    
    <%
    } else {
        // 로그인 실패
        logger.debug("로그인 실패: " + adminId);
        out.println("<script>alert('아이디 또는 비밀번호가 잘못되었습니다.'); window.location.href='adminLogin.jsp';</script>");
    }
%>