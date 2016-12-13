package com.ht.entity;

public class Sysfunction {
	/**
	 * 系统功能ID
	 */
    private Integer funid;
    /**
  	 * 系统功能名称
  	 */
    private String funname;
    /**
   	 * 功能地址
   	 */
    private String funurl;
    /**
   	 * 父功能ID
   	 */
    private Integer funpid;
    /**
   	 * 功能状态
   	 */
    private Integer funstate;
    
    
    /** 数据传输字段
     * 功能连接
     */
    private Integer rr;
    
    /**数据传输字段
  	 *  父功能名称
  	 */
    private String funpname;
    

    public String getFunpname() {
		return funpname;
	}

	public void setFunpname(String funpname) {
		this.funpname = funpname;
	}

	public Integer getRr() {
		return rr;
	}

	public void setRr(Integer rr) {
		this.rr = rr;
	}

	public Integer getFunid() {
        return funid;
    }

    public void setFunid(Integer funid) {
        this.funid = funid;
    }

    public String getFunname() {
        return funname;
    }

    public void setFunname(String funname) {
        this.funname = funname == null ? null : funname.trim();
    }

    public String getFunurl() {
        return funurl;
    }

    public void setFunurl(String funurl) {
        this.funurl = funurl == null ? null : funurl.trim();
    }

    public Integer getFunpid() {
        return funpid;
    }

    public void setFunpid(Integer funpid) {
        this.funpid = funpid;
    }

    public Integer getFunstate() {
        return funstate;
    }

    public void setFunstate(Integer funstate) {
        this.funstate = funstate;
    }

	@Override
	public String toString() {
		return "Sysfunction [funid=" + funid + ", funname=" + funname + ", funurl=" + funurl + ", funpid=" + funpid
				+ ", funstate=" + funstate + ", rr=" + rr + ", funpname=" + funpname + "]";
	}

    
    
}