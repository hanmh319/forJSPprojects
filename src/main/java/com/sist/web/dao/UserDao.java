package com.sist.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sist.web.db.DBManager;
import com.sist.web.model.User;

public class UserDao {
private static Logger logger = LogManager.getLogger(UserDao.class);		//로그남기기위한용도
	
	//사용자 조회
	public User userSelect(String userId)
	{
		
		//초기값 세팅
		User user = null;						//사용자 정보를 담을 객체
		Connection conn = null;					//DB연결을 나타내는 객체
		PreparedStatement pstmt = null;			//SQL쿼리를 실행하기 위한 객체 (? 사용가능)
		ResultSet rs = null;					//SELECT 쿼리 결과를 저장하는 객체
		StringBuilder sql = new StringBuilder();//SQL쿼리문을 한줄씩 동적으로 붙이기 위해 사용하는 문자열 빌더
		
		sql.append("SELECT S_USER_ID, S_USER_PWD, S_USER_NAME, S_USER_EMAIL, S_USER_STATUS, S_USER_SELL, S_USER_REGDATE ");	
		sql.append("	FROM S_USER ");
		sql.append("	    WHERE S_USER_ID = ?");

		
		try
		{
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, userId);		
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				user = new User();
				user.setUserId(rs.getString("S_USER_ID"));
				user.setUserPwd(rs.getString("S_USER_PWD"));
				user.setUserName(rs.getString("S_USER_NAME"));
				user.setUserEmail(rs.getString("S_USER_EMAIL"));
				user.setStatus(rs.getString("S_USER_STATUS"));
				user.setSell(rs.getString("S_USER_SELL"));
				user.setRegDate(rs.getString("S_USER_REGDATE"));

			}
		}
		catch(Exception e)
		{
			logger.error("[UserDao_miniProject]userSelect SQLException", e);
		}
		finally
		{
			DBManager.close(rs, pstmt, conn);
			System.out.println("SQL문: " + sql.toString());
		}
		
		return user;
	}
	
	public int userInsert(User user) {
	    int result = 0;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    String sql = "INSERT INTO S_USER (S_USER_ID, S_USER_PWD, S_USER_NAME, S_USER_EMAIL, S_USER_STATUS, S_USER_SELL, S_USER_REGDATE) " +
	                 "VALUES (?, ?, ?, ?, 'Y', 'N', SYSDATE)";

	    try {
	        conn = DBManager.getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, user.getUserId());
	        pstmt.setString(2, user.getUserPwd());
	        pstmt.setString(3, user.getUserName());
	        pstmt.setString(4, user.getUserEmail());

	        result = pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBManager.close(pstmt, conn);
	    }
	    return result;
	}
	
	public int userIdSelectCount(String userId)
	{
		int count = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT COUNT(S_USER_ID) CNT ");
		sql.append("FROM S_USER ");
		sql.append("WHERE S_USER_ID = ? ");
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("CNT");
			}
		}
		catch(Exception e){
			logger.error("[UserDao_miniProject]userIdSelectCount SQLException", e);
		}
		finally {
			DBManager.close(rs, pstmt, conn);
		}
		return count;
		
	}
	
	// userList반환용
	
	public List<User> userList() {
	    List<User> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    StringBuilder sql = new StringBuilder();

	    sql.append("SELECT S_USER_ID, S_USER_NAME, S_USER_EMAIL, S_USER_STATUS, S_USER_SELL, S_USER_REGDATE ");
	    sql.append("FROM S_USER ");
	    sql.append("ORDER BY S_USER_REGDATE DESC");

	    try {
	        conn = DBManager.getConnection();
	        pstmt = conn.prepareStatement(sql.toString());
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            User user = new User();
	            user.setUserId(rs.getString("S_USER_ID"));
	            user.setUserName(rs.getString("S_USER_NAME"));
	            user.setUserEmail(rs.getString("S_USER_EMAIL"));
	            user.setStatus(rs.getString("S_USER_STATUS"));
	            user.setSell(rs.getString("S_USER_SELL"));
	            user.setRegDate(rs.getString("S_USER_REGDATE"));

	            list.add(user);
	        }
	    } catch (Exception e) {
	        logger.error("[UserDao_miniProject]userList SQLException", e);
	    } finally {
	        DBManager.close(rs, pstmt, conn);
	    }

	    return list;
	}
	
	// 개인정보수정이랑 관리자입장에서 상태변경하는것
	public int userUpdate(User user) {
	    int result = 0;
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    StringBuilder sql = new StringBuilder();
	    sql.append("UPDATE S_USER ");
	    sql.append("SET S_USER_NAME = ?, ");
	    sql.append("    S_USER_EMAIL = ?, ");
	    sql.append("    S_USER_STATUS = ?, ");
	    sql.append("    S_USER_SELL = ? ");
	    sql.append("WHERE S_USER_ID = ?");

	    try {
	        conn = DBManager.getConnection();
	        pstmt = conn.prepareStatement(sql.toString());
	        pstmt.setString(1, user.getUserName());
	        pstmt.setString(2, user.getUserEmail());
	        pstmt.setString(3, user.getStatus());
	        pstmt.setString(4, user.getSell());
	        pstmt.setString(5, user.getUserId());

	        result = pstmt.executeUpdate();
	    } catch (Exception e) {
	        logger.error("[UserDao_miniProject]userUpdate SQLException", e);
	    } finally {
	        DBManager.close(pstmt, conn);
	    }

	    return result;
	}
}
