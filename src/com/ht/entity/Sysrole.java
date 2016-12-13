package com.ht.entity;

public class Sysrole {
    private Integer roleid;

    private String rolename;

    private Integer rolestate;

    private String roledesc;

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename == null ? null : rolename.trim();
    }

    public Integer getRolestate() {
        return rolestate;
    }

    public void setRolestate(Integer rolestate) {
        this.rolestate = rolestate;
    }

    public String getRoledesc() {
        return roledesc;
    }

    public void setRoledesc(String roledesc) {
        this.roledesc = roledesc == null ? null : roledesc.trim();
    }

	@Override
	public String toString() {
		return "Sysrole [roleid=" + roleid + ", rolename=" + rolename + ", rolestate=" + rolestate + ", roledesc="
				+ roledesc + "]";
	}
    
    
}