<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%
	boolean connection = false;
	Connection conn = null;
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	
	try
	{
		Class.forName(driver);		//괄호안에 oracle.jdbc.driver.OracleDriver 적어도 됨
		conn = DriverManager.getConnection(url, "c##sistuser", "1234"); //url 자리에 jdbc:oracle:thin:@localhost:1521:xe 적어도 됨
		connection = true;
		System.out.println("DB연결 성공");
	}
	catch(Exception e)
	{
		connection = false;
		System.out.println("DB연결 실패");
		e.printStackTrace();
	}
	finally
	{
		if(conn != null)
			conn.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(connection == true)
	{
		out.println("<h1>DB에 연결되었습니다.</h1>");
	}
	else
	{
		out.println("<h1>DB연결에 실패하였습니다.</h1>");
	}
%>
</body>
</html>