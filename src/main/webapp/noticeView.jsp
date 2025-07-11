<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.dao.NoticeDao" %>
<%@ page import="com.sist.web.model.Notice" %>

<%
    Logger logger = LogManager.getLogger("/notice/view.jsp");

    String cookieAdminId = CookieUtil.getValue(request, "ADMIN_ID");
    
    long notiNum = HttpUtil.get(request, "notiNum", (long)0);
    String searchType = HttpUtil.get(request, "searchType", "");
    String searchValue = HttpUtil.get(request, "searchValue", "");
    long curPage = HttpUtil.get(request, "curPage", (long)1);
    
    String gubun = HttpUtil.get(request, "gubun", "N");
    
    logger.debug("===============");
    logger.debug("view.jsp notiNum : " + notiNum);
    logger.debug("===============");

    NoticeDao noticeDao = new NoticeDao();
    Notice notice = noticeDao.noticeSelect(notiNum);

    // ADMIN_ID와 비교하여 조회수 증가
    if(notice != null && !StringUtil.equals(cookieAdminId, notice.getAdminId())) {
        noticeDao.noticeReadCntPlus(notiNum);
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항 보기</title>

<!-- Bootstrap CSS 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
$(document).ready(function(){
    
<% 
    if(notice == null) { %>
        alert("조회 하신 공지사항이 존재하지 않습니다.");
        document.noticeForm.action = "/noticeList.jsp";
        document.noticeForm.submit();
<% }
    else {
%>

    $("#btnList").on("click", function(){
        document.noticeForm.action = "/noticeList.jsp";
        document.noticeForm.submit();
    });
<%
        if(StringUtil.equals(cookieAdminId, notice.getAdminId())) {
%>

    $("#btnUpdate").on("click", function(){
        document.noticeForm.action = "/noticeUpdateForm.jsp";
        document.noticeForm.submit();
    });

    $("#btnDelete").on("click", function(){
        if(confirm("공지사항을 삭제 하시겠습니까?") == true) {
            document.noticeForm.action = "/noticeDelete.jsp";
            document.noticeForm.submit();
        }
    });
<%
        }
    }
%>
});
</script>
</head>
<body>

<% 
    if(notice != null) {
%>

<!-- card 디자인 대신 깔끔한 테이블 박스로 변경 -->
<div class="container mt-5" style="max-width: 800px;">
    <h4 class="mb-4 text-center">공지사항</h4>

    <table class="table table-bordered bg-white">
        <tr>
            <th style="width: 100px;">제목</th>
            <td><strong><%= notice.getNotiTitle() %></strong></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td><%= notice.getAdminId() %></td>
        </tr>
        <tr>
            <th>작성일</th>
            <td><%= notice.getNotiRegDate() %></td>
        </tr>
        <tr>
            <th>조회수</th>
            <td><%= StringUtil.toNumberFormat(notice.getNotiReadCnt()) %></td>
        </tr>
        <tr>
            <th>내용</th>
            <td style="height: 300px;">
                <div style="white-space: pre-wrap;"><%= StringUtil.replace(notice.getNotiContent(), "\n", "<br />") %></div>
            </td>
        </tr>
    </table>

    <div class="text-right mt-3">
        <button type="button" id="btnList" class="btn btn-outline-secondary btn-sm">목록</button>
        <% if (StringUtil.equals(cookieAdminId, notice.getAdminId())) { %>
            <button type="button" id="btnUpdate" class="btn btn-outline-primary btn-sm">수정</button>
            <button type="button" id="btnDelete" class="btn btn-outline-danger btn-sm">삭제</button>
        <% } %>
    </div>
</div>


<%
    }
%>

<form name="noticeForm" method="post">
    <input type="hidden" name="notiNum" value="<%= notiNum %>"/>
    <input type="hidden" name="searchType" value="<%= searchType %>"/>
    <input type="hidden" name="searchValue" value="<%= searchValue %>"/>
    <input type="hidden" name="curPage" value="<%= curPage %>"/>
</form>

<!-- Bootstrap JS, Popper.js 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
