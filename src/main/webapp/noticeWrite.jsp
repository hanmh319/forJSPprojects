<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.dao.NoticeDao" %>
<%@ page import="com.sist.web.model.Notice" %>

<%
    // 세션에서 로그인한 관리자 정보 확인
    String loginAdmin = CookieUtil.getValue(request, "ADMIN_ID");

    if (loginAdmin == null) {
        // 로그인하지 않은 사용자 → 접근 제한
%>
        <script>
            alert("관리자만 접근 가능합니다.");
            location.href = "adminLoginPage.jsp"; // 로그인 페이지로 이동
        </script>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 글쓰기</title>
    <style>
        .write-container {
            max-width: 700px;
            margin: 40px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background: #fafafa;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        textarea {
            height: 200px;
            resize: vertical;
        }

        .btn-area {
            text-align: right;
            margin-top: 20px;
        }

        button {
            padding: 10px 20px;
            border: none;
            background: #2d6cdf;
            color: white;
            border-radius: 8px;
            cursor: pointer;
        }

        button:hover {
            background: #1b4fbf;
        }
    </style>
</head>
<body>

<div class="write-container">
    <h2>공지사항 작성</h2>
    <form method="post" action="noticeWriteProc.jsp">
        <label>제목</label>
        <input type="text" name="notiTitle" required />

        <label>내용</label>
        <textarea name="notiContent" required></textarea>

        <div class="btn-area">
            <button type="submit">작성</button>
        </div>
    </form>
</div>

</body>
</html>
