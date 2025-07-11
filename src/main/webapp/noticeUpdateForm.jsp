<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.dao.NoticeDao" %>
<%@ page import="com.sist.web.model.Notice" %>

<%
    Logger logger = LogManager.getLogger("/noticeUpdateForm.jsp");

    // 공지사항 번호를 받아서 해당 공지사항을 조회
    long notiNum = HttpUtil.get(request, "notiNum", (long) 0);
    NoticeDao noticeDao = new NoticeDao();
    Notice notice = noticeDao.noticeSelect(notiNum);

    if (notice == null) {
        logger.error("공지사항이 존재하지 않습니다. 번호: " + notiNum);
        out.println("<script>alert('존재하지 않는 공지사항입니다.'); history.back();</script>");
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 수정</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
            color: #333;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-top: 5px;
        }
        .form-group textarea {
            resize: vertical;
            height: 150px;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        .button:hover {
            background-color: #45a049;
        }
        .cancel-button {
            background-color: #f44336;
            margin-top: 10px;
        }
        .cancel-button:hover {
            background-color: #e53935;
        }
        .button-container {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>공지사항 수정</h2>
        <form action="noticeUpdateProc.jsp" method="post">
            <input type="hidden" name="notiNum" value="<%= notice.getNotiNum() %>"/>
            
            <div class="form-group">
                <label for="notiTitle">제목</label>
                <input type="text" id="notiTitle" name="notiTitle" value="<%= notice.getNotiTitle() %>" required>
            </div>
            
            <div class="form-group">
                <label for="notiContent">내용</label>
                <textarea id="notiContent" name="notiContent" required><%= notice.getNotiContent() %></textarea>
            </div>
            
            <div class="button-container">
                <button type="submit" class="button">수정 완료</button>
                <button type="button" class="button cancel-button" onclick="location.href='/noticeView.jsp?notiNum=<%=notice.getNotiNum()%>'">취소</button>
            </div>
        </form>
    </div>

</body>
</html>
