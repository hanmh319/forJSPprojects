<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sist.web.dao.AdminDao" %>
<%@ page import="com.sist.web.model.Admin" %>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>

<%
    Logger logger = LogManager.getLogger("/adminLogin.jsp");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body, html {
            height: 100%;
            background-color: #fff;
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .login-box {
            width: 360px;
            padding: 40px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            background-color: #fff;
        }
        .login-box h2 {
            margin-bottom: 30px;
            font-weight: 700;
            color: #222;
            text-align: center;
        }
        label {
            font-weight: 600;
            color: #333;
        }
        .form-control {
            border-radius: 4px;
            border: 1px solid #ccc;
            transition: border-color 0.2s ease;
        }
        .form-control:focus {
            border-color: #555;
            box-shadow: none;
        }
        .btn-primary {
            width: 100%;
            background-color: #222;
            border: none;
            padding: 10px 0;
            font-weight: 600;
            letter-spacing: 0.05em;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #444;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>관리자 로그인</h2>
        <form action="adminLoginProc.jsp" method="post" autocomplete="off">
            <div class="form-group">
                <label for="adminId">아이디</label>
                <input type="text" class="form-control" id="adminId" name="adminId" placeholder="아이디를 입력하세요" required autofocus>
            </div>
            <div class="form-group">
                <label for="adminPwd">비밀번호</label>
                <input type="password" class="form-control" id="adminPwd" name="adminPwd" placeholder="비밀번호를 입력하세요" required>
            </div>
            <button type="submit" class="btn btn-primary">로그인</button>
        </form>
    </div>
</body>
</html>
