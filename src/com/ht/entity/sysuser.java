package com.ht.entity;

public class sysuser {
    private Integer userid;

    private Integer roleid;
    
    private Sysrole sysrole;
    
    private String ujobnumber;
    
	private String username;
	
	private String usersex;
	
	private String userphone;
	
	private String uposition;

    private String userpwd;

    private String usertruename;

    private Integer userstate;
    
    //数据传输字段
    private String rolename;
    
    

    public String getRolename() {
		return rolename;
	}

	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

	public Integer getUserid() {
        return userid;
    }
    
    public Sysrole getSysrole() {
  		return sysrole;
  	}

  	public void setSysrole(Sysrole sysrole) {
  		this.sysrole = sysrole;
  	}

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getUserpwd() {
        return userpwd;
    }

    public void setUserpwd(String userpwd) {
        this.userpwd = userpwd == null ? null : userpwd.trim();
    }

    public String getUsertruename() {
        return usertruename;
    }

    public void setUsertruename(String usertruename) {
        this.usertruename = usertruename == null ? null : usertruename.trim();
    }

    public Integer getUserstate() {
        return userstate;
    }

    public void setUserstate(Integer userstate) {
        this.userstate = userstate;
    }

    
	public String getUjobnumber() {
		return ujobnumber;
	}

	public void setUjobnumber(String ujobnumber) {
		this.ujobnumber = ujobnumber;
	}

	public String getUsersex() {
		return usersex;
	}

	public void setUsersex(String usersex) {
		this.usersex = usersex;
	}

	public String getUserphone() {
		return userphone;
	}

	public void setUserphone(String userphone) {
		this.userphone = userphone;
	}

	public String getUposition() {
		return uposition;
	}

	public void setUposition(String uposition) {
		this.uposition = uposition;
	}

	@Override
	public String toString() {
		return "sysuser [userid=" + userid + ", roleid=" + roleid + ", sysrole=" + sysrole + ", username=" + username
				+ ", userpwd=" + userpwd + ", usertruename=" + usertruename + ", userstate=" + userstate + "]";
	}
    
    
}