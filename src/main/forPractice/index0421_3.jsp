<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String color = request.getParameter("color");
	
	String msg = "";
	/* 첫번째연습용
	if(color.equals("blue"))
		msg="파란색";
	else if(color.equals("red"))
		msg="빨간색";
	else if(color.equals("orange"))
		msg="오렌지";
	else
	{
		color="while";
		msg="기타색";
	}
	*/
	//두번째연습용
	if(color.equals("etc"))
		color="white";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor=<%=color%>>
	<!-- 첫번째연습용
	<h3>if~else 연습용</h3>
	<b><%=name%></b>은(는) 좋아하는 색은 <b><%=msg%></b>입니다.
	<br />
	-->
	<!-- 두번째연습용 -->
	<h3>if~else 연습용</h3>
<%
	if(color.equals("blue"))
	{
		msg = "파란색";
		out.println("<b>"+name+"</b>이 좋아하는 색은 <b>"+msg+"</b>입니다.");
%>
	<!-- <b><%=name%></b>이 좋아하는 색은 <b><%=msg%></b>입니다. -->
<%
	}
	else if(color.equals("red"))
	{
		 msg = "빨간색";
%>
	<b><%=name%></b>이 좋아하는 색은 <b><%=msg%></b>입니다.
<%
	}
	else if(color.equals("orange"))
	{
		 msg = "오렌지";
%>
	<b><%=name%></b>이 좋아하는 색은 <b><%=msg%></b>입니다.
<%
	}
	else{
		msg="기타색";
%>
	<b><%=name%></b>이 좋아하는 색은 <b><%=msg%></b>입니다.
<%
	}
%>
</body>
</html>