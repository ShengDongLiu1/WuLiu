package com.ht.entity;

import java.util.Date;

public class Transfer {
    private Integer tid;

    private Integer tgid;

    private Integer teid;

    private String treason;

    private Date tdate;

    private Goods goods;
    
    private sysuser sys;
    
    public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public sysuser getSys() {
		return sys;
	}

	public void setSys(sysuser sys) {
		this.sys = sys;
	}

	public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public Integer getTgid() {
        return tgid;
    }

    public void setTgid(Integer tgid) {
        this.tgid = tgid;
    }

    public Integer getTeid() {
        return teid;
    }

    public void setTeid(Integer teid) {
        this.teid = teid;
    }

    public String getTreason() {
        return treason;
    }

    public void setTreason(String treason) {
        this.treason = treason == null ? null : treason.trim();
    }

    public Date getTdate() {
        return tdate;
    }

    public void setTdate(Date tdate) {
        this.tdate = tdate;
    }
}