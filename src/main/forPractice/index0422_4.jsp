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
	현재 페이지에서 구구단 한단을 입력받아 해당 구구단을 출력하는 프로그램
	현재페이지는 입력받을 구구단(dan)으로 하며, 버튼은 '보내기' 선택시
	'index0422_5.jsp' 호출함.
	출력예)<h1>구구단: 2단</h1>
	2 * 1 = 2
	...
	2 * 9 = 18
-->
	<form name="form1" method="post" action="index0422_5.jsp">
		입력받을 구구단: <input type="number" min="1" max="9" name="number"><br />
		<input type=submit value="보내기">
		<input type=reset value="초기화"><p />
	</form>
</body>
</html>