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
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String memo = request.getParameter("memo");
	
	java.util.Date date = new java.util.Date();
%>
	<h2>메모장</h2>
	<table border="1">
		<tr>
			<td>이름</td>
			<td><%=name%></td>
		</tr>
		<tr>
			<td>메모</td>
			<td><%=memo%></td>
		</tr>
		<tr>
			<td>날짜</td>
			<td><%=date.toLocaleString()%></td>
		</tr>
	</table>
</body>
</html>