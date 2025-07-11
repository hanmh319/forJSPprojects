<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>

<%
	String userId = HttpUtil.get(request, "userId");
	String userPwd = HttpUtil.get(request, "password" );
	String userPwd2 = HttpUtil.get(request, "passwordRepeat" );
	String userEmail = HttpUtil.get(request, "email" );
	String userName = HttpUtil.get(request, "userName");
	System.out.println(userId + " " + userPwd + " " + userPwd2 + " "  +userEmail + " " + userName);
	
%>
<%
if (userId == null || userId.trim().equals("") ||
	userPwd == null || userPwd.trim().equals("") ||
	userName == null || userName.trim().equals("") ||
	userEmail == null || userEmail.trim().equals("")||
	userPwd2 == null || userPwd2.trim().equals("")) {
%>
<%
return;
}

if (!userPwd.equals(userPwd2)) {
%>
<script>
    alert("비밀번호가 일치하지 않습니다.");
    history.back();
</script>
<%
return;
}
%>

<%

// 이메일 정규표현식 확인, 아이디 중복 확인

User user = new User();
user.setUserId(userId);
user.setUserPwd(userPwd);
user.setUserEmail(userEmail);
user.setUserName(userName);
user.setStatus("Y");
user.setSell("N");

UserDao userDao = new UserDao();
int result = userDao.userInsert(user);

if (result == 1) {
%>
	<script>
	alert("회원가입이 완료되었습니다.");
	location.href = "/forTest.jsp";
	</script>
<%
} else {
%>
	<script>
	alert("회원가입에 실패했습니다. 다시 시도해주세요.");
	history.back();
	</script>
<%
}
%>

