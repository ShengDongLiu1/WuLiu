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
	private Integer egid;
	private Integer eeid;
	private String eresult;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date edate;
	
	private Employee employee; //员工
	
	private Goods goods;//货物

	public Integer getEid() {
		return eid;
	}

	public void setEid(Integer eid) {
		this.eid = eid;
	}

	public Integer getEgid() {
		return egid;
	}

	public void setEgid(Integer egid) {
		this.egid = egid;
	}

	public Integer getEeid() {
		return eeid;
	}

	public void setEeid(Integer eeid) {
		this.eeid = eeid;
	}

	public String getEresult() {
		return eresult;
	}

	public void setEresult(String eresult) {
		this.eresult = eresult == null ? null : eresult.trim();
	}
	
	public Date getEdate() {
		return edate;
	}

	public void setEdate(Date edate) {
		this.edate = edate;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

}
