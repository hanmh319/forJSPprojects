<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.dao.NoticeDao" %>
<%@ page import="com.sist.web.model.Notice" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>

<%
    Logger logger = LogManager.getLogger("/noticeDelete.jsp");

    long notiNum = HttpUtil.get(request, "notiNum", (long) 0);
    NoticeDao noticeDao = new NoticeDao();

    // 공지사항 삭제 처리
    int result = noticeDao.noticeDelete(notiNum);

    if (result > 0) {
        // 삭제 성공 시 목록 페이지로 리디렉션
        logger.debug("공지사항 삭제 성공: " + notiNum);
%>
        <script>
            alert("공지사항이 삭제되었습니다.");
            location.href = "/noticeList.jsp"; // 공지사항 목록 페이지로 이동
        </script>
<%
    } else {
        // 삭제 실패 시 오류 메시지 출력
        logger.debug("공지사항 삭제 실패: " + notiNum);
%>
        <script>
            alert("공지사항 삭제에 실패했습니다.");
            history.back(); // 이전 페이지로 돌아가기
        </script>
<%
    }
%>
