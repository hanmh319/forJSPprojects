<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.URLEncoder" %>
<%@ page import="com.sist.web.model.Notice" %>
<%@ page import="com.sist.web.dao.NoticeDao" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%
    String adminId = CookieUtil.getValue(request, "ADMIN_ID");
    String loginUserId = CookieUtil.getValue(request, "USER_ID");
    NoticeDao dao = new NoticeDao();
    List<Notice> noticeList = dao.noticeList(new Notice());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
   
    <script>
      $(document).ready(function () {
        $('#loginModal').on('show.bs.modal', function () {
          $('#loginModalContent').load('/loginForm.jsp');
        });
      });
    </script>
    <style>
        /* 공지사항 리스트 테이블 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        th, td {
            border-bottom: 1px solid #ddd;
            padding: 0.75rem 1rem;
            text-align: left;
        }
        th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        tr:hover {
            background-color: #f1f3f5;
        }
        .title-cell a {
            text-decoration: none;
            color: #212529;
        }
        .title-cell a:hover {
            color: #0d6efd;
            text-decoration: underline;
        }
        .btn-write {
            background-color: #0d6efd;
            color: white;
            border: none;
            padding: 0.4rem 0.8rem;
            margin-right: 0.5rem;
            border-radius: 0.25rem;
            cursor: pointer;
        }
        .btn-write:hover {
            background-color: #0b5ed7;
        }
        .btn-logout {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 0.25rem;
            cursor: pointer;
        }
        .btn-logout:hover {
            background-color: #bb2d3b;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<%
    // 네비게이션 바 통일
    if (loginUserId == null || loginUserId.isEmpty()) {
%>
<nav class="py-2 bg-body-tertiary border-bottom">
  <div class="container d-flex flex-wrap">
    <ul class="nav me-auto">
      <li class="nav-item"><a href="/" class="nav-link px-2 active">홈</a></li>
      <li class="nav-item"><a href="/noticeList.jsp" class="nav-link px-2">공지사항</a></li>
      <li class="nav-item"><a href="/userUpdateForm.jsp" class="nav-link px-2">회원정보수정</a></li>
    </ul>
    <form action="forTest.jsp" method="post" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
      <div class="input-group">
        <input type="text" name="searchKeyword" class="form-control" placeholder="검색어를 입력하세요"
               value="<%= request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "" %>">
        <button type="submit" class="btn btn-primary">검색</button>
      </div>
    </form>
    <ul class="nav">
      <li class="nav-item">
        <a href="#" class="nav-link px-2" data-bs-toggle="modal" data-bs-target="#loginModal">로그인</a>
      </li>
    </ul>
  </div>
</nav>
<%
    } else {
%>
<nav class="py-2 bg-body-tertiary border-bottom">
  <div class="container d-flex flex-wrap">
    <ul class="nav me-auto">
      <li class="nav-item"><a href="/" class="nav-link px-2 active">홈</a></li>
      <li class="nav-item"><a href="/noticeList.jsp" class="nav-link px-2">공지사항</a></li>
      <li class="nav-item"><a href="/userUpdateForm.jsp" class="nav-link px-2">회원정보수정</a></li>
    </ul>
    <form action="forTest.jsp" method="post" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
      <div class="input-group">
        <input type="text" name="searchKeyword" class="form-control" placeholder="검색어를 입력하세요"
               value="<%= request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "" %>">
        <button type="submit" class="btn btn-primary">검색</button>
      </div>
    </form>
    <ul class="nav">
      <li class="nav-item">
        <a href="logOut.jsp" class="nav-link px-2">로그아웃</a>
      </li>
    </ul>
  </div>
</nav>
<%
    }
%>

<div class="container">

    <div class="header">
        <h2>공지사항</h2>
        <% if (adminId != null && !adminId.isEmpty()) { %>
        <div class="btn-group">
            <a href="noticeWrite.jsp"><button class="btn-write">공지 등록</button></a>
            <a href="adminLogOut.jsp"><button class="btn-write">로그아웃</button></a>
        </div>
        <% } else { %>
        <div class="btn-group">
            <a href="adminLoginForm.jsp"><button class="btn-write">관리자로그인</button></a>
        </div>
        <% } %>
    </div>

    <table>
        <thead>
            <tr>
                <th style="width: 100px;">번호</th>
                <th>제목</th>
                <th style="width: 120px;">작성자</th>
                <th style="width: 80px;">조회수</th>
                <th style="width: 140px;">등록일</th>
            </tr>
        </thead>
        <tbody>
            <% for (Notice n : noticeList) { %>
            <tr>
                <td><%= n.getNotiNum() %></td>
                <td class="title-cell">
                    <a href="noticeView.jsp?notiNum=<%= n.getNotiNum() %>"><%= n.getNotiTitle() %></a>
                </td>
                <td><%= n.getAdminId() %></td>
                <td><%= n.getNotiReadCnt() %></td>
                <td><%= n.getNotiRegDate() %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<!-- 로그인 모달 -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body" id="loginModalContent">
        <!-- 로그인 폼이 여기 로드됩니다 -->
      </div>
    </div>
  </div>
</div>
</body>
</html>
