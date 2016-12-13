package com.ht.entity;

public class Transport {
    private Integer tid;

    private String tdrivername;

    private String tdriverphone;

    private Integer tvehicleid;

    private String tvehicletype;

    private Integer tvehiclecapacity;

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public String getTdrivername() {
        return tdrivername;
    }

    public void setTdrivername(String tdrivername) {
        this.tdrivername = tdrivername == null ? null : tdrivername.trim();
    }

    public String getTdriverphone() {
        return tdriverphone;
    }

    public void setTdriverphone(String tdriverphone) {
        this.tdriverphone = tdriverphone == null ? null : tdriverphone.trim();
    }

    public Integer getTvehicleid() {
        return tvehicleid;
    }

    public void setTvehicleid(Integer tvehicleid) {
        this.tvehicleid = tvehicleid;
    }

    public String getTvehicletype() {
        return tvehicletype;
    }

    public void setTvehicletype(String tvehicletype) {
        this.tvehicletype = tvehicletype == null ? null : tvehicletype.trim();
    }

    public Integer getTvehiclecapacity() {
        return tvehiclecapacity;
    }

    public void setTvehiclecapacity(Integer tvehiclecapacity) {
        this.tvehiclecapacity = tvehiclecapacity;
    }
}