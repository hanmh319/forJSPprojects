<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp 실습</title>
</head>
<body>
	<%!
		int a;
		String msgA;
	%>
	<%
		int b = 30;
		String msgB = "jsp sample";
	%>
	<%=b+":"+msgB%>
	<h2>표현식 sample</h2>
	<%!
		String name[] = {"java","jsp","html","javascript"};
	%>
	<table border="1" width="200">
	<%
		for(int i=0;i<name.length;i++){
			
		
	%>
		<tr>
			<td><%=i+1%></td>
			<td><%=name[i]%></td>
		</tr>
	<%
		}
	%>
	</table>
	<h3>현재경로:<%=application.getRealPath("/")%></h3>
	<br /><br />
	<h3]>jsp sample2</h3>
	<%
		java.util.Date date = new java.util.Date();
		int hour = date.getHours();
		
		int aa = 10;
		int bb = 15;
	%>
	<%!
		public int operation(int a, int b){
		return a>b?a:b;
	}
	%>
	지금은 오전인지 오후인지 알려주세요? <%=(hour<12)?"오전":"오후" %>
	<br />
	aa와 bb중 큰값을 출력: <%= operation(aa,bb) %>
	<!-- html 주석이고 브라우저에서 보이는 주석 -->
	<%--jsp 에서만 보이고 브라우저 '소스보기'에서는 보이지 않는 주석--%>
	<!-- <%=msgB%> teml 주석으로 브라우저에서 msgB값이 보이는 주석 -->
	<%=msgB/*소스보기에서 안보임*/ %><br/>
</body>
</html>