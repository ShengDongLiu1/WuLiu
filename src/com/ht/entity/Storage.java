package com.ht.entity;

import java.util.Date;

public class Storage {
    private Integer sid;

    private Integer srid;

    private Integer scid;

    private Integer sgid;

    private Integer ssbid;

    private Integer storagecount;

    private String storagemode;

    private String storagebarcode;

    private String sbarcadeid;

    private Date storagetime;

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
}