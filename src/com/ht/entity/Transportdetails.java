package com.ht.entity;

public class Transportdetails {
	
	private Integer shid;
	
	private Integer shgid;
	
	private Integer shtid;
	
	public Integer getShgid() {
		return shgid;
	}

	public void setShgid(Integer shgid) {
		this.shgid = shgid;
	}

	public Integer getShtid() {
		return shtid;
	}

	public void setShtid(Integer shtid) {
		this.shtid = shtid;
	}

	private Transport transport;
	
	private Goods  goods;
	
	private float travel;//行驶公里

	public Integer getShid() {
		return shid;
	}

	public void setShid(Integer shid) {
		this.shid = shid;
	}

	public Transport getTransport() {
		return transport;
	}

	public void setTransport(Transport transport) {
		this.transport = transport;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public float getTravel() {
		return travel;
	}

	public void setTravel(float travel) {
		this.travel = travel;
	}
	
	
	
}
