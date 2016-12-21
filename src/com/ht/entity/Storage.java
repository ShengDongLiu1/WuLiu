package com.ht.entity;

import java.util.Date;

public class Storage {
    private Integer sid;

    private Integer srid;

    private Integer scid;

    private Integer sgid;

    private Integer ssbid;
    
    private Integer seid;
    
    private Integer sstock;

    private Integer storagecount;

    private String storagemode;

    private String storagebarcode;

    private String sbarcadeid;

    private Date storagetime;
    
    private Customer customer;	//客户
    
    private Goods goods;	//货物
    
    private Inventory inventory;	//库位
    
    private sysuser user;	//员工

    
    public Integer getSstock() {
		return sstock;
	}
    
    public void setSstock(Integer sstock) {
		this.sstock = sstock;
	}
    
    public Integer getSid() {
        return sid;
    }

    
    
    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getSrid() {
        return srid;
    }

    public void setSrid(Integer srid) {
        this.srid = srid;
    }

    public Integer getScid() {
        return scid;
    }

    public void setScid(Integer scid) {
        this.scid = scid;
    }

    public Integer getSgid() {
        return sgid;
    }

    public void setSgid(Integer sgid) {
        this.sgid = sgid;
    }

    public Integer getSsbid() {
        return ssbid;
    }

    public void setSsbid(Integer ssbid) {
        this.ssbid = ssbid;
    }

    public Integer getSeid() {
		return seid;
	}

	public void setSeid(Integer seid) {
		this.seid = seid;
	}

	public Integer getStoragecount() {
        return storagecount;
    }

    public void setStoragecount(Integer storagecount) {
        this.storagecount = storagecount;
    }

    public String getStoragemode() {
        return storagemode;
    }

    public void setStoragemode(String storagemode) {
        this.storagemode = storagemode == null ? null : storagemode.trim();
    }

    public String getStoragebarcode() {
        return storagebarcode;
    }

    public void setStoragebarcode(String storagebarcode) {
        this.storagebarcode = storagebarcode == null ? null : storagebarcode.trim();
    }

    public String getSbarcadeid() {
        return sbarcadeid;
    }

    public void setSbarcadeid(String sbarcadeid) {
        this.sbarcadeid = sbarcadeid == null ? null : sbarcadeid.trim();
    }

    public Date getStoragetime() {
        return storagetime;
    }

    public void setStoragetime(Date storagetime) {
        this.storagetime = storagetime;
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

	public Inventory getInventory() {
		return inventory;
	}

	public void setInventory(Inventory inventory) {
		this.inventory = inventory;
	}

	public sysuser getUser() {
		return user;
	}

	public void setUser(sysuser user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Storage [sid=" + sid + ", srid=" + srid + ", scid=" + scid + ", sgid=" + sgid + ", ssbid=" + ssbid
				+ ", storagecount=" + storagecount + ", storagemode=" + storagemode + ", storagebarcode="
				+ storagebarcode + ", sbarcadeid=" + sbarcadeid + ", storagetime=" + storagetime + "]";
	}
    
}