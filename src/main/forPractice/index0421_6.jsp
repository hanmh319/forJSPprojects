<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 구구단을 2단부터 9단까지 출력 -->
	<!-- 
		출력예)
		2단
		2 * 1 = 2
		...
		
		3단
		3 * 1 = 3
		...
	-->
	
<%
	for(int i=2;i<10;i++){
		out.println(i+"단"+"<br />");
		for(int j=1;j<10;j++){
			out.println(i+"*"+j+"="+i*j+"<br />");
		}
		out.println("<br />");
	}
%>
	
	<!-- 강사님코드 -->
	<h1>jsp 구구단 출력</h1>
<%
	int i, j;
	for(i=2;i<=9;i++)
	{
%>
		<%=i+"단<br />"%>
<%
		for(j=1;j<=9;j++)
		{
%>
			<%=i+"*"+j+"="+(i*j)%>
			<br />
<%	
		}
		out.println("<br />");
	}
%>

</body>
</html>