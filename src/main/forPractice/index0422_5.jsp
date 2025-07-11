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
	int number = Integer.parseInt(request.getParameter("number"));
	out.println("<h3>"+number+"단</h3>");
	for(int i=1; i<=9; i++){
		out.println(number+"*"+i+"="+number*i+"<br />");
	}
%>
</body>
</html>