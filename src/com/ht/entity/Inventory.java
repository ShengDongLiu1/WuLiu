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
}