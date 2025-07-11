<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.dao.NoticeDao" %>
<%@ page import="com.sist.web.model.Notice" %>

<%
    Logger logger = LogManager.getLogger("/noticeUpdateProc.jsp");

    // 파라미터로 수정할 공지사항 정보 받기
    long notiNum = HttpUtil.get(request, "notiNum", (long) 0);
    String notiTitle = request.getParameter("notiTitle");
    String notiContent = request.getParameter("notiContent");

    // 값이 없으면 오류 처리
    if (notiTitle == null || notiContent == null || notiTitle.isEmpty() || notiContent.isEmpty()) {
        out.println("<script>alert('제목과 내용을 모두 입력해 주세요.'); history.back();</script>");
        return;
    }

    // 수정할 공지사항 객체 생성
    Notice notice = new Notice();
    notice.setNotiNum(notiNum);
    notice.setNotiTitle(notiTitle);
    notice.setNotiContent(notiContent);

    // NoticeDao를 이용해 공지사항 수정
    NoticeDao noticeDao = new NoticeDao();
    int result = noticeDao.noticeUpdate(notice);

    if (result > 0) {
        logger.debug("공지사항 수정 성공. NOTI_NUM: " + notiNum);
        out.println("<script>alert('공지사항이 성공적으로 수정되었습니다.'); location.href='/noticeView.jsp?notiNum=" + notiNum + "';</script>");
    } else {
        logger.error("공지사항 수정 실패. NOTI_NUM: " + notiNum);
        out.println("<script>alert('공지사항 수정에 실패하였습니다.'); history.back();</script>");
    }
%>
