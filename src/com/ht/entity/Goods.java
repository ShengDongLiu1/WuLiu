package com.ht.entity;

import java.util.Date;

public class Goods {
    private Integer gid;

    private Integer gcid;

    private String gordernumber;

    private String gname;

    private Integer gcount;

    private String gunit;

    private Float gweight;

    private Float gvolume;

    private Float gsize;

    private Integer ggrade;

    private String gdescribe;

    private String gconsignee;

    private String greaddress;

    private String grephone;

    private String gorigin;

    private String gendpoint;

    private String gstate;

    private Date gorderstime;
    
    private String gocause;
    
    private Customer customer;	//	客户

    public Integer getGid() {
        return gid;
    }

    public void setGid(Integer gid) {
        this.gid = gid;
    }

    public Integer getGcid() {
        return gcid;
    }

    public void setGcid(Integer gcid) {
        this.gcid = gcid;
    }

    public String getGordernumber() {
        return gordernumber;
    }

    public void setGordernumber(String gordernumber) {
        this.gordernumber = gordernumber == null ? null : gordernumber.trim();
    }

    public String getGname() {
        return gname;
    }

    public void setGname(String gname) {
        this.gname = gname == null ? null : gname.trim();
    }

    public Integer getGcount() {
        return gcount;
    }

    public void setGcount(Integer gcount) {
        this.gcount = gcount;
    }

    public String getGunit() {
        return gunit;
    }

    public void setGunit(String gunit) {
        this.gunit = gunit == null ? null : gunit.trim();
    }

    public Float getGweight() {
        return gweight;
    }

    public void setGweight(Float gweight) {
        this.gweight = gweight;
    }

    public Float getGvolume() {
        return gvolume;
    }

    public void setGvolume(Float gvolume) {
        this.gvolume = gvolume;
    }

    public Float getGsize() {
        return gsize;
    }

    public void setGsize(Float gsize) {
        this.gsize = gsize;
    }

    public Integer getGgrade() {
        return ggrade;
    }

    public void setGgrade(Integer ggrade) {
        this.ggrade = ggrade;
    }

    public String getGdescribe() {
        return gdescribe;
    }

    public void setGdescribe(String gdescribe) {
        this.gdescribe = gdescribe == null ? null : gdescribe.trim();
    }

    public String getGconsignee() {
        return gconsignee;
    }

    public void setGconsignee(String gconsignee) {
        this.gconsignee = gconsignee == null ? null : gconsignee.trim();
    }

    public String getGreaddress() {
        return greaddress;
    }

    public void setGreaddress(String greaddress) {
        this.greaddress = greaddress == null ? null : greaddress.trim();
    }

    public String getGrephone() {
        return grephone;
    }

    public void setGrephone(String grephone) {
        this.grephone = grephone == null ? null : grephone.trim();
    }

    public String getGorigin() {
        return gorigin;
    }

    public void setGorigin(String gorigin) {
        this.gorigin = gorigin == null ? null : gorigin.trim();
    }

    public String getGendpoint() {
        return gendpoint;
    }

    public void setGendpoint(String gendpoint) {
        this.gendpoint = gendpoint == null ? null : gendpoint.trim();
    }

    public String getGstate() {
        return gstate;
    }

    public void setGstate(String gstate) {
        this.gstate = gstate == null ? null : gstate.trim();
    }

    public Date getGorderstime() {
        return gorderstime;
    }

    public void setGorderstime(Date gorderstime) {
        this.gorderstime = gorderstime;
    }

	public String getGocause() {
		return gocause;
	}

	public void setGocause(String gocause) {
		this.gocause = gocause;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	@Override
	public String toString() {
		return "Goods [gid=" + gid + ", gcid=" + gcid + ", gordernumber=" + gordernumber + ", gname=" + gname
				+ ", gcount=" + gcount + ", gunit=" + gunit + ", gweight=" + gweight + ", gvolume=" + gvolume
				+ ", gsize=" + gsize + ", ggrade=" + ggrade + ", gdescribe=" + gdescribe + ", gconsignee=" + gconsignee
				+ ", greaddress=" + greaddress + ", grephone=" + grephone + ", gorigin=" + gorigin + ", gendpoint="
				+ gendpoint + ", gstate=" + gstate + ", gorderstime=" + gorderstime + ", gocause=" + gocause
				+ ", customer=" + customer + "]";
	}
}