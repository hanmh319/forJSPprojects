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
	String num = request.getParameter("num");
	String gender = request.getParameter("gender");
	String major = request.getParameter("major");
	out.println("<h1>학생정보</h1>");
	out.println("이름: "+name);
	out.println("학번: "+num);
	out.println("성별: "+gender);
	out.println("전공: "+major);

%>
	<!-- 강사님코드 -->
	<h1>request 사용예제</h1>
<%
	request.setCharacterEncoding("UTF-8");

	String name1 = request.getParameter("name1");
	String num1 = request.getParameter("num1");
	String gender1 = request.getParameter("gender1");
	String major1 = request.getParameter("major1");
	
	String msg;
	
	if(gender.equals("man"))
		msg = "남자";
	else
		msg = "여자";
%>

이름: <%=name1%><br />
학번: <%=num1%><br />
성별: <%=msg%><br />
전공: <%=major1%><br />

</body>
</html>