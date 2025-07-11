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
	//로그찍기위한용도
	Logger logger = LogManager.getLogger("loginProc.jsp");

	//String userId = request.getParameter("userId");
	//String userPwd = request.getParameter("userPwd");
	
	//아이디와 비밀번호를 서버에서 불러와서 String 타입에 저장
	String userId = HttpUtil.get(request, "userId");
	String userPwd = HttpUtil.get(request, "password");
	
	//로그
	logger.debug("userId: "+userId);
	logger.debug("userPwd: "+userPwd);
	
	//찍어줄 메세지와 재연결해줄url String 선언
	String msg = "";
	String redirectUrl = "";
	
	//유저객체 null 선언 / userDao 새 객체 선언
	User user = null;
	UserDao userDao = new UserDao();
	
	//아이디와 비밀번호가 모두 입력된 경우 (isEmpty가 둘 다 아닐때)
	if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd))
	{
		//우선 user객체에 userId로 검색해서 불러온 user객체를 담음(주솟값이 옴)
		user = userDao.userSelect(userId);
		
		//유저가 null값이 아닌지 체크
		if(user != null)
		{
			//비밀번호 체크
			if(StringUtil.equals(userPwd, user.getUserPwd()))		//if(userPwd.equals(user.getUserPwd()))
			{
				//상태값이 Y인지 체크
				if(StringUtil.equals(user.getStatus(), "Y"))		//if(user.getStatus().equals("Y"))
				{
					//쿠키적용(쿠키에 정보 저장)
					CookieUtil.addCookie(response, "/", "USER_ID", userId);
					
					msg="로그인 성공";
					redirectUrl = "/forTest.jsp";
				}
				else
				{
					msg = "정지된 사용자 입니다.";
					redirectUrl = "/";
				}
			}
			else
			{
				logger.debug("userPwd : " + userPwd);
				logger.debug("user.getUserPwd() : " + user.getUserPwd());
				msg = "비밀번호가 일치하지 않습니다.";
				redirectUrl = "/";
			}
		}
		else
		{
			msg = "아이디가 존재하지 않습니다.";
			redirectUrl = "/";
		}
	}
	else
	{
		//아이디나 비밀번호가 입력되지 않은 경우
		msg = "아이디나 비밀번호가 입력되지 않았습니다.";
		redirectUrl = "/";
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		alert("<%=msg%>");
		location.href = "<%=redirectUrl%>";
		<!-- location.href란 현재 페이지의 url을 의미하며, 값을 변경하면 브라우저가 해당 url로 이동함. -->
	</script>
</body>
</html>