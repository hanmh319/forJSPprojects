package com.sist.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sist.web.db.DBManager;
import com.sist.web.model.Admin;

public class AdminDao {
    private static Logger logger = LogManager.getLogger(AdminDao.class);

    // 관리자 조회
    public Admin adminSelect(String adminId) {
        Admin admin = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT S_ADMIN_ID, S_ADMIN_PWD, S_ADMIN_NAME, S_ADMIN_EMAIL, S_ADMIN_REGDATE ");
        sql.append("FROM S_ADMIN ");
        sql.append("WHERE S_ADMIN_ID = ?");

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            pstmt.setString(1, adminId);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                admin = new Admin();
                admin.setAdminId(rs.getString("S_ADMIN_ID"));
                admin.setAdminPwd(rs.getString("S_ADMIN_PWD"));
                admin.setAdminName(rs.getString("S_ADMIN_NAME"));
                admin.setAdminEmail(rs.getString("S_ADMIN_EMAIL"));
                admin.setAdminRegDate(rs.getString("S_ADMIN_REGDATE"));
            }
        } catch (Exception e) {
            logger.error("[AdminDao] adminSelect SQLException", e);
        } finally {
            DBManager.close(rs, pstmt, conn);
        }

        return admin;
    }

    // 관리자 등록
    public int adminInsert(Admin admin) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;

        String sql = "INSERT INTO S_ADMIN (S_ADMIN_ID, S_ADMIN_PWD, S_ADMIN_NAME, S_ADMIN_EMAIL, S_ADMIN_REGDATE) " +
                     "VALUES (?, ?, ?, ?, SYSDATE)";

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, admin.getAdminId());
            pstmt.setString(2, admin.getAdminPwd());
            pstmt.setString(3, admin.getAdminName());
            pstmt.setString(4, admin.getAdminEmail());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            logger.error("[AdminDao] adminInsert SQLException", e);
        } finally {
            DBManager.close(pstmt, conn);
        }

        return result;
    }

    // 관리자 ID 존재 여부 확인
    public int adminIdSelectCount(String adminId) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(S_ADMIN_ID) CNT ");
        sql.append("FROM S_ADMIN ");
        sql.append("WHERE S_ADMIN_ID = ?");

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            pstmt.setString(1, adminId);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("CNT");
            }
        } catch (Exception e) {
            logger.error("[AdminDao] adminIdSelectCount SQLException", e);
        } finally {
            DBManager.close(rs, pstmt, conn);
        }

        return count;
    }
}
