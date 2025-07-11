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
		request 내부 객체로 클라이언트 정보 제공 메서드
		getMethod(): 요청에 사용된 방식
		getRequestURI(): 요청에 대한 URL로부터 URI를 반환함.
		getQueryString(): 요청에 사용된 query 문장 반환.
		getRemoteHost(): 클라이언트 호스트 이름
		getRemoteAddr(): 클라이언트 주소
		getProtocol(): 사용중인 프로토콜
		getServerName(): 서버 도메인 이름
		getServerPort(): 서버의 주소를 반환(리턴이 int)
		getHeader(): http요청 헤더에 지정된 name값
	-->
	<%
		String protocol = request.getProtocol();
		String serverName = request.getServerName();
		int serverPort = request.getServerPort();
		String remoteAdd = request.getRemoteAddr();
		String remoteHost = request.getRemoteHost();
		String method = request.getMethod();
		StringBuffer requestURL = request.getRequestURL();
		String requestURI = request.getRequestURI();
		String userBrowser = request.getHeader("User-Agent");
	%>
	
	<h1>request 내부 객체</h1><br />
	프로토콜: <%=protocol%><br />
	서버이름: <%=serverName%><br />
	서버포트: <%=serverPort%><br />
	사용자 컴퓨터 주소: <%=remoteAdd%><br />
	사용자 컴퓨터 이름: <%=remoteHost%><br />
	사용 메서드: <%=method%><br />
	요청 경로(URL): <%=requestURL%><br />
	요청 경로(URI): <%=requestURI%><br />
	현재 사용 브라우저: <%=userBrowser%><br />
	
	<!-- response 객체 메서드 -->
	<!--
		setHeader(name, value): 응답 헤더에 설정
		setContentType(type): 출력페이지의 contentType 설정
		getCharacterEncoding(): 현재 페이지의 인코딩 방식 조회
		sendRedirect(url): 지정된 url로 요청을 다시 보냄
	-->
	<%
		response.sendRedirect("index0421_6.jsp");
	%>
</body>
</html>