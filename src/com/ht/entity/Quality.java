package com.ht.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 质检管理
 * 建于2016/12/15 9:09
 * @author 黄豪
 *
 */
public class Quality {
	private Integer eid;
	private Integer erid;
	private Integer egid;
	private Integer etid;
	private Integer euserid;
	private String eresult;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date edate;
	
	private sysuser sysusers; //员工
	
	private Goods goods;//货物
	
	private Receipt receipt;
	
	private Thelibrary thelibrary;

	public Integer getEid() {
		return eid;
	}

	public void setEid(Integer eid) {
		this.eid = eid;
	}

	public Integer getErid() {
		return erid;
	}

	public void setErid(Integer erid) {
		this.erid = erid;
	}

	public Integer getEgid() {
		return egid;
	}

	public Integer getEtid() {
		return etid;
	}

	public void setEtid(Integer etid) {
		this.etid = etid;
	}

	public void setEgid(Integer egid) {
		this.egid = egid;
	}

	public Integer getEuserid() {
		return euserid;
	}

	public void setEuserid(Integer euserid) {
		this.euserid = euserid;
	}

	public String getEresult() {
		return eresult;
	}

	public void setEresult(String eresult) {
		this.eresult = eresult == null ? null : eresult.trim();
	}
	
	public void setEdate(Date edate) {
		this.edate = edate;
	}

	public Date getEdate() {
		return edate;
	}

	public sysuser getSysusers() {
		return sysusers;
	}

	public void setSysusers(sysuser sysusers) {
		this.sysusers = sysusers;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Receipt getReceipt() {
		return receipt;
	}

	public void setReceipt(Receipt receipt) {
		this.receipt = receipt;
	}

	public Thelibrary getThelibrary() {
		return thelibrary;
	}

	public void setThelibrary(Thelibrary thelibrary) {
		this.thelibrary = thelibrary;
	}

	@Override
	public String toString() {
		return "Quality [eid=" + eid + ", erid=" + erid + ", egid=" + egid + ", etid=" + etid + ", euserid=" + euserid
				+ ", eresult=" + eresult + ", edate=" + edate + ", sysusers=" + sysusers + ", goods=" + goods
				+ ", receipt=" + receipt + ", thelibrary=" + thelibrary + "]";
	}
	
}
