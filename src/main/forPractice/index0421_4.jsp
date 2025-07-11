<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>for문 연습용</h3>
	<!-- 1~10까지의 합 => 1 + 2 + ... + 10 = 55 -->
	<b>1부터 10까지의 합은 </b><p />
	<%
		int i, sum=0;
	
		for(i=1;i<=10;i++)
		{
			if(i<10)
			{
	%>
		<%=i + " + " %>
	<%
			}
			else
			{
				out.println(i+"=");
			}
			sum+=i;
		}
	%>
	
	<%=sum%>
	<br /><br />
	
	<!-- 결과로 반복문장을 반복횟수만큼 출력하며 글자는 진하게<b> 표현 -->
	<h3>while문 연습용</h3>
	<form name="form1" method="post" action="index0421_5.jsp">
		반복하고싶은 문장:<input type="text" name="msg" size="20"><p />
		반복하고싶은 횟수:<input type="text" name="number" size="20"><p />
		<input type=submit value="보내기">
	</form>
</body>
</html>