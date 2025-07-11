<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//while문 사용하여 적용
	request.setCharacterEncoding("UTF-8");

	String msg = request.getParameter("msg");
	int number = Integer.parseInt(request.getParameter("number"));
	
	int cnt = 1;
	
	while(cnt <= number)
	{
%>
	<b><%=msg%></b><br />
<%
	cnt++;
	}
%>
</body>
</html>