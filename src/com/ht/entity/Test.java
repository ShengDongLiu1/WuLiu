package com.ht.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Test {
	private Integer tid;
	
	private String tname;
	
	private String tsex;
	
	private String tmes;
	
	@DateTimeFormat(pattern="yyyy-MM-dd hh:mm:ss")
	private Date tdate;

	public Integer getTid() {
		return tid;
	}

	public void setTid(Integer tid) {
		this.tid = tid;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public String getTsex() {
		return tsex;
	}

	public void setTsex(String tsex) {
		this.tsex = tsex;
	}

	public String getTmes() {
		return tmes;
	}

	public void setTmes(String tmes) {
		this.tmes = tmes;
	}

	public Date getTdate() {
		return tdate;
	}

	public void setTdate(Date tdate) {
		this.tdate = tdate;
	}

}
