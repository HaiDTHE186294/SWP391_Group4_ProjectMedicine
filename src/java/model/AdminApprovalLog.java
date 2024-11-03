/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class AdminApprovalLog {
    private String approvalID;
    private String pid;
    private String action;
    private int status;
    private String detail;
    private int decider;
    private String date;
    private String pName;

    public AdminApprovalLog() {
    }

    public AdminApprovalLog(String approvalID, String pid, String action, int status, String detail, int decider, String pName) {
        this.approvalID = approvalID;
        this.pid = pid;
        this.action = action;
        this.status = status;
        this.detail = detail;
        this.decider = decider;
        this.pName = pName;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    
    public String getApprovalID() {
        return approvalID;
    }

    public void setApprovalID(String approvalID) {
        this.approvalID = approvalID;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public int getDecider() {
        return decider;
    }

    public void setDecider(int decider) {
        this.decider = decider;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }
    
    

    // Optional: Override toString for easier debugging
    @Override
    public String toString() {
        return "AdminApprovalLog{" +
                "approvalID='" + approvalID + '\'' +
                ", pid='" + pid + '\'' +
                ", action='" + action + '\'' +
                ", status=" + status +
                ", detail='" + detail + '\'' +
                ", decider=" + decider +
                '}';
    }
}
