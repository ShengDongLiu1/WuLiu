package com.ht.entity;

import java.util.Date;

public class Complaints {
    private Integer comid;

    private String comtype;

    private String comcusid;

    private String comtitle;

    private Date comtime;

    private String comlevel;

    private String comsysuser;

    private String comcontent;

    private String comexpect;

    private String comdescr;

    private Customer customer;
    
    private sysuser sysuser;
    
    public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public sysuser getSysuser() {
		return sysuser;
	}

	public void setSysuser(sysuser sysuser) {
		this.sysuser = sysuser;
	}

	public Integer getComid() {
        return comid;
    }

    public void setComid(Integer comid) {
        this.comid = comid;
    }

    public String getComtype() {
        return comtype;
    }

    public void setComtype(String comtype) {
        this.comtype = comtype == null ? null : comtype.trim();
    }

    public String getComcusid() {
        return comcusid;
    }

    public void setComcusid(String comcusid) {
        this.comcusid = comcusid;
    }

    public String getComtitle() {
        return comtitle;
    }

    public void setComtitle(String comtitle) {
        this.comtitle = comtitle == null ? null : comtitle.trim();
    }

    public Date getComtime() {
        return comtime;
    }

    public void setComtime(Date comtime) {
        this.comtime = comtime;
    }

    public String getComlevel() {
        return comlevel;
    }

    public void setComlevel(String comlevel) {
        this.comlevel = comlevel == null ? null : comlevel.trim();
    }

    public String getComsysuser() {
        return comsysuser;
    }

    public void setComsysuser(String comsysuser) {
        this.comsysuser = comsysuser;
    }

    public String getComcontent() {
        return comcontent;
    }

    public void setComcontent(String comcontent) {
        this.comcontent = comcontent == null ? null : comcontent.trim();
    }

    public String getComexpect() {
        return comexpect;
    }

    public void setComexpect(String comexpect) {
        this.comexpect = comexpect == null ? null : comexpect.trim();
    }

    public String getComdescr() {
        return comdescr;
    }

    public void setComdescr(String comdescr) {
        this.comdescr = comdescr == null ? null : comdescr.trim();
    }
}