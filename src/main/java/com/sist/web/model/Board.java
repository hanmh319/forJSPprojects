package com.sist.web.model;

public class Board {
	private long tbNum;
	private String userId;
	private String tbTitle;
	private String tbContent;
	private long tbReadCnt;
	private String regDate;
	private String imagePath;
	private long price;
	
	public long getPrice() {
		return price;
	}

	public void setPrice(long price) {
		this.price = price;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getTbContent() {
		return tbContent;
	}

	public void setTbContent(String tbContent) {
		this.tbContent = tbContent;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}
	private long startRow;
	private long endRow;
	public Board()
	{
		tbNum = 0;
		userId = "";
		tbTitle = "";
		tbContent = "";
		tbReadCnt =0;
		regDate = "";
		imagePath = "";
		
		startRow = 0;
		endRow = 0;
	}
	
	public long getTbNum() {
		return tbNum;
	}
	public void setTbNum(long tbNum) {
		this.tbNum = tbNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTbTitle() {
		return tbTitle;
	}
	public void setTbTitle(String tbTitle) {
		this.tbTitle = tbTitle;
	}

	public long getTbReadCnt() {
		return tbReadCnt;
	}
	public void setTbReadCnt(long tbReadCnt) {
		this.tbReadCnt = tbReadCnt;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public void setPaging(long currentPage, long pageSize) {
			this.startRow = (currentPage - 1 ) * pageSize + 1;
			this.endRow = currentPage * pageSize;
	}
	
		
}
