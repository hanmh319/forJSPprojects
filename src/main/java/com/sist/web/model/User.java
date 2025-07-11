package com.sist.web.model;

import java.io.Serializable;

public class User implements Serializable {



	private static final long serialVersionUID = -4813109506406461490L;
	
	
	private String userId;		//사용자 아이디
	private String userPwd;		//비밀번호
	private String userName;	//사용자명
	private String userEmail;	//사용자이메일
	private String status;		//상태(Y:사용, N:정지)
	private String sell;		//판매자여부
	public String getSell() {
		return sell;
	}

	public void setSell(String sell) {
		this.sell = sell;
	}

	private String regDate;		//가입일
	
	//생성자 (값 초기화)
	public User()
	{
		userId = "";
		userPwd = "";
		userName = "";
		userEmail = "";
		status = "Y";
		sell = "N";
		regDate = "";
	}
	
	//getter-setter
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
}
