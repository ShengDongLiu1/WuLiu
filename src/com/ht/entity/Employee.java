package com.ht.entity;

public class Employee {
    private Integer eid;

    private String ejobnumber;

    private String ename;

    private String esex;

    private Integer eage;

    private String eposition;

    private String ephone;

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    public String getEjobnumber() {
        return ejobnumber;
    }

    public void setEjobnumber(String ejobnumber) {
        this.ejobnumber = ejobnumber == null ? null : ejobnumber.trim();
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename == null ? null : ename.trim();
    }

    public String getEsex() {
        return esex;
    }

    public void setEsex(String esex) {
        this.esex = esex == null ? null : esex.trim();
    }

    public Integer getEage() {
        return eage;
    }

    public void setEage(Integer eage) {
        this.eage = eage;
    }

    public String getEposition() {
        return eposition;
    }

    public void setEposition(String eposition) {
        this.eposition = eposition == null ? null : eposition.trim();
    }

    public String getEphone() {
        return ephone;
    }

    public void setEphone(String ephone) {
        this.ephone = ephone == null ? null : ephone.trim();
    }
}