package com.ht.entity;

import java.util.Date;

public class Goods {
    private Integer sid;

    private String sgoodsname;

    private String sgoodstype;

    private Float sgoodsweight;

    private Float sgoodsacreage;

    private String sgoodsstate;

    private String sgoodsregion;

    private Date sgoodstime;

    private Integer eid;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getSgoodsname() {
        return sgoodsname;
    }

    public void setSgoodsname(String sgoodsname) {
        this.sgoodsname = sgoodsname == null ? null : sgoodsname.trim();
    }

    public String getSgoodstype() {
        return sgoodstype;
    }

    public void setSgoodstype(String sgoodstype) {
        this.sgoodstype = sgoodstype == null ? null : sgoodstype.trim();
    }

    public Float getSgoodsweight() {
        return sgoodsweight;
    }

    public void setSgoodsweight(Float sgoodsweight) {
        this.sgoodsweight = sgoodsweight;
    }

    public Float getSgoodsacreage() {
        return sgoodsacreage;
    }

    public void setSgoodsacreage(Float sgoodsacreage) {
        this.sgoodsacreage = sgoodsacreage;
    }

    public String getSgoodsstate() {
        return sgoodsstate;
    }

    public void setSgoodsstate(String sgoodsstate) {
        this.sgoodsstate = sgoodsstate == null ? null : sgoodsstate.trim();
    }

    public String getSgoodsregion() {
        return sgoodsregion;
    }

    public void setSgoodsregion(String sgoodsregion) {
        this.sgoodsregion = sgoodsregion == null ? null : sgoodsregion.trim();
    }

    public Date getSgoodstime() {
        return sgoodstime;
    }

    public void setSgoodstime(Date sgoodstime) {
        this.sgoodstime = sgoodstime;
    }

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }
}