<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.sist.web.dao.UserDao, com.sist.web.model.User" %>
<%@ page import="com.sist.web.dao.NoticeDao, com.sist.web.model.Notice" %>
<%@ page import="com.sist.web.dao.BoardDao, com.sist.web.model.Board" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%
    String adminId = CookieUtil.getValue(request, "ADMIN_ID");
    if (adminId == "") {
        out.println("<script>alert('관리자 로그인 후 이용 가능합니다.'); location.href='adminLoginForm.jsp';</script>");
        return;
    }

    // DAO 호출
    UserDao userDao = new UserDao();
    List<User> userList = userDao.userList();

    NoticeDao noticeDao = new NoticeDao();
    List<Notice> noticeList = noticeDao.noticeList(null);

    BoardDao boardDao = new BoardDao();
    List<Board> boardList = boardDao.boardListForAdmin();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 30px;
            background-color: #f9f9f9;
        }
        h2 {
            margin-top: 40px;
            margin-bottom: 10px;
        }
        .section {
            background: white;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }
        .table-wrapper {
            max-height: 300px;
            overflow-y: auto;
            border: 1px solid #ddd;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            position: sticky;
            top: 0;
        }
        .btn {
            padding: 5px 10px;
            margin: 0 2px;
            font-size: 12px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
        }
        .edit { background-color: #4CAF50; color: white; }
        .delete { background-color: #f44336; color: white; }
        .toggle { background-color: #2196F3; color: white; }
        .section-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
	   <div style="position: fixed; top: 20px; right: 30px; z-index: 999;">
        <form action="/forTest.jsp" method="get">
            <button class="btn" style="background-color: #555; color: white;">일반 페이지로</button>
        </form>
         <form action="adminLogOut.jsp" method="post">
        <button class="btn" style="background-color: #f44336; color: white;">관리자 로그아웃</button>
    </form>
    </div>
    <h1>관리자 대시보드</h1>
	
    <!-- 회원 목록 -->
    <div class="section">
        <div class="section-title">
            <h2>회원 정보</h2>
        </div>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>상태</th>
                    <th>판매자여부</th>
                    <th>관리</th>
                </tr>
                <% for (User u : userList) { %>
                <tr>
    <td><%= u.getUserId() %></td>
    <td><%= u.getUserName() %></td>
    <td><%= u.getUserEmail() %></td>
    <td><%= u.getStatus() %></td>
    <td> <%= u.getSell() %></td>
    <td>
        <form action="userUpdateForAdmin.jsp" method="post" style="display:inline;">
            <input type="hidden" name="userId" value="<%= u.getUserId() %>"/>
            <button class="btn toggle" type="submit">상태변경</button>
        </form>
        <form action="userDelete.jsp" method="post" style="display:inline;">
            <input type="hidden" name="userId" value="<%= u.getUserId() %>"/>
            <button class="btn delete" type="submit">삭제</button>
        </form>
        <form action="userSellUpdate.jsp" method="post" style="display:inline;">
            <input type="hidden" name="userId" value="<%= u.getUserId() %>"/>
            <button class="btn toggle" type="submit">판매자여부변경</button>
        </form>
    </td>

</tr>
                <% } %>
            </table>
        </div>
    </div>

    <!-- 공지사항 목록 -->
    <div class="section">
        <div class="section-title">
            <h2>공지사항</h2>
        </div>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>날짜</th>
                    <th>관리</th>
                </tr>
                <% for (Notice n : noticeList) { %>
                <tr>
                    <td><%= n.getNotiNum() %></td>
                    <td><%= n.getNotiTitle() %></td>
                    <td><%= n.getAdminId() %></td>
                    <td><%= n.getNotiRegDate() %></td>
                    <td>
                        <a href="noticeUpdateForm.jsp?notiNum=<%=n.getNotiNum()%>">
                            <button class="btn edit">수정</button>
                        </a>
                        <form action="noticeDelete.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="notiNum" value="<%= n.getNotiNum() %>"/>
                            <button class="btn delete" type="submit">삭제</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
    </div>

    <!-- 일반게시판 목록 -->
    <div class="section">
        <div class="section-title">
            <h2>일반게시판</h2>
        </div>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>관리</th>
                </tr>
                <% for (Board b : boardList) { %>
                <tr>
                    <td><%= b.getTbNum() %></td>
                    <td><%= b.getTbTitle() %></td>
                    <td><%= b.getUserId() %></td>
                    <td><%= b.getRegDate() %></td>
                    <td>
                        <form action="adminBoardDelete.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="tbNum" value="<%= b.getTbNum() %>"/>
                            <button class="btn delete" type="submit">삭제</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
    </div>

</body>
</html>
