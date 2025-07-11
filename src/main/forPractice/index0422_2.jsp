<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--
	출력형태는(table border=1)
	<h2>메모장</h2>
	이름 홍길동
	메모 연초모임
	날짜 현재시간(Date.toLocaleString())
-->
	<h2>메모장</h2>
	<form name="form1" method="post" action="index0422_3.jsp">
		이름: <input type="text" name="name"><br />
		메모: <input type="text" name="memo" size=40><br />
		<input type=submit value="입력">
		<input type=reset value="초기화"><p />
	</form>
</body>
</html>