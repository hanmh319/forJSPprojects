package com.sist.web.dao;

import java.sql.*;
import java.util.*;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sist.web.db.DBManager;
import com.sist.web.model.Board;

public class BoardDao {

    private static Logger logger = LogManager.getLogger(BoardDao.class);

    public List<Board> boardList(Board search) {
        List<Board> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT TB_NUM, S_USER_ID, TB_TITLE, TB_CONTENT, TB_READ_CNT, TB_REGDATE, IMAGE_PATH, S_PRICE ");
        sql.append("FROM ( ");
        sql.append("  SELECT ROWNUM AS RNUM, TB_NUM, S_USER_ID, NVL(TB_TITLE, '') AS TB_TITLE, ");
        sql.append("         NVL(TB_CONTENT, '') AS TB_CONTENT, NVL(TB_READ_CNT, 0) AS TB_READ_CNT, ");
        sql.append("         TO_CHAR(TB_REGDATE, 'YYYY.MM.DD HH24:MI:SS') AS TB_REGDATE, IMAGE_PATH, S_PRICE ");
        sql.append("  FROM ( ");
        sql.append("    SELECT A.TB_NUM, A.S_USER_ID, A.TB_TITLE, A.TB_CONTENT, A.TB_READ_CNT, ");
        sql.append("           A.TB_REGDATE, A.IMAGE_PATH, A.S_PRICE ");
        sql.append("    FROM S_BOARD A ");
        sql.append("    JOIN S_USER B ON A.S_USER_ID = B.S_USER_ID ");
        if (search != null) {
            if ((search.getTbTitle() != null && !search.getTbTitle().isEmpty()) ||
                (search.getTbContent() != null && !search.getTbContent().isEmpty())) {
                sql.append("  WHERE A.TB_TITLE LIKE ? OR A.TB_CONTENT LIKE ? ");
            }
        }
        sql.append("    ORDER BY A.TB_NUM DESC ");
        sql.append("  ) ");
        sql.append(") ");
        sql.append("WHERE RNUM BETWEEN ? AND ? ");

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql.toString());

            int idx = 1;
            if (search != null) {
                if (search.getTbTitle() != null && !search.getTbTitle().isEmpty()) {
                    pstmt.setString(idx++, "%" + search.getTbTitle() + "%");
                }
                if (search.getTbContent() != null && !search.getTbContent().isEmpty()) {
                    pstmt.setString(idx++, "%" + search.getTbContent() + "%");
                }
            }

