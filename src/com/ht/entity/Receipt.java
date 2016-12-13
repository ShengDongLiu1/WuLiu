package com.ht.entity;

import java.util.Date;

public class Receipt {
    private Integer rid;

    private Integer rcid;

    private Integer rgid;

    private Integer rreceivecount;

    private Integer rdamagedcount;

    private Integer rshelvecount;

    private Date rtdgoodstime;

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public Integer getRcid() {
        return rcid;
    }

    public void setRcid(Integer rcid) {
        this.rcid = rcid;
    }

    public Integer getRgid() {
        return rgid;
    }

    public void setRgid(Integer rgid) {
        this.rgid = rgid;
    }

    public Integer getRreceivecount() {
        return rreceivecount;
    }

    public void setRreceivecount(Integer rreceivecount) {
        this.rreceivecount = rreceivecount;
    }

    public Integer getRdamagedcount() {
        return rdamagedcount;
    }

    public void setRdamagedcount(Integer rdamagedcount) {
        this.rdamagedcount = rdamagedcount;
    }

    public Integer getRshelvecount() {
        return rshelvecount;
    }

    public void setRshelvecount(Integer rshelvecount) {
        this.rshelvecount = rshelvecount;
    }

    public Date getRtdgoodstime() {
        return rtdgoodstime;
    }

    public void setRtdgoodstime(Date rtdgoodstime) {
        this.rtdgoodstime = rtdgoodstime;
    }
}