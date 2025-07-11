package com.sist.web.dao;

import java.sql.*;
import java.util.*;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sist.web.db.DBManager;
import com.sist.web.model.Notice;

public class NoticeDao {

    private static Logger logger = LogManager.getLogger(NoticeDao.class);

    // 공지사항 목록 조회
    public List<Notice> noticeList(Notice search) {
        List<Notice> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT NOTI_NUM, S_ADMIN_ID, NOTI_TITLE, NOTI_CONTENT, NOTI_READ_CNT, TO_CHAR(NOTI_REGDATE, 'YYYY.MM.DD') AS NOTI_REGDATE ");
        sql.append("FROM S_NOTICE ");
        sql.append("WHERE 1=1 ");

        // 검색 조건 추가
        if (search != null) {
            if (search.getNotiTitle() != null && !search.getNotiTitle().isEmpty()) {
                sql.append("AND NOTI_TITLE LIKE ? ");
            }
        }

        sql.append("ORDER BY NOTI_REGDATE DESC ");

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql.toString());

            int idx = 1;
            if (search != null && search.getNotiTitle() != null && !search.getNotiTitle().isEmpty()) {
                pstmt.setString(idx++, "%" + search.getNotiTitle() + "%");
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Notice notice = new Notice();
                notice.setNotiNum(rs.getLong("NOTI_NUM"));
                notice.setAdminId(rs.getString("S_ADMIN_ID"));
                notice.setNotiTitle(rs.getString("NOTI_TITLE"));
                notice.setNotiContent(rs.getString("NOTI_CONTENT"));
                notice.setNotiReadCnt(rs.getInt("NOTI_READ_CNT"));
                notice.setNotiRegDate(rs.getString("NOTI_REGDATE"));

                list.add(notice);
            }
        } catch (Exception e) {
            logger.error("[NoticeDao]noticeList SQLException", e);
        } finally {
            DBManager.close(rs, pstmt, conn);
        }

        return list;
    }

    // 공지사항 상세 조회
    public Notice noticeSelect(long notiNum) {
        Notice notice = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT NOTI_NUM, S_ADMIN_ID, NOTI_TITLE, NOTI_CONTENT, NOTI_READ_CNT, TO_CHAR(NOTI_REGDATE, 'YYYY.MM.DD') AS NOTI_REGDATE ");
        sql.append("FROM S_NOTICE ");
        sql.append("WHERE NOTI_NUM = ?");

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            pstmt.setLong(1, notiNum);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                notice = new Notice();
                notice.setNotiNum(rs.getLong("NOTI_NUM"));
                notice.setAdminId(rs.getString("S_ADMIN_ID"));
                notice.setNotiTitle(rs.getString("NOTI_TITLE"));
                notice.setNotiContent(rs.getString("NOTI_CONTENT"));
                notice.setNotiReadCnt(rs.getInt("NOTI_READ_CNT"));
                notice.setNotiRegDate(rs.getString("NOTI_REGDATE"));
            }
        } catch (Exception e) {
            logger.error("[NoticeDao]noticeSelect SQLException", e);
        } finally {
            DBManager.close(rs, pstmt, conn);
        }

        return notice;
    }

    // 공지사항 등록
    public int noticeInsert(Notice notice) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO S_NOTICE (NOTI_NUM, S_ADMIN_ID, NOTI_TITLE, NOTI_CONTENT, NOTI_READ_CNT, NOTI_REGDATE) " +
                     "VALUES (S_NOTICE_SEQ.NEXTVAL, ?, ?, ?, 0, SYSDATE)";

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, notice.getAdminId());
            pstmt.setString(2, notice.getNotiTitle());
            pstmt.setString(3, notice.getNotiContent());

            count = pstmt.executeUpdate();
        } catch (Exception e) {
            logger.error("[NoticeDao]noticeInsert SQLException", e);
        } finally {
            DBManager.close(pstmt, conn);
        }

        return count;
    }

    // 공지사항 수정
    public int noticeUpdate(Notice notice) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE S_NOTICE SET NOTI_TITLE = ?, NOTI_CONTENT = ? WHERE NOTI_NUM = ?";

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, notice.getNotiTitle());
            pstmt.setString(2, notice.getNotiContent());
            pstmt.setLong(3, notice.getNotiNum());

            count = pstmt.executeUpdate();
        } catch (Exception e) {
            logger.error("[NoticeDao]noticeUpdate SQLException", e);
        } finally {
            DBManager.close(pstmt, conn);
        }

        return count;
    }

    // 공지사항 삭제
    public int noticeDelete(long notiNum) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM S_NOTICE WHERE NOTI_NUM = ?";

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, notiNum);

            count = pstmt.executeUpdate();
        } catch (Exception e) {
            logger.error("[NoticeDao]noticeDelete SQLException", e);
        } finally {
            DBManager.close(pstmt, conn);
        }

        return count;
    }
    
    public void noticeReadCntPlus(long notiNum) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBManager.getConnection();
            String sql = "UPDATE S_NOTICE SET NOTI_READ_CNT = NOTI_READ_CNT + 1 WHERE NOTI_NUM = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, notiNum);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBManager.close(pstmt, conn);
        }
    }
}