            pstmt.setLong(idx++, search.getStartRow());
            pstmt.setLong(idx++, search.getEndRow());

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Board board = new Board();
                board.setTbNum(rs.getLong("TB_NUM"));
                board.setUserId(rs.getString("S_USER_ID"));
                board.setTbTitle(rs.getString("TB_TITLE"));
                board.setTbContent(rs.getString("TB_CONTENT"));
                board.setTbReadCnt(rs.getLong("TB_READ_CNT"));
                board.setRegDate(rs.getString("TB_REGDATE"));
                board.setImagePath(rs.getString("IMAGE_PATH"));
                board.setPrice(rs.getLong("S_PRICE"));  // 🔹 추가
                list.add(board);
            }
        } catch (Exception e) {
            logger.error("[BoardDao] boardList SQLException", e);
        } finally {
            DBManager.close(rs, pstmt, conn);
        }
        return list;
    }

    public long getTotalCount(Board search) {
        long totalCount = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT COUNT(*) FROM S_BOARD A ");
        sql.append("JOIN S_USER B ON A.S_USER_ID = B.S_USER_ID ");
        if (search != null && (search.getTbTitle() != null || search.getTbContent() != null)) {
            sql.append("WHERE (A.TB_TITLE LIKE ? OR A.TB_CONTENT LIKE ?) ");
        }

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql.toString());

            if (search != null && (search.getTbTitle() != null || search.getTbContent() != null)) {
                pstmt.setString(1, "%" + (search.getTbTitle() != null ? search.getTbTitle() : "") + "%");
                pstmt.setString(2, "%" + (search.getTbContent() != null ? search.getTbContent() : "") + "%");
            }

            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getLong(1);
            }
        } catch (Exception e) {
            logger.error("[BoardDao] getTotalCount SQLException", e);
        } finally {
            DBManager.close(rs, pstmt, conn);
        }
        return totalCount;
    }

    public Board boardSelect(long seq) {
        Board board = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT A.TB_NUM, A.S_USER_ID, A.TB_TITLE, A.TB_CONTENT, A.TB_READ_CNT, ");
        sql.append("A.TB_REGDATE, A.IMAGE_PATH, A.S_PRICE ");
        sql.append("FROM S_BOARD A, S_USER B ");
        sql.append("WHERE A.S_USER_ID = B.S_USER_ID ");
        sql.append("AND TB_NUM = ?");

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            pstmt.setLong(1, seq);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                board = new Board();
                board.setTbNum(rs.getLong("TB_NUM"));
                board.setUserId(rs.getString("S_USER_ID"));
                board.setTbTitle(rs.getString("TB_TITLE"));
                board.setTbContent(rs.getString("TB_CONTENT"));
                board.setTbReadCnt(rs.getLong("TB_READ_CNT"));
                board.setRegDate(rs.getString("TB_REGDATE"));
                board.setImagePath(rs.getString("IMAGE_PATH"));
                board.setPrice(rs.getLong("S_PRICE"));  // 🔹 추가
            }
        } catch (Exception e) {
            logger.error("[BoardDao] boardSelect SQLException", e);
        } finally {
            DBManager.close(rs, pstmt, conn);
        }

        return board;
    }

    public int boardInsert(Board board) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        StringBuilder sql = new StringBuilder();

        sql.append("INSERT INTO S_BOARD ");
        sql.append("(TB_NUM, S_USER_ID, TB_TITLE, TB_CONTENT, TB_READ_CNT, TB_REGDATE, IMAGE_PATH, S_PRICE) ");
        sql.append("VALUES (?, ?, ?, ?, 0, SYSDATE, ?, ?)");

        try {
            int idx = 0;
            conn = DBManager.getConnection();
            long tbNum = newBbsSeq(conn);
            board.setTbNum(tbNum);

            pstmt = conn.prepareStatement(sql.toString());
            pstmt.setLong(++idx, board.getTbNum());
            pstmt.setString(++idx, board.getUserId());
            pstmt.setString(++idx, board.getTbTitle());
            pstmt.setString(++idx, board.getTbContent());
            pstmt.setString(++idx, board.getImagePath());
            pstmt.setLong(++idx, board.getPrice());  // 🔹 추가

            count = pstmt.executeUpdate();
        } catch (Exception e) {
            logger.error("[BoardDao] boardInsert SQLException", e);
        } finally {
            DBManager.close(pstmt, conn);
        }

        return count;
    }

    public int boardUpdate(Board board) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        StringBuilder sql = new StringBuilder();

        sql.append("UPDATE S_BOARD ");
        sql.append("SET TB_TITLE = ?, TB_CONTENT = ?, IMAGE_PATH = ?, S_PRICE = ? ");
        sql.append("WHERE TB_NUM = ?");

        try {
            int idx = 0;
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql.toString());

            pstmt.setString(++idx, board.getTbTitle());
            pstmt.setString(++idx, board.getTbContent());
            pstmt.setString(++idx, board.getImagePath());
            pstmt.setLong(++idx, board.getPrice());
            pstmt.setLong(++idx, board.getTbNum());

            count = pstmt.executeUpdate();
        } catch (Exception e) {
            logger.error("[BoardDao] boardUpdate SQLException", e);
        } finally {
            DBManager.close(pstmt, conn);
        }

        return count;
    }

    public int boardDelete(long bbsSeq) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        StringBuilder sql = new StringBuilder();

        sql.append("DELETE FROM S_BOARD WHERE TB_NUM = ?");

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            pstmt.setLong(1, bbsSeq);
            count = pstmt.executeUpdate();
        } catch (Exception e) {
            logger.error("[BoardDao] boardDelete SQLException", e);
        } finally {
            DBManager.close(pstmt, conn);
        }

        return count;
    }

    public List<Board> boardListForAdmin() {
        List<Board> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT TB_NUM, S_USER_ID, TB_TITLE, TO_CHAR(TB_REGDATE, 'YYYY.MM.DD') AS TB_REGDATE, S_PRICE ");
        sql.append("FROM S_BOARD ORDER BY TB_NUM DESC");

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Board board = new Board();
                board.setTbNum(rs.getLong("TB_NUM"));
                board.setUserId(rs.getString("S_USER_ID"));
                board.setTbTitle(rs.getString("TB_TITLE"));
                board.setRegDate(rs.getString("TB_REGDATE"));
                board.setPrice(rs.getLong("S_PRICE"));  // 🔹 추가
                list.add(board);
            }
        } catch (Exception e) {
            logger.error("[BoardDao] boardListForAdmin SQLException", e);
        } finally {
            DBManager.close(rs, pstmt, conn);
        }

        return list;
    }

    private long newBbsSeq(Connection conn) {
        long bbsSeq = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT USER_BOARD_SEQ.NEXTVAL FROM DUAL");

        try {
            pstmt = conn.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();
            if (rs.next()) {
                bbsSeq = rs.getLong(1);
            }
        } catch (Exception e) {
            logger.error("[BoardDao] newBbsSeq SQLException", e);
        } finally {
            DBManager.close(rs, pstmt);
        }

        return bbsSeq;
    }
}
