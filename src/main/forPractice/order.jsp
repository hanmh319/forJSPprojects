<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피주문</title>
</head>
<body>
	<h1>커피메뉴</h1>
	<form name="form1" method="post" action="result.jsp">
		<input type=radio name=coffee value="1">아메리카노(3000원)<br />
		<input type=radio name=coffee value="2">카페라떼(3300원)<br />
		<input type=radio name=coffee value="3">에스프레소(2500원)<br />
		<input type=radio name=coffee value="4">얼그레이티(3500원)<br />
		수량: <input type=text name=su size="3"><br />
		입금액: <input type=text name=money size=20>
		<input type=submit value="주문처리" />
	</form>
</body>
</html>