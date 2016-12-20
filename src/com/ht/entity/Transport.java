package com.ht.entity;

public class Transport {
    private Integer tid;

    private String tdrivername;

    private String tdriverphone;

    private String tvehicleid;

    private String tvehicletype;

    private Integer tvehiclecapacity;

    private String idcard;
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

    public String getTvehicleid() {
        return tvehicleid;
    }

    public void setTvehicleid(String tvehicleid) {
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
    
    public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
}