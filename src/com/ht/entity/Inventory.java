package com.ht.entity;

public class Inventory {
    private Integer loid;

    private Integer logid;

    private String loname;

    private Double losize;

    private Double lovolume;

    private Double loweight;

    private Integer lolevel;

    private Integer lostate;
    
    private Double losizes;

    private Double lovolumes;

    private Double loweights;

   
	private Goods goods;	//货物
    
    public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Integer getLoid() {
        return loid;
    }

    public void setLoid(Integer loid) {
        this.loid = loid;
    }

    public Integer getLogid() {
        return logid;
    }

    public void setLogid(Integer logid) {
        this.logid = logid;
    }

    public String getLoname() {
        return loname;
    }

    public void setLoname(String loname) {
        this.loname = loname == null ? null : loname.trim();
    }

    public Double getLosize() {
        return losize;
    }

    public void setLosize(Double losize) {
        this.losize = losize;
    }

    public Double getLovolume() {
        return lovolume;
    }

    public void setLovolume(Double lovolume) {
        this.lovolume = lovolume;
    }

    public Double getLoweight() {
        return loweight;
    }

    public void setLoweight(Double loweight) {
        this.loweight = loweight;
    }

    public Integer getLolevel() {
        return lolevel;
    }

    public void setLolevel(Integer lolevel) {
        this.lolevel = lolevel;
    }

    public Integer getLostate() {
        return lostate;
    }

    public void setLostate(Integer lostate) {
        this.lostate = lostate;
    }
    public Double getLosizes() {
		return losizes;
	}

	public void setLosizes(Double losizes) {
		this.losizes = losizes;
	}

	public Double getLovolumes() {
		return lovolumes;
	}

	public void setLovolumes(Double lovolumes) {
		this.lovolumes = lovolumes;
	}

	public Double getLoweights() {
		return loweights;
	}

	public void setLoweights(Double loweights) {
		this.loweights = loweights;
	}

}