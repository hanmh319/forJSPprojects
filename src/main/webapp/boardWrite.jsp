<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>

<%
	Logger logger = LogManager.getLogger("/boardWrite.jsp");
	HttpUtil.requestLogString(request, logger);
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	UserDao userDao = new UserDao();
	User user = userDao.userSelect(cookieUserId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
	body {
		background-color: #f8f9fa;
	}

	.card {
		margin-top: 50px;
		border-radius: 1rem;
		box-shadow: 0 0 15px rgba(0,0,0,0.1);
	}

	.form-control {
		border-radius: 0.5rem;
	}

	.btn {
		width: 100px;
		margin-right: 10px;
	}
</style>

<script>
$(document).ready(function(){
	$("#bbsTitle").focus();
	
	$("#btnWrite").on("click", function(){
		if($.trim($("#bbsTitle").val()).length <= 0) {
			alert("제목을 입력하세요.");
			$("#bbsTitle").val("").focus();
			return;
		}
		
		if($.trim($("#bbsContent").val()).length <= 0) {
			alert("내용을 입력하세요.");
			$("#bbsContent").val("").focus();
			return;
		}
		
		document.writeForm.submit();
	});

	$("#btnList").on("click", function() {
		location.href = "/forTest.jsp";
	});
});	
</script>
</head>

<body>
<div class="container">
	<div class="card">
		<div class="card-body">
			<h3 class="card-title text-center mb-4">게시물 작성</h3>
			<!-- https://velog.io/@shin6403/HTTP-multipartform-data-%EB%9E%80 (이미지파일전송에대한 설명) -->
			<form name="writeForm" id="writeForm" action="/writeProc.jsp" method="post" enctype="multipart/form-data"> 
				<div class="form-group">
				  <label for="bbsImage">이미지 첨부</label>
				  <input type="file" class="form-control-file" name="bbsImage" id="bbsImage" accept="image/*">
				</div>
				<!-- 실제 서버로 전송될 값 -->
				<input type="hidden" name="bbsId" value="<%=user.getUserId()%>">
				
				<!-- 사용자 보기용 (readonly는 전송이 보장되지 않음) -->
				<input type="text" name="bbsId_display" class="form-control" value="<%=user.getUserId()%>" readonly>
				
				
				<div class="form-group">
					<label for="bbsTitle">제목</label>
					<input type="text" name="bbsTitle" id="bbsTitle" class="form-control" maxlength="100" placeholder="제목을 입력해주세요." required>
				</div>
				
				<div class="form-group">
					<label for="bbsContent">내용</label>
					<textarea class="form-control" name="bbsContent" id="bbsContent" rows="10" placeholder="내용을 입력해주세요." required></textarea>
				</div>
				
				<div class="text-right">
					<button type="button" id="btnWrite" class="btn btn-primary">저장</button>
					<button type="button" id="btnList" class="btn btn-secondary">리스트</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>
