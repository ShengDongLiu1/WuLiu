package com.ht.entity;

public class Costtype {
    private Integer cid;

    private String cname;

    private Long cprice;

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname == null ? null : cname.trim();
    }

    public Long getCprice() {
        return cprice;
    }

    public void setCprice(Long cprice) {
        this.cprice = cprice;
    }
}