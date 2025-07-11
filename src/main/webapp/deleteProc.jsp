<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "org.apache.logging.log4j.LogManager" %>
<%@ page import = "org.apache.logging.log4j.Logger" %>
<%@ page import = "com.sist.common.util.StringUtil" %>
<%@ page import = "com.sist.web.util.HttpUtil" %>
<%@ page import = "com.sist.web.util.CookieUtil" %>
<%@ page import = "com.sist.web.dao.BoardDao" %>
<%@ page import = "com.sist.web.model.Board" %>

<%
	Logger logger = LogManager.getLogger("/board/delete.jsp");
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	long bbsSeq =HttpUtil.get(request, "bbsSeq", (long)0);
	
	String errorMessage = "";
	boolean bSuccess = false;
	
	
	if(bbsSeq > 0)
	{
		BoardDao boardDao = new BoardDao();
		Board board = boardDao.boardSelect(bbsSeq);
		
		
		if(board != null)
		{
			
			if(StringUtil.equals(cookieUserId, board.getUserId())){
				if(boardDao.boardDelete(bbsSeq) > 0)
				{
					
					bSuccess = true;
				}
				else
				{
					errorMessage = "게시물 삭제 중 오류가 발생하였습니다.";
				}
			}
			else
			{
				errorMessage = "사용자가 작성한 게시글이 아닙니다.";
			}
		}
		else
		{
			errorMessage = "존재하지 않는 게시글입니다.";
		}
		
	}
	else
	{
		errorMessage = "게시물 번호가 올바르지 않습니다.";
	}

%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(document).ready(function(){
		<%
			if(bSuccess == true)
			{
		%>
			alert("게시물이 삭제 되었습니다.");
		<%
			}
			else
			{
		%>
			alert("<%=errorMessage%>");
		<%
			}
		%>
		
		location.href = "/forTest.jsp";
	});
</script>
</head>
<body>

</body>
</html>