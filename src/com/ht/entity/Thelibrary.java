package com.ht.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Thelibrary {
    private Integer tid;

    private Integer tgid;//货物编号

    private Integer ttid;//承运编号

    private Integer tcount;//出库数量
    
    private Integer tstate;//出库状态

    private String ttype;//出库类型
   
    private String remarks;//出库备注
    
    private String tnumber;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd mm ss")  
    private Date gorderstime1;

    @DateTimeFormat(pattern = "yyyy-MM-dd")  
    private Date ttime;//出库时间
    
    
    private Goods goods;//货物
    
    private Customer customer;
    
    private Transport transport;
    
    private Receipt receipt;
    
    private Storage storage;
    
    private Inventory inventory;
    
    
    public Receipt getReceipt() {
		return receipt;
	}

	public void setReceipt(Receipt receipt) {
		this.receipt = receipt;
	}

	public Storage getStorage() {
		return storage;
	}

	public void setStorage(Storage storage) {
		this.storage = storage;
	}

	public Inventory getInventory() {
		return inventory;
	}

	public void setInventory(Inventory inventory) {
		this.inventory = inventory;
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
    public Transport getTransport() {
		return transport;
	}
    
    public void setTransport(Transport transport) {
		this.transport = transport;
	}

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public Integer gettgid() {
        return tgid;
    }

    public void settgid(Integer tgid) {
        this.tgid = tgid;
    }


    public Integer getTtid() {
        return ttid;
    }

    public void setTtid(Integer ttid) {
        this.ttid = ttid;
    }

    public Integer getTcount() {
        return tcount;
    }

    public void setTcount(Integer tcount) {
        this.tcount = tcount;
    }

    public String getTtype() {
        return ttype;
    }

    public void setTtype(String ttype) {
        this.ttype = ttype == null ? null : ttype.trim();
    }

    public Date getTtime() {
        return ttime;
    }

    public void setTtime(Date ttime) {
        this.ttime = ttime;
    }
    
    
    public String getRemarks() {
		return remarks;
	}
    public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
    
    public Integer getTgid() {
		return tgid;
	}
    
    
    public void setTgid(Integer tgid) {
		this.tgid = tgid;
	}
    
    
    public Integer getTstate() {
		return tstate;
	}
    
    
    public void setTstate(Integer tstate) {
		this.tstate = tstate;
	}
    
    public String getTnumber() {
		return tnumber;
	}
    
    public void setTnumber(String tnumber) {
		this.tnumber = tnumber;
	}
    
    public Date getGorderstime1() {
		return gorderstime1;
	}
    
    public void setGorderstime1(Date gorderstime1) {
		this.gorderstime1 = gorderstime1;
	}
    
    
}