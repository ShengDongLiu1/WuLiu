package com.ht.entity;

import java.util.Date;

public class Receipt {
    private Integer rid;

    private Integer rcid;

    private Integer rgid;
    
    private Integer reid;

    private Integer rreceivecount;

    private Integer rdamagedcount;

    private Integer rshelvecount;

    private Date rtdgoodstime;
    
    private Customer customer;	//客户
    
    private Goods goods;	//货物
    
    private sysuser user;	//员工

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public Integer getRcid() {
        return rcid;
    }

    public void setRcid(Integer rcid) {
        this.rcid = rcid;
    }

    public Integer getRgid() {
        return rgid;
    }

    public void setRgid(Integer rgid) {
        this.rgid = rgid;
    }

    public Integer getReid() {
		return reid;
	}

	public void setReid(Integer reid) {
		this.reid = reid;
	}

	public Integer getRreceivecount() {
        return rreceivecount;
    }

    public void setRreceivecount(Integer rreceivecount) {
        this.rreceivecount = rreceivecount;
    }

    public Integer getRdamagedcount() {
        return rdamagedcount;
    }

    public void setRdamagedcount(Integer rdamagedcount) {
        this.rdamagedcount = rdamagedcount;
    }

    public Integer getRshelvecount() {
        return rshelvecount;
    }

    public void setRshelvecount(Integer rshelvecount) {
        this.rshelvecount = rshelvecount;
    }

    public Date getRtdgoodstime() {
        return rtdgoodstime;
    }

    public void setRtdgoodstime(Date rtdgoodstime) {
        this.rtdgoodstime = rtdgoodstime;
    }

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public sysuser getUser() {
		return user;
	}

	public void setUser(sysuser user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Receipt [rid=" + rid + ", rcid=" + rcid + ", rgid=" + rgid + ", rreceivecount=" + rreceivecount
				+ ", rdamagedcount=" + rdamagedcount + ", rshelvecount=" + rshelvecount + ", rtdgoodstime="
				+ rtdgoodstime + "]";
	}
    
}