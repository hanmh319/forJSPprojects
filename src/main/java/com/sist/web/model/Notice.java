package com.sist.web.model;

public class Notice {
    private long notiNum;        // 공지번호
    private String adminId;      // 관리자 아이디
    private String notiTitle;    // 공지 제목
    private String notiContent;  // 공지 내용
    private int notiReadCnt;     // 조회수
    private String notiRegDate;  // 등록일

    public Notice() {}


    public long getNotiNum() {
        return notiNum;
    }

    public void setNotiNum(long notiNum) {
        this.notiNum = notiNum;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getNotiTitle() {
        return notiTitle;
    }

    public void setNotiTitle(String notiTitle) {
        this.notiTitle = notiTitle;
    }

    public String getNotiContent() {
        return notiContent;
    }

    public void setNotiContent(String notiContent) {
        this.notiContent = notiContent;
    }

    public int getNotiReadCnt() {
        return notiReadCnt;
    }

    public void setNotiReadCnt(int notiReadCnt) {
        this.notiReadCnt = notiReadCnt;
    }

    public String getNotiRegDate() {
        return notiRegDate;
    }

    public void setNotiRegDate(String notiRegDate) {
        this.notiRegDate = notiRegDate;
    }
}