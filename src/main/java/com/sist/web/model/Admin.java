package com.sist.web.model;

public class Admin {
    private String adminId;
    private String adminPwd;
    private String adminName;
    private String adminEmail;
    private String adminRegDate;

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getAdminPwd() {
        return adminPwd;
    }

    public void setAdminPwd(String adminPwd) {
        this.adminPwd = adminPwd;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminEmail() {
        return adminEmail;
    }

    public void setAdminEmail(String adminEmail) {
        this.adminEmail = adminEmail;
    }

    public String getAdminRegDate() {
        return adminRegDate;
    }

    public void setAdminRegDate(String adminRegDate) {
        this.adminRegDate = adminRegDate;
    }
}
