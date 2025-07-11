<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int coffee = Integer.parseInt(request.getParameter("coffee"));
	int su = Integer.parseInt(request.getParameter("su"));
	int money = Integer.parseInt(request.getParameter("money"));
	
	//계산처리
	String menu = "";	//메뉴명
	int dan = 0;		//개당 단가
	int total = 0;		//총금액(dan * su)
	int change = 0;		//거스름돈(money-total)
	
	//메뉴에 따른 메뉴명과 가격 설정
	switch(coffee){
	case 1:
		menu = "아메리카노";
		dan = 3000;
		break;
	case 2:
		menu = "카페라떼";
		dan = 3300;
		break;
	case 3:
		menu = "에스프레소";
		dan = 2500;
		break;
	case 4:
		menu = "얼그레이티";
		dan = 3500;
		break;
	}
	
	//총금액과 거스름돈 계산
	total = dan * su;
	change = money - total;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h2>주문계산 결과</h2>
	<ul>
		<li>커피종류: <%=menu%></li>
		<li>1개당 단가: <%=dan%></li>
		<li>수량: <%=su%></li>
		<li>총금액: <%=total%></li>
		<li>입금액: <%=money%></li>
		<li>거스름돈: <%=change%></li>
	</ul>
</body>
</html>