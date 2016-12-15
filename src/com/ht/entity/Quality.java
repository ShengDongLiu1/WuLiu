package com.ht.entity;

import java.util.Date;

/**
 * 质检管理
 * 建于2016/12/15 9:09
 * @author 黄豪
 *
 */
public class Quality {
	private int eid;
	private int egid;
	private int eeid;
	private String eresult;
	private Date edate;

	public int getEid() {
		return eid;
	}

	public void setEid(int eid) {
		this.eid = eid;
	}

	public int getEgid() {
		return egid;
	}

	public void setEgid(int egid) {
		this.egid = egid;
	}

	public int getEeid() {
		return eeid;
	}

	public void setEeid(int eeid) {
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

	@Override
	public String toString() {
		return "Quality [eid=" + eid + ", egid=" + egid + ", eeid=" + eeid + ", eresult=" + eresult + ", edate=" + edate
				+ "]";
	}
	
	

}
