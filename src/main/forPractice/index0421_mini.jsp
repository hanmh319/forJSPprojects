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
	String coffee = request.getParameter("coffee");
	int price = 0;
	String menu = "";
	if (coffee.equals("1")){
		price = 3000;
		menu = "아메리카노";
	}
	else if (coffee.equals("2")){
		price = 3300;
		menu = "카페라떼";
	}
	else if (coffee.equals("3")){
		price = 2500;
		menu = "에스프레소";
	}
	else if (coffee.equals("4")){
		price = 3500;
		menu = "얼그레이티";
	}
	
	int count = Integer.parseInt(request.getParameter("count"));
	int money = Integer.parseInt(request.getParameter("money"));
	
	int total = price*count;
%>
<h1>주문계산 결과</h1>
<ul>
	<li>커피종류: <%=coffee%></li>
	<li>1개 가격: <%=price%></li>
	<li>수량: <%=count%></li>
	<li>총 금액: <%=total%></li>
	<li>입금액: <%=money%></li>
	<li>거스름돈: <%=money - total%></li>
</ul>
</body>
</html>